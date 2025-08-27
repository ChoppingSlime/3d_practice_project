class_name Monster
extends CharacterBody3D

@export var gravity_component : GravityComponet
@export var chase_component : ChaseComponent
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var player: Player = null

func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta)
	if player:
		chase_component.handle_chase(self, player, delta)
		animation_player.play("chase")
	else:
		animation_player.play("idle")
	move_and_slide()
	


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		player = body
		chase_component.toggle_chasing(true)


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is Player and player == body:
		player = null
		chase_component.toggle_chasing(false)
