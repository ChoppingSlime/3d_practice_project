class_name Oozey
extends CharacterBody3D

@export var gravity_component : GravityComponet
@export var chase_component : ChaseComponent
@onready var input_component: InputComponent = $InputComponent

var player_inside: bool = false

func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta)
	move_and_slide()

	
	if input_component.get_interact_pressed() and player_inside:
		print("!!!!")


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		player_inside = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is Player:
		player_inside = false
