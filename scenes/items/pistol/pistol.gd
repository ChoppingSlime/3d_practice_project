class_name Pistol
extends DefaultItem
@onready var mesh: MeshInstance3D = $Mesh
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

@export var bullet : PackedScene

func _physics_process(delta: float) -> void:
	if dropped:
		mesh.rotate_y(deg_to_rad(0.5))
		pass


func drop_mode() -> void:
	dropped = true
	collision_shape_3d.disabled = false
	scale *= 2
	mesh.set_layer_mask_value(20, false)



func pick_up_mode(new_global_position: Vector3) -> void:
	reset_mesh_rotation()
	
	dropped = false
	collision_shape_3d.disabled = true
	global_position = new_global_position
	scale *= 0.5
	mesh.set_layer_mask_value(20, true)

	

func reset_mesh_rotation() -> void:
	mesh.rotation.y = deg_to_rad(180)

func start_use_item() -> void:
	pass
