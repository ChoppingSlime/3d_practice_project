class_name Monster
extends CharacterBody3D

@export_category("nodes")
@export var raycast_manager: RaycastManager
@export var gravity_component : GravityComponet
@export var chase_component : ChaseComponent
@export var animation_player: AnimationPlayer
@export var mesh: MeshInstance3D
@export var health_component: HealthComponent

var player: Player = null
var was_colliding : bool = false

func _ready() -> void:
	if mesh.rotation_degrees.y != 0:
		mesh.rotation_degrees.y = 0
	health_component.no_more_health.connect(die)


func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta)
	chase_component.handle_rotation(self, player, raycast_manager.get_angle(),raycast_manager.is_facing_player(), delta)
	move_and_slide()
	if chase_component.is_chasing:
		animation_player.play("chase")
	else:
		animation_player.play("idle")
	


func _on_player_detector_body_entered(body: Node3D) -> void:
	if body is Player:
		player = body



func _on_player_exit_detector_body_exited(body: Node3D) -> void:
	if body is Player and player == body:
		player = null

func take_damage(dmg : int) -> void:
	health_component.take_dmg(dmg)

func die() -> void:
	queue_free()
