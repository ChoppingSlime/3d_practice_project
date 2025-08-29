class_name Player
extends CharacterBody3D


signal facing_button(status : bool)

@export var camera_pivot : PlayerCameraPivot
@export var camera : Camera3D

@onready var movement_componet: Node = $MovementComponet
@onready var item_handler: ItemHandler = $ItemHandler

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	movement_componet.handle_inputs(self, delta, camera_pivot)
	camera_pivot.handle_camera_position(Input.is_action_pressed("sprint"), Input.is_action_pressed("sneak"))
	camera_pivot.handle_hbob(delta, velocity, float(is_on_floor()))

	move_and_slide()
	
	


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Monster:
		print("MONSTER!!")
	elif body is DefaultItem:
		item_handler.pick_up(body)


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is DefaultItem:
		item_handler.forget_picking_up(body)
