class_name Player
extends CharacterBody3D

signal facing_button(status : bool)

@export var camera_pivot : PlayerCameraPivot
@export var camera : Camera3D

@onready var ray_cast_3d: RayCast3D = $CameraPivot/Camera3D/RayCast3D
@onready var movement_componet: Node = $MovementComponet

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	movement_componet.handle_inputs(self, delta, camera_pivot)
	camera_pivot.handle_camera_position(Input.is_action_pressed("sprint"), Input.is_action_pressed("sneak"))
	camera_pivot.handle_hbob(delta, velocity, float(is_on_floor()))

	move_and_slide()
	
	
