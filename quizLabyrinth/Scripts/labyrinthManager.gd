extends Node3D

@export var interactButton: Control = null
@export var quizScene: PackedScene
@export var button: Button

@export var interactedObject: Node

func _ready():
	button.connect("pressed", Callable(self, "_on_button_pressed"))
	_set_interactButton_active(false)
	
func activate_interactButton() -> void:
	_set_interactButton_active(true)

func deactivate_interactButton() -> void:
	_set_interactButton_active(false)

func _set_interactButton_active(active: bool) -> void:
	interactButton.visible = active
	interactButton.disabled = not active

func _on_button_pressed()-> void:
	#selecionar o tipo de interação:
#1- Instanciar quiz
		var instance = quizScene.instantiate() 
		add_child(instance)
		instance.labyrinthManager = self
		
func _on_quiz_won(won: bool)-> void:
	if (won == true) :
		interactedObject.queue_free()
		deactivate_interactButton()

func quit() -> void:
	
	pass
