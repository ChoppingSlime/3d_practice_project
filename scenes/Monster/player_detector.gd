class_name PlayerDetector
extends Area3D

#@onready var center_raycast: RayCast3D = $CenterRaycast
#@onready var left_close_raycast: RayCast3D = $LeftCloseRaycast
#@onready var right_close_raycast: RayCast3D = $RightCloseRaycast

@export var raycast_manager: RaycastManager


@export var monster: Monster
@export var speed: float = 10
@onready var chase_component: ChaseComponent = $"../ChaseComponent"

var player: Player = null
var was_colliding : bool = false

func _physics_process(delta: float) -> void:
	if player:
		var rot : int = raycast_manager.get_angle()
		if rot:
			var abs_rot = abs(rot)
			var speed = 1.0 / (abs_rot + 0.001)
			speed *= 1.0 / (1.0 / 1.0)
			var new_rot = sign(rot) * speed * delta * 50
			monster.rotate_y(deg_to_rad(new_rot))
			
		else:
			chase_component.handle_chase(monster, player)
		
	




func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		print("player detected")
		player = body

func _on_body_exited(body: Node3D) -> void:
	if body is Player and player == body:
		player = null
