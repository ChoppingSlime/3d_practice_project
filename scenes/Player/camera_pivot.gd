class_name PlayerCameraPivot
extends Node3D

@export var default_position: Marker3D
@export var sneaking_position: Marker3D
@export var camera : Camera3D

@export var fov_default_value = 80
@export var fov_sprint_value = 100

var camera_mov_speed: float = 0.1
var fov_change_speed = 1.1

#bob variables
const BOB_FREQ = 2.4
const BOB_AMP = 0.08
var t_bob = 0.0
	

func handle_camera_position(is_sprinting: bool, is_sneaking: bool, ) -> void:
	handle_sneaking(is_sneaking)
	handle_sprinting(is_sprinting)
	
	
func handle_sneaking(is_sneaking: bool) -> void:
	if is_sneaking:
		position.y= move_toward(position.y, sneaking_position.position.y, camera_mov_speed)
	else:
		position.y= move_toward(position.y, default_position.position.y, camera_mov_speed)

func handle_sprinting(is_sprinting: bool) -> void:
	if is_sprinting:
		camera.fov = move_toward(camera.fov, fov_sprint_value, fov_change_speed)
	else:
		camera.fov = move_toward(camera.fov, fov_default_value, fov_change_speed)

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos

func handle_hbob(delta, velocity, is_on_floor : float) -> void:
	t_bob += delta * velocity.length() * is_on_floor
	camera.transform.origin = _headbob(t_bob)
