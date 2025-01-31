extends Node

var health = 3
var coins = 0
var coinHud = null
var hpHud = null

func set_coinHud(new_coinHud):
	coinHud = new_coinHud
	
func set_hpHud(new_hpHud):
	hpHud = new_hpHud	

func get_health():
	return health

func get_coins():
	return coins

func set_health(new_health):
	health = new_health
	update_hp_hud()

func set_coins(new_coins):
	coins = new_coins
	update_coins_text()

func increment_coins():
	coins += 1
	update_coins_text()

func update_all ():
	update_hp_hud()
	update_coins_text()

func update_hp_hud():
	if hpHud:
		var hp_text = hpHud
		if hp_text is RichTextLabel:
			hp_text.clear()
			hp_text.add_text(str(health) + " HP")

func update_coins_text():
	if coinHud:
		var coins_text = coinHud
		if coins_text is RichTextLabel:
			coins_text.clear()
			coins_text.add_text(str(coins))
