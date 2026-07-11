extends Node

var score: int = 0
const MAX_SCORE: int = 10

func _ready():
	EventBus.coin_collected.connect(_on_coin_collected)

func _on_coin_collected():
	score += 1
	EventBus.score_changed.emit()
