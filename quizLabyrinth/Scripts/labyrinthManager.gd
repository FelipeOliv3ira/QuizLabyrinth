extends Node3D
@export var interactButton: Control = null

func _ready():
	_set_interactButton_active(false)
	
func activate_interactButton() -> void:
	_set_interactButton_active(true)

func deactivate_interactButton() -> void:
	_set_interactButton_active(false)

func _set_interactButton_active(active: bool) -> void:
	interactButton.visible = active
	interactButton.disabled = not active
