extends RayCast3D
@onready var player: Player = $"../../.."

var was_colliding: bool = false

func _physics_process(delta: float) -> void:
	if is_colliding():
		if not was_colliding:
			player.facing_button.emit(true)
	else:
		if was_colliding:
			player.facing_button.emit(false)
	was_colliding = is_colliding()
