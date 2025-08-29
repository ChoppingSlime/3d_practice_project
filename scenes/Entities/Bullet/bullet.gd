class_name Bullet
extends RigidBody3D

@export var speed : float = 10.0

func _ready() -> void:
	linear_velocity.x = 10

func _physics_process(delta: float) -> void:
	print(linear_velocity)
