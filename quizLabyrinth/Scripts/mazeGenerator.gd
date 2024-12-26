extends Node3D

@export var mazeTemplate: mazeData

@export var WallPrefab: PackedScene
@export var Player: Node3D
@export var salas = []

var largura = 15
var altura = 15
var labirinto = []

func _ready():
	if mazeTemplate != null :
		largura = mazeTemplate.largura
		altura = mazeTemplate.altura
	
	labirinto = []
	for i in range(altura):
		labirinto.append([])
		for j in range(largura):
			labirinto[i].append(1) # 1 = parede
	# 2 = inicio
	gerar_labirinto(1, 1)

	# 3 = fim
	colocar_fim()

	marcar_caminho()

	for linha in labirinto:
		print(linha)

	call_deferred("gerar_paredes_3D")
	call_deferred("transportar_player")

func gerar_labirinto(x, y):
	var direcoes = [Vector2(0, -1), Vector2(1, 0), Vector2(0, 1), Vector2(-1, 0)]
	direcoes.shuffle()

	for direcao in direcoes:
		var nx = x + direcao.x * 2
		var ny = y + direcao.y * 2

		if nx > 0 and nx < largura - 1 and ny > 0 and ny < altura - 1 and labirinto[ny][nx] == 1:
			labirinto[y + direcao.y][x + direcao.x] = 0
			labirinto[ny][nx] = 0
			gerar_labirinto(nx, ny)
	labirinto[1][1] = 2

func colocar_fim():
	var max_distance = 0
	var fim_pos = Vector2(0, 0)
	var inicio = Vector2(1, 1)

	for y in range(altura):
		for x in range(largura):
			if labirinto[y][x] == 0:
				var adj_walls = 0
				if labirinto[y - 1][x] == 1:
					adj_walls += 1
				if labirinto[y + 1][x] == 1:
					adj_walls += 1
				if labirinto[y][x - 1] == 1:
					adj_walls += 1
				if labirinto[y][x + 1] == 1:
					adj_walls += 1
				
				if adj_walls == 3:
					var distance = abs(x - inicio.x) + abs(y - inicio.y)
					if distance > max_distance:
						max_distance = distance
						fim_pos = Vector2(x, y)

	labirinto[fim_pos.y][fim_pos.x] = 3


func marcar_caminho():
	var inicio = Vector2(1, 1)
	var fim = buscar_fim()
	var caminho = bfs(inicio, fim)

	for pos in caminho:
		if labirinto[pos.y][pos.x] == 0:
			labirinto[pos.y][pos.x] = 4

func buscar_fim():
	for y in range(altura):
		for x in range(largura):
			if labirinto[y][x] == 3:
				return Vector2(x, y)
	return Vector2(0, 0)  # Fallback

func bfs(inicio: Vector2, fim: Vector2):
	var fila = []
	var visitado = []
	var anterior = {}
	
	for y in range(altura):
		visitado.append([])
		for x in range(largura):
			visitado[y].append(false)
	
	fila.append(inicio)
	visitado[inicio.y][inicio.x] = true
	anterior[inicio] = null
	
	while fila.size() > 0:
		var atual = fila.pop_front()
		
		if atual == fim:
			break
		
		var direcoes = [Vector2(0, -1), Vector2(1, 0), Vector2(0, 1), Vector2(-1, 0)]
		for direcao in direcoes:
			var nx = atual.x + direcao.x
			var ny = atual.y + direcao.y
			var proximo = Vector2(nx, ny)
			
			if nx >= 0 and ny >= 0 and nx < largura and ny < altura:
				if not visitado[ny][nx] and labirinto[ny][nx] != 1:
					fila.append(proximo)
					visitado[ny][nx] = true
					anterior[proximo] = atual
	
	var caminho = []
	var passo = fim
	while passo != null:
		caminho.append(passo)
		passo = anterior[passo]
	
	# Inverter o caminho manualmente
	var caminho_invertido = []
	for i in range(caminho.size() - 1, -1, -1):
		caminho_invertido.append(caminho[i])
	
	return caminho_invertido

func gerar_paredes_3D():
	var cell_size = 80.0 # Tamanho de cada célula
	for y in range(altura):
		for x in range(largura):
			var is_wall = labirinto[y][x] == 1
			var sala_instance = SALA.new(Vector3(x * cell_size, 0, y * cell_size), is_wall)
			salas.append(sala_instance)
			
			if labirinto[y][x] == 1:
				var wall_instance = WallPrefab.instantiate()
				add_child(wall_instance)
				wall_instance.global_transform.origin = Vector3(x * cell_size, 0, y * cell_size)
				wall_instance.scale = Vector3(100, 100, 100) # Ajusta a escala da parede

func transportar_player(): 
	var start_position = Vector3(1 * 80.0, 0, 1 * 80.0) 
	Player.global_transform.origin = start_position
