class_name InputComponent
extends Node

var input_dir: Vector2 = Vector2.ZERO


func _process(_delta: float) -> void:
	input_dir = Input.get_vector("go_left","go_right","go_forward","go_back")



func get_jump_input() -> bool:
	return Input.is_action_just_pressed("jump")
	
func get_jump_pressed() -> bool:
	return Input.is_action_pressed("jump")
	
func get_jump_released() -> bool:
	return Input.is_action_just_released("jump")


func get_sprint_input() -> bool:
	return Input.is_action_pressed("sprint")

func get_sneak_input() -> bool:
	return Input.is_action_pressed("sneak")

func get_quit_input() -> bool:
	return Input.is_action_pressed("quit")
