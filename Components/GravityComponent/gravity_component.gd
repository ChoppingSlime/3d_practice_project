class_name GravityComponet
extends Node

@export var gravity : float = 50.0
@export var falling_accelleration: float = 10.0

var is_falling : bool = false


## requires another component to call Move_and_slide
func handle_gravity(body: CharacterBody3D, delta: float) -> void:
	if not body.is_on_floor_only():
		body.velocity.y -= gravity * delta
	
	if is_falling:
		body.velocity.y -= falling_accelleration * delta
	
	is_falling = body.velocity.y > 0 and not body.is_on_floor_only()
