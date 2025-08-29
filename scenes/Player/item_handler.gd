class_name ItemHandler
extends Node3D
@onready var camera_3d: Camera3D = $"../CameraPivot/Camera3D"

@export var item_equip_pos: Marker3D

func pick_up(item : DefaultItem) -> void:
	#Check if item already equipped. If so, stop function
	if check_if_held(item):
		return
		
	var new_item_instance = item.duplicate() as DefaultItem
	item.queue_free()
	item_equip_pos.add_child(new_item_instance)
	new_item_instance.call_deferred("pick_up_mode",item_equip_pos.global_position)


func check_if_held(item: DefaultItem) -> bool:
	for child in item_equip_pos.get_children():
		if item == child:
			return true
	
	return false
