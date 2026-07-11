extends Control


@onready var button_return_menu: Button = $Buttons/ButtonReturnMenu
@onready var button_return_game: Button = $Buttons/ButtonReturnGame
@onready var button_return_exit: Button = $Buttons/ButtonReturnExit


func _ready() -> void:
	button_return_menu.pressed.connect(_on_button_return_menu)
	button_return_game.pressed.connect(_on_button_return_game)
	button_return_exit.pressed.connect(_on_button_return_exit)

func _on_button_return_menu():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")


func _on_button_return_game():
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")


func _on_button_return_exit():
	get_tree().quit()
