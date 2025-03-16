extends Panel

var typing = false

@onready var dialogue_label = $Label  # Adjust to your label node path

func is_typing():
	return typing

func type_text(text: String, speed: float = 0.03) -> void:
	typing = true
	dialogue_label.text = ""
	for i in text.length():
		dialogue_label.text += text[i]
		await get_tree().create_timer(speed).timeout
	typing = false
