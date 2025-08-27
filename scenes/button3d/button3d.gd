class_name Button3D
extends Node3D

@export var footer_text : String = "E"

@export_subgroup("nodes")
@export var button_box : ButtonBox
@onready var input_component: InputComponent = $InputComponent
@onready var button_timer: Timer = $ButtonTimer

var is_raycast : bool = false
var is_pressed: bool = false
var is_player_in : bool = false


func _physics_process(_delta: float) -> void:
	if input_component.get_interact_pressed() and is_player_in and not is_pressed and is_raycast:
		press_button()


func _on_player_detector_body_entered(body: Node3D) -> void:
	if body is Player:
		is_player_in = true
		body.facing_button.connect(toggle_raycast_status)
		toggle_footer_text(is_raycast)
		


func _on_player_detector_body_exited(body: Node3D) -> void:
	if body is Player:
		is_player_in = false
		UiManager.hide_footer.emit()
		if body.facing_button.is_connected(toggle_raycast_status):
			body.facing_button.disconnect(toggle_raycast_status)



func press_button() -> void:
	is_pressed = true
	button_timer.start()
	button_box.press_button()
	Global.button_pressed.emit()
	UiManager.hide_footer.emit()
	

func unpress_button() -> void:
	is_pressed = false
	button_box.unpress_button()
	if is_player_in:
		toggle_footer_text(is_raycast)
		

func _on_button_timer_timeout() -> void:
	unpress_button()

func toggle_raycast_status(toggle: bool) -> void:
	is_raycast = toggle
	
	if is_raycast:
		toggle_footer_text(is_player_in)
	else:
		toggle_footer_text(false)
		

func toggle_footer_text(toggle: bool) -> void:
	if toggle:
		UiManager.show_footer_with_text.emit(footer_text)
	else:
		UiManager.hide_footer.emit()
