class_name JumpComponent
extends Node

# Jump Configuration
@export_group("Jump Properties")
@export var jump_velocity: float = 7.0  ## Higher magnitude = faster upward jump

@export_group("Assist Timers")
@export var jump_buffer_timer: Timer

var jumping: bool = false

var last_frame_on_floor: bool = false

# Main jump handling function - called from player's _physics_process
func handle_jump(body: CharacterBody3D, jump_pressed: bool, jump_released: bool) -> void:
	# Track state changes
	var just_landed = has_just_landed(body)
	
	# Handle jump buffer
	if jump_pressed and not body.is_on_floor_only():
		jump_buffer_timer.start()
	
	# Reset jumps when landing
	if just_landed:
		jumping = false

	# Attempt to jump if conditions are met
	if should_jump(body, jump_pressed):
		perform_jump(body)
	
	# Update state for next frame
	last_frame_on_floor = body.is_on_floor_only()

# Check if player should jump (separated logic for clarity)
func should_jump(body: CharacterBody3D, jump_pressed: bool) -> bool:
	# Jump from buffer when landing
	if body.is_on_floor_only() and not jump_buffer_timer.is_stopped():
		return true

	return jump_pressed and body.is_on_floor_only()

# Perform the actual jump
func perform_jump(body: CharacterBody3D) -> void: 
	# Apply velocity
	
	body.velocity.y = jump_velocity
	
	# Update state
	jumping = true
	jump_buffer_timer.stop()



# Helper method to detect if player just landed
func has_just_landed(body: CharacterBody3D) -> bool:
	return body.is_on_floor_only() and not last_frame_on_floor

# Helper method to detect if player just left a ledge
func has_just_left_ledge(body: CharacterBody3D) -> bool:
	return not body.is_on_floor_only() and last_frame_on_floor and not jumping
