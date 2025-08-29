class_name Pistol
extends DefaultItem
@onready var mesh: MeshInstance3D = $Mesh
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D


func _ready() -> void:
	drop_mode()

func _physics_process(delta: float) -> void:
	if dropped:
		mesh.rotate_y(deg_to_rad(0.5))
		pass


func drop_mode() -> void:
	dropped = true
	animation_player.play("dropped_idle")
	mesh.set_layer_mask_value(20, false)


func pick_up_mode(new_global_position: Vector3) -> void:
	reset_mesh_rotation()
	collision_shape_3d.disabled = true
	global_position = new_global_position
	scale *= 0.25
	dropped = false
	mesh.set_layer_mask_value(20, true)
	animation_player.stop()
	

func reset_mesh_rotation() -> void:
	mesh.rotation.y = deg_to_rad(180)
