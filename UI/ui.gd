class_name UI
extends CanvasLayer

@export var footer_label : Label

func _ready() -> void:
	UiManager.show_footer_with_text.connect(show_footer_with_text)
	UiManager.hide_footer.connect(hide_footer)
	footer_label.hide()

func show_footer_with_text(text: String):
	footer_label.text = text
	footer_label.show()

func hide_footer() -> void:
	footer_label.hide()
