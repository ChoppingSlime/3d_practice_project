extends Node

var speed
const WALK_SPEED = 5.0
const SPRINT_SPEED = 8.0
const SNEAK_SPEED = 2.0
const JUMP_VELOCITY = 7.8


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 20

func handle_inputs(body : CharacterBody3D, delta: float, camera_pivot: PlayerCameraPivot) -> void:
	# Add the gravity.
	if not body.is_on_floor():
		body.velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and body.is_on_floor():
		body.velocity.y = JUMP_VELOCITY
	
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

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("go_left", "go_right", "go_forward", "go_back")
	var direction = (camera_pivot.transform.basis * body.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	set_new_velocity(direction, speed, delta, body)

func set_new_velocity(direction, speed, delta, body : CharacterBody3D) -> void:
	var velocity : Vector3

	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)

	velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
	velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)
	body.velocity.x = velocity.x
	body.velocity.z = velocity.z
