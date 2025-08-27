class_name Player
extends CharacterBody3D

var speed
const WALK_SPEED = 5.0
const SPRINT_SPEED = 8.0
const SNEAK_SPEED = 2.0
const JUMP_VELOCITY = 7.8
const SENSITIVITY = 0.004

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 20

@export var camera_pivot : PlayerCameraPivot
@export var camera : Camera3D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		camera_pivot.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))


func _physics_process(delta):
	handle_inputs(delta)

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("go_left", "go_right", "go_forward", "go_back")
	var direction = (camera_pivot.transform.basis * transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	set_new_velocity(direction, speed, delta)
	
	camera_pivot.handle_camera_position(Input.is_action_pressed("sprint"), Input.is_action_pressed("sneak"))
	camera_pivot.handle_hbob(delta, velocity, float(is_on_floor()))

	move_and_slide()

func handle_inputs(delta) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Handle Sprint.
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED
	
	# Handle Sneak.
	if Input.is_action_pressed("sneak"):
		speed = SNEAK_SPEED
	else:
		speed = WALK_SPEED

func set_new_velocity(direction, speed, delta) -> void:
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)
