class_name Monster
extends CharacterBody3D

@export var gravity_component : GravityComponet
@export var chase_component : ChaseComponent
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var mesh: MeshInstance3D = $Mesh


func _ready() -> void:
	if mesh.rotation_degrees.y != 0:
		mesh.rotation_degrees.y = 0


func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta)
	move_and_slide()
	
