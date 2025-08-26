class_name PlayerCamera
extends Camera3D

@export var input_component: InputComponent
@export var camera_def_pos: Marker3D
@export var camera_sneak_pos: Marker3D

@export var camera_mov_speed: float = 0.1


func handle_camera_position(is_sprinting: bool, is_sneaking: bool) -> void:
	handle_sneaking(is_sneaking)
		

func handle_sneaking(is_sneaking: bool) -> void:
	if is_sneaking:
		position.y= move_toward(position.y, camera_sneak_pos.position.y, camera_mov_speed)
	else:
		position.y= move_toward(position.y, camera_def_pos.position.y, camera_mov_speed)
