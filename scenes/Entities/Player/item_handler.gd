class_name ItemHandler
extends Node3D
@export var player: Player

@export var item_equip_pos: Marker3D
@onready var input_component: InputComponent = $"../InputComponent"

var last_dropped_item : DefaultItem = null

signal start_using_item
signal stop_using_item

func _physics_process(delta: float) -> void:
	if input_component.get_lmb_pressed():
		start_using_item.emit()
	if input_component.get_lmb_released():
		stop_using_item.emit()
	if input_component.get_rmb_pressed():
		drop_item()

func pick_up(item : DefaultItem) -> void:
	#Check if item already equipped. If so, stop function
	if check_if_held(item):
		return
	elif item == last_dropped_item:
		return
		
	var new_item_instance = item.duplicate() as DefaultItem
	item.queue_free()
	
	start_using_item.connect(new_item_instance.start_use_item)
	stop_using_item.connect(new_item_instance.stop_use_item)
	
	item_equip_pos.add_child(new_item_instance)
	new_item_instance.call_deferred("pick_up_mode",item_equip_pos.global_position)


func check_if_held(item: DefaultItem) -> bool:
	print("checking")
	for child in item_equip_pos.get_children():
		if item == child:
			return true
	
	return false

func drop_item() -> void:
	var item : DefaultItem = get_item_held()
	if item == null:
		return
	
	var new_item_instance = item.duplicate() as DefaultItem
	item.queue_free()
	
	last_dropped_item = new_item_instance
	
	get_tree().get_first_node_in_group("Level").add_child(new_item_instance)
	new_item_instance.global_position = player.global_position
	new_item_instance.global_position.y -= 0.6
	new_item_instance.call_deferred("drop_mode")
	
	
	

func get_item_held() -> DefaultItem:
	for item in item_equip_pos.get_children():
		if item is DefaultItem:
			return item
	return null

func forget_picking_up(item : DefaultItem) -> void:
	if item == last_dropped_item:
		last_dropped_item = null
