extends Node2D

@onready var dialogue_box = $DialogueBox

func _ready():
	
	if not dialogue_box.is_typing():
		dialogue_box.visible = true
		dialogue_box.type_text("1st Round: While we do love our meat, a balanced diet requires some veggies too. Walk over to those seeds and choose which one to plant. ")
	while(true):
		await get_tree().create_timer(0.1).timeout
		if Input.is_action_just_pressed("interact") and not dialogue_box.is_typing(): 
			emit_signal("next_text")
			print("next")
			
	
