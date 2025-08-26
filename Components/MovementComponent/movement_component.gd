class_name MovementComponent
extends Node

@export var base_speed : float = 30.0
@export var sprint_speed_bonus: float = 13
@export var sneak_speed_bonus: float = -15

@export var ground_accel_speed : float = 4.0
@export var ground_decel_speed : float = 4.0
@export var air_accel_speed: float = 2.0
@export var air_decel_speed : float = 0.2

var speed : float

func handle_horizontal_movement(
	body: CharacterBody3D, 
	horizontal_direction: float, 
	lateral_direction: float, 
	is_sprinting: bool, 
	is_sneaking: bool
	) -> void:
		
	var velocity_horizontal_change_speed = determine_accelleration(body, horizontal_direction)
	var velocity_lateral_change_speed = determine_accelleration(body, lateral_direction)
	
	body.velocity.x = move_toward(
		body.velocity.x, 
		horizontal_direction * calculate_speed(is_sprinting, is_sneaking), 
		velocity_horizontal_change_speed
		)
	
	body.velocity.z = move_toward(
		body.velocity.z, 
		lateral_direction * calculate_speed(is_sprinting, is_sneaking), 
		velocity_lateral_change_speed
		)

func calculate_speed(is_sprinting: bool, is_sneaking: bool) -> float:
	var adj_speed = base_speed
	
	if is_sprinting and not is_sneaking:
		adj_speed += sprint_speed_bonus
	elif is_sneaking and not is_sprinting:
		adj_speed += sneak_speed_bonus
		
	return adj_speed

func determine_accelleration(body: CharacterBody3D, direction : float) -> float:
	if body.is_on_floor_only():
		return ground_accel_speed if direction != 0 else ground_decel_speed
	else:
		return air_accel_speed if direction != 0 else air_decel_speed
	
	return direction
