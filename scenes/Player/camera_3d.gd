class_name PlayerCamera
extends Camera3D

@export var input_component: InputComponent
@export var default_position: Marker3D
@export var sneaking_position: Marker3D


@export var fov_default_value = 80
@export var fov_sprint_value = 100

var camera_mov_speed: float = 0.1
var fov_change_speed = 1.1




		

func handle_camera_position(is_sprinting: bool, is_sneaking: bool) -> void:
	handle_sneaking(is_sneaking)
	handle_sprinting(is_sprinting)

func handle_sneaking(is_sneaking: bool) -> void:
	if is_sneaking:
		position.y= move_toward(position.y, sneaking_position.position.y, camera_mov_speed)
	else:
		position.y= move_toward(position.y, default_position.position.y, camera_mov_speed)

func handle_sprinting(is_sprinting: bool) -> void:
	if is_sprinting:
		fov = move_toward(fov, fov_sprint_value, fov_change_speed)
		print (fov)
	else:
		fov = move_toward(fov, fov_default_value, fov_change_speed)
