class_name RaycastManager
extends Node3D

@export var raycast_dic : Dictionary[RayCast3D,int]
@onready var center_raycast: RayCast3D = $CenterRaycast

@export var raycast_numb : int = 7
@export var raycast_angle_distance : float = 6.0

func _ready() -> void:
	for raycast in raycast_numb:
		create_raycast(raycast, 1)	#left side raycasts
		create_raycast(raycast, -1)	#right side raycasts
		

func create_raycast(raycast: int, sign: int = 1) -> void:
	var new_raycast_instance = center_raycast.duplicate() as RayCast3D
	add_child(new_raycast_instance) 
	
	var new_rotation = (
		center_raycast.rotation_degrees.y + 
		deg_to_rad(raycast_angle_distance) * (raycast + 1) * sign
		)
		
	new_raycast_instance.rotate_y(new_rotation)
	raycast_dic.set(new_raycast_instance,(raycast + 1)* sign )


func get_angle() -> int:
	var final_angle :int = 0
	for raycast : RayCast3D in raycast_dic:
		if raycast.is_colliding():
			var angle : int = raycast_dic.get(raycast)
			if sign(final_angle) != sign(angle):
				final_angle += angle
	return final_angle

func is_facing_player() -> bool:
	return center_raycast.is_colliding()
