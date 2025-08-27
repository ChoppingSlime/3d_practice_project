class_name EntitySpawner
extends Node

@export var spawn_marker : Marker3D
@export var entity_to_spawn : PackedScene
@export var button: Button3D
@export var max_summoons : int = 1

var summons : int = 0

func _ready() -> void:
	button.button_pressed.connect(spawn_entity)

func spawn_entity() -> void:
	if summons >= max_summoons: return
	
	var new_entity = entity_to_spawn.instantiate()
	get_tree().get_first_node_in_group("Level").add_child(new_entity)
	if new_entity is Creature1:
		new_entity.global_position = spawn_marker.global_position
		
	summons += 1
