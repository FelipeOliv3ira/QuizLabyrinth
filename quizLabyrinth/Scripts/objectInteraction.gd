extends MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var area = $Area3D
	area.body_entered.connect(self._on_body_entered)
	area.body_exited.connect(self._on_body_exited)

func _on_body_entered(body: Node) -> void:
	
	if body.is_in_group("Player"):
		
		print("entrou")  # Verifique se é o jogador que entrou na área
		var labyrinth_manager = get_node("/root/Labyrinth")
		labyrinth_manager.interactedObject = self
		labyrinth_manager.activate_interactButton()

func _on_body_exited(body: Node) -> void:
	
	if body.is_in_group("Player"):
		print("saiu")  # Verifique se é o jogador que saiu da área
		var labyrinth_manager = get_node("/root/Labyrinth")
		
		labyrinth_manager.deactivate_interactButton()
