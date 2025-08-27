extends Node

signal show_footer_with_text(text: String)
signal hide_footer

func emit_show_footer_with_text(text: String):
	show_footer_with_text.emit(text)

func emit_hide_footer() -> void:
	hide_footer.emit()
