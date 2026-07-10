extends Node

@onready var sfx_player: AudioStreamPlayer = $SFXPlayer

func _ready():
	EventBus.coin_collected.connect(_on_coin_collected)

func _on_coin_collected():
	play_sfx("pickupCoin")

func play_sfx(name: String):
	var stream: AudioStreamWAV = load("res://Assets/Audio/%s.wav" % name)
	sfx_player.stream = stream
	randomize()
	sfx_player.pitch_scale = randf_range(0.9, 1.1)
	if sfx_player.playing:
		sfx_player.stop()
	sfx_player.play()
