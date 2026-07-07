extends Node3D

@onready var coin_picked_sfx: AudioStreamPlayer = $CoinPickedSFX

func _process(delta: float) -> void:
	rotation_degrees.z += 180 * delta


func _on_collision_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		GameManager.update_score()
		randomize()
		var pitch: float = randf_range(0.9, 1.1)
		coin_picked_sfx.pitch_scale = pitch
		coin_picked_sfx.play()
		await coin_picked_sfx.finished
		queue_free()
