extends Node


func _ready() -> void:
	EventBus.score_changed.connect(_on_score_changed)


func _on_score_changed():
	if ScoreManager.score >= ScoreManager.MAX_SCORE:
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/WinScene.tscn")
