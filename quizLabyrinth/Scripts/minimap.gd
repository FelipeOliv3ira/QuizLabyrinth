extends Node2D

@export var labirinto: Array = []
@export var WallMinimapSprite: PackedScene

@onready var minimap_rotation_container = $".."
@onready var minimap_content = $"."
@onready var player_icon = $WallSymbol
@onready var player: Node3D = $"../../../Player"

func _ready():
	gerar_minimapa()
	
func _process(delta):
	update_minimap()
	
func gerar_minimapa():
	var start_position = Vector2(0, 0)  # Starting position of the first wall
	var cell_spacing = 10  # Space difference between walls in pixels

	for y in range(labirinto.size()):
		for x in range(labirinto[y].size()):
			if labirinto[y][x] == 1:
				var wall_instance = WallMinimapSprite.instantiate() as Sprite2D
				add_child(wall_instance)
				wall_instance.position = start_position + Vector2(x * cell_spacing, y * cell_spacing)

func update_minimap():
	if player != null:
		# Obtém a rotação do jogador em radianos
		var player_rotation = player.global_transform.basis.get_euler().y
		# Rotaciona o container de acordo com a rotação do jogador (negativo para manter o ícone do player fixo)
		minimap_rotation_container.rotation = player_rotation

		# Atualiza a posição do conteúdo do minimapa para simular o movimento
		var player_position = player.global_transform.origin
		var cell_spacing = 10  # Mesmo valor usado antes
		var cell_size = 80.0   # Tamanho da célula no mundo 3D
		var maze_origin = Vector2(-(labirinto[0].size() * cell_spacing) / 2, -(labirinto.size() * cell_spacing) / 2)

		var player_minimap_pos = Vector2(
			(player_position.x / cell_size) * cell_spacing,
			(player_position.z / cell_size) * cell_spacing
		)
		var clip_mask_center = Vector2(30, 30)  # Centro da clipe mask
		minimap_content.position = clip_mask_center - player_minimap_pos
	else:
		print("Referência ao player não está definida no script do minimapa.")
