extends Node3D

@export var input_component: InputComponent
@onready var dont_press_me_button: Button3D = $DontPressMeButton
@onready var oozey: Oozey = $Oozey

func _process(_delta: float) -> void:
	if input_component.get_quit_input():
		get_tree().quit()

func _ready() -> void:
	dont_press_me_button.button_pressed.connect(spawn_monster)

func spawn_monster() -> void:
	oozey.show()
