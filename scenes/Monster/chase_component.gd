class_name ChaseComponent
extends Node

var is_chasing : bool = false

func handle_chase(body: CharacterBody3D, target: CharacterBody3D, _delta: float) -> void:
	if not is_chasing: return
	body.look_at(target.global_position)
	


func toggle_chasing(should_chase : bool) -> void:
	is_chasing = should_chase
