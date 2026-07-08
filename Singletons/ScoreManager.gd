extends Node

var score: int = 0

func _ready():
	EventBus.coin_collected.connect(_on_coin_collected)

func _on_coin_collected():
	score += 1
	EventBus.score_changed.emit()
