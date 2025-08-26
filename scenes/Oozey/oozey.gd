class_name Oozey
extends CharacterBody3D

@export var gravity_component : GravityComponet

func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta)
	move_and_slide()
