extends Node

@onready var coin_hud = $coins_text
@onready var hp_hud = $hp_hud

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerStatus.set_coinHud(coin_hud)
	PlayerStatus.set_hpHud(hp_hud)
	PlayerStatus.update_all()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_T):
		PlayerStatus.increment_coins()
