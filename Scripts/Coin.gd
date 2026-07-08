extends Node3D

func _process(delta: float) -> void:
	rotation_degrees.z += 180 * delta

func _on_collision_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		EventBus.coin_collected.emit()
		queue_free()
