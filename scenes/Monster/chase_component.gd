class_name ChaseComponent
extends Node

var is_chasing : bool = false
var chasing_speed : int = 2

func handle_rotation(body: CharacterBody3D, target: CharacterBody3D, rot : int, is_facing_player : bool, delta) -> void:
	if target:
		if is_facing_player:
			start_chase(body, target, delta)
		elif rot:
			var abs_rot = abs(rot)
			var speed = 1.0 / (abs_rot + 0.001)
			speed *= 1.0 / (1.0 / 1.0)
			var new_rot = sign(rot) * speed 

			body.rotate_y(deg_to_rad(new_rot))
	if target == null:
		stop_chase(body)

	
func start_chase(body: CharacterBody3D, target: CharacterBody3D, delta) -> void:
	var direction = body.transform.basis * Vector3(0, 0 , 1)
	is_chasing = true 
	set_new_velocity(direction, delta, body)


func set_new_velocity(direction, delta, body : CharacterBody3D) -> void:
	var velocity : Vector3

	if direction:
		velocity.x = direction.x * chasing_speed
		velocity.z = direction.z * chasing_speed
	else:
		velocity.x = lerp(velocity.x, direction.x * chasing_speed, delta * 7.0)
		velocity.z = lerp(velocity.z, direction.z * chasing_speed, delta * 7.0)

	velocity.x = lerp(velocity.x, direction.x * chasing_speed, delta * 3.0)
	velocity.z = lerp(velocity.z, direction.z * chasing_speed, delta * 3.0)
	body.velocity.x = velocity.x
	body.velocity.z = velocity.z


func stop_chase(body: CharacterBody3D) -> void:
	is_chasing = false
	body.velocity.z = 0
	body.velocity.x = 0 
