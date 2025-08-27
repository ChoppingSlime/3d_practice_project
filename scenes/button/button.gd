extends StaticBody3D

signal button_pressed
@export var footer_text : String = "Press 'E'"

@export var pressed_color: Color
@export var not_pressed_color: Color

@onready var button_sprite: CSGBox3D = $ButtonSprite
@onready var input_component: InputComponent = $InputComponent
@onready var label_3d: Label3D = $ButtonSprite/ButtonText
@onready var button_timer: Timer = $ButtonTimer


var is_pressed: bool = false
var is_player_in : bool = false

func _ready() -> void:
	label_3d.hide()
	button_sprite.material.albedo_color = not_pressed_color

func _physics_process(delta: float) -> void:
	if input_component.get_interact_pressed() and is_player_in and not is_pressed:
		press_button()

func _on_player_detector_body_entered(body: Node3D) -> void:
	if body is Player:
		is_player_in = true
		unpress_button()


func _on_player_detector_body_exited(body: Node3D) -> void:
	if body is Player:
		is_player_in = false
		UiManager.emit_hide_footer()
		button_sprite.material.albedo_color = not_pressed_color
		

func press_button() -> void:
	is_pressed = true
	button_timer.start()
	print("!!!!")
	button_pressed.emit()
	button_sprite.scale.z = 0.8
	UiManager.emit_hide_footer()
	button_sprite.material.albedo_color = pressed_color

func unpress_button() -> void:
	is_pressed = false
	button_sprite.scale.z = 1
	
	if is_player_in:
		UiManager.emit_show_footer_with_text(footer_text)
		button_sprite.material.albedo_color = not_pressed_color
		

func _on_button_timer_timeout() -> void:
	unpress_button()
