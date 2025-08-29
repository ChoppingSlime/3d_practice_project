class_name Pistol
extends DefaultItem
@export var mesh: MeshInstance3D
@export var collision_shape_3d: CollisionShape3D
@export var cooldown_timer: Timer

@export var bullet : PackedScene
@export var bullet_spawn_pos: Marker3D 
@onready var bullet_direction_pos: Marker3D = $Mesh/BulletDirectionPos


var shooting: bool = false

func _physics_process(delta: float) -> void:
	if dropped:
		mesh.rotate_y(deg_to_rad(0.5))



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
	shooting = true
	cooldown_timer.start()

func stop_use_item() -> void:
	shooting = false
	cooldown_timer.stop()


func _on_cooldown_t_imer_timeout() -> void:
	if shooting:
		print("shoot")
		spawn_bullet()
		cooldown_timer.start()

func spawn_bullet() -> void:
	var bullet_instance = bullet.instantiate() as Bullet
	get_tree().get_first_node_in_group("Level").add_child(bullet_instance)
	bullet_instance.start(bullet_spawn_pos.global_position, get_camera_rotation(), bullet_direction_pos.global_position)
