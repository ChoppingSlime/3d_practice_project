class_name HealthComponent
extends Node

signal no_more_health
@export var health: int = -1
@onready var mesh: MeshInstance3D = $"../Mesh"
@onready var timer: Timer = $Timer

func take_dmg(dmg : int) -> void:
	if health == -1:
		health = Global.monster_health
		
	health = max(health-dmg, 0)
	dmg_anim()
	if health == 0:
		no_more_health.emit()


func dmg_anim() -> void:
	mesh.material_override.albedo_color = Color.PURPLE
	timer.start()


func _on_timer_timeout() -> void:
	mesh.material_override.albedo_color = Color.WHITE
