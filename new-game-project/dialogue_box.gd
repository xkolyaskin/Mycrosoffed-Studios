extends Panel

@onready var dialogue_label = $Label  # Adjust to your label node path

func type_text(text: String, speed: float = 0.05) -> void:
	dialogue_label.text = ""
	for i in text.length():
		dialogue_label.text += text[i]
		await get_tree().create_timer(speed).timeout
