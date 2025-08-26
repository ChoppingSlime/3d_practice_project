class_name InputComponent
extends Node

var input_horizontal: float = 0.0
var input_lateral: float = 0.0

func _process(_delta: float) -> void:
	input_horizontal = Input.get_axis("go_left","go_right")
	input_lateral = Input.get_axis("go_forward","go_back")


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
