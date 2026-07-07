extends CharacterBody3D

## --- Movement settings ---
@export var speed: float = 5.0
@export var sprint_speed: float = 8.0
@export var jump_velocity: float = 4.5
@export var acceleration: float = 10.0

## --- Look settings ---
@export var mouse_sensitivity: float = 0.0025
@export var controller_sensitivity: float = 3.0 # radians/sec at full stick deflection
@export var min_look_angle_deg: float = -89.0
@export var max_look_angle_deg: float = 89.0

@onready var camera: Camera3D = $Camera3D
@onready var flashlight: SpotLight3D = $Flashlight

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
	# Mouse look
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		_apply_look(Vector2(-event.relative.x, -event.relative.y) * mouse_sensitivity)

	# Let Esc release the mouse, click to recapture (handy for testing in-editor)
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif event is InputEventMouseButton and event.pressed and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	if event.is_action_pressed("flashlight_toggle"):
		flashlight.visible = !flashlight.visible


func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Controller look (right stick), framerate-independent
	var look_input := Vector2(
		Input.get_action_strength("look-left") - Input.get_action_strength("look-right"),
		Input.get_action_strength("look-up") - Input.get_action_strength("look-down")
	)
	if look_input != Vector2.ZERO:
		_apply_look(look_input * controller_sensitivity * delta)

	# Movement
	var input_dir := Input.get_vector("left", "right", "forwards", "backwards")
	var move_dir := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	var current_speed := speed
	if Input.is_action_pressed("sprint"):
		current_speed = sprint_speed

	if move_dir != Vector3.ZERO:
		velocity.x = move_toward(velocity.x, move_dir.x * current_speed, acceleration * delta * current_speed)
		velocity.z = move_toward(velocity.z, move_dir.z * current_speed, acceleration * delta * current_speed)
	else:
		velocity.x = move_toward(velocity.x, 0.0, acceleration * delta * current_speed)
		velocity.z = move_toward(velocity.z, 0.0, acceleration * delta * current_speed)

	move_and_slide()


## Rotates the player body left/right and the camera up/down.
## look_delta.x = yaw amount, look_delta.y = pitch amount (already scaled by caller).
func _apply_look(look_delta: Vector2) -> void:
	rotate_y(look_delta.x)
	camera.rotate_x(look_delta.y)
	camera.rotation.x = clamp(
		camera.rotation.x,
		deg_to_rad(min_look_angle_deg),
		deg_to_rad(max_look_angle_deg)
	)
	
	flashlight.rotate_x(look_delta.y)
	flashlight.rotation.x = clamp(
		flashlight.rotation.x,
		deg_to_rad(min_look_angle_deg),
		deg_to_rad(max_look_angle_deg)
	)
