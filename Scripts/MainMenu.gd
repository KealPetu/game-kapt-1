extends Node

@onready var credits_layer: CanvasLayer = $CreditsLayer

# Main Options
@onready var main_options_layer: CanvasLayer = $MainOptionsLayer
@onready var play_button: Button = $MainOptionsLayer/MainOptions/OptionsContainer/PlayButton
@onready var credits_button: Button = $MainOptionsLayer/MainOptions/OptionsContainer/CreditsButton
@onready var exit_button: Button = $MainOptionsLayer/MainOptions/OptionsContainer/ExitButton

# Credits Options
@onready var back_button: Button = $CreditsLayer/CreditsPanel/Panel/BackButton

func _ready() -> void:
	play_button.pressed.connect(_on_play_pressed)
	credits_button.pressed.connect(_on_credits_pressed)
	exit_button.pressed.connect(_on_exit_pressed)
	back_button.pressed.connect(_on_back_pressed)
	credits_layer.hide()


func _on_play_pressed():
	ScoreManager.score = 0
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")


func _on_credits_pressed():
	main_options_layer.hide()
	credits_layer.show()


func _on_back_pressed():
	main_options_layer.show()
	credits_layer.hide()


func _on_exit_pressed():
	get_tree().quit()
