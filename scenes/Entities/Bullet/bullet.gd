class_name Bullet
extends CharacterBody3D
@onready var bullet_death_timer: Timer = $BulletDeathTimer
@export var speed : float = 30.0

func start(position, direction, target):
	rotation = direction
	global_position = position
	bullet_death_timer.start()
	
func _physics_process(delta):
	var forward = -transform.basis.z.normalized()
	velocity = forward * speed


	velocity.y = -1
	
	move_and_slide()
	

func _on_bullet_death_timer_timeout() -> void:
	queue_free()


func _on_detector_body_entered(body: Node3D) -> void:
	queue_free()
	if body is Monster:
		body.take_damage(Global.bullet_damage)
