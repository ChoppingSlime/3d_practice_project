class_name ButtonBox
extends CSGBox3D

@export var pressed_color: Color
@export var not_pressed_color: Color

func _ready() -> void:
	material.albedo_color = not_pressed_color

func press_button() -> void:
	scale.z = 0.8
	material.albedo_color = pressed_color

func unpress_button() -> void:
	scale.z = 1
	material.albedo_color = not_pressed_color
