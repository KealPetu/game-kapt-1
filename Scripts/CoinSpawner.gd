extends Node3D

@onready var coin_spawn_timer: Timer = $CoinSpawnTimer
const COIN_SCENE: PackedScene = preload("res://Scenes/Coin.tscn")

func _ready() -> void:
	coin_spawn_timer.timeout.connect(spawn_coin)
	coin_spawn_timer.start(3.0)

func spawn_coin():
	var coin_instance: Node3D = COIN_SCENE.instantiate()
	randomize()
	var coin_position: Vector3 = Vector3(randf_range(-20.0, 20.0), randf_range(-20.0, 20.0), 0.0)
	coin_instance.position = coin_position
	add_child(coin_instance)
