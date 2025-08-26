class_name Player
extends CharacterBody3D
@export_category("Nodes")
@export var camera: PlayerCamera
@export_category("Components")
@export var gravity_component : GravityComponet
@export var movement_component : MovementComponent
@export var input_component : InputComponent
@export var jump_component : JumpComponent

func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta)
	jump_component.handle_jump(self,input_component.get_jump_pressed(),input_component.get_jump_released())
	
	movement_component.handle_horizontal_movement(
		self,
		input_component.input_horizontal, 
		input_component.input_lateral, 
		input_component.get_sprint_input(), 
		input_component.get_sneak_input()
		)
	camera.handle_camera_position(
		input_component.get_sprint_input(), 
		input_component.get_sneak_input()
		)
		
	move_and_slide()
