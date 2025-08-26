extends Node3D

@export var input_component: InputComponent

func _process(_delta: float) -> void:
	if input_component.get_quit_input():
		get_tree().quit()
