extends Control

@onready var start_button: Button = $VBoxContainer/Start_button
@onready var settings_button: Button = $VBoxContainer/Settings_button
@onready var options_menu: OptionsMenu = $Options_Menu as OptionsMenu
@onready var margin_container: MarginContainer = $MarginContainer as MarginContainer


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://labyrinth.tscn")


func _on_settings_pressed() -> void:
	margin_container.visible = false
	options_menu.visible = true
