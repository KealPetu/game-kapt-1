extends CanvasLayer

@onready var fps_label: Label = $Control/FPSLabel
@onready var fps_updater_timer: Timer = $Control/FPSUpdaterTimer
@onready var score_label: Label = $Control/ScoreLabel


func _ready() -> void:
	fps_updater_timer.timeout.connect(update_fps_text_label)
	fps_updater_timer.start(1.0)

func _process(delta: float) -> void:
	score_label.text = "Score: " + str(GameManager.score)

func update_fps_text_label() -> void:
	fps_label.text = "FPS: " + ("%.2f" % Engine.get_frames_per_second())
