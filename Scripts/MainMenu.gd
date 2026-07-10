extends Control


# Main Options
@onready var main_options: Control = $OptionsContainer
@onready var play_button: Button = $OptionsContainer/PlayButton
@onready var credits_button: Button = $OptionsContainer/CreditsButton
@onready var exit_button: Button = $OptionsContainer/ExitButton

# Credits Options
@onready var credits_panel: Panel = $CreditsPanel
@onready var back_button: Button = $CreditsPanel/BackButton

func _ready() -> void:
	play_button.pressed.connect(_on_play_pressed)
	credits_button.pressed.connect(_on_credits_pressed)
	exit_button.pressed.connect(_on_exit_pressed)
	back_button.pressed.connect(_on_back_pressed)
	credits_panel.hide()


func _on_play_pressed():
	ScoreManager.score = 0
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")


func _on_credits_pressed():
	main_options.hide()
	credits_panel.show()


func _on_back_pressed():
	main_options.show()
	credits_panel.hide()


func _on_exit_pressed():
	get_tree().quit()
