class_name Player
extends CharacterBody3D
@export_category("Nodes")
@export var camera: PlayerCamera
@export_category("Components")
@export var gravity_component : GravityComponet
@export var movement_component : MovementComponent
@export var input_component : InputComponent
@export var jump_component : JumpComponent

const LOOKAROUND_SPEED : float = 0.01
var rot_x = 0
var rot_y = 0

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

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# modify accumulated mouse rotation
		rot_x += event.relative.x * LOOKAROUND_SPEED
		rot_y += event.relative.y * LOOKAROUND_SPEED
		# Convert basis to quaternion, keep in mind scale is lost
		var a = Quaternion(transform.basis.orthonormalized())
		# Interpolate using spherical-linear interpolation (SLERP).

		# Apply back
		transform.basis = Basis(a)

		rotate_object_local(Vector3(0, -1, 0), rot_x) # first rotate in
		rotate_object_local(Vector3(-1, 0, 0), rot_y) # then rotate in X
