extends CanvasLayer

@onready var fade_rect = $FadeRect

func _ready():
	fade_rect.visible = false
	fade_rect.modulate.a = 0.0

func change_scene_with_fade(scene_path: String, duration := 1.0):
	fade_rect.visible = true
	
	# fade to black
	fade_rect.color = Color(0,0,0,0)
	for i in range(0,255):
		fade_rect.color = Color(0,0,0,i)
		await get_tree().process_frame
		await get_tree().create_timer(0.005).timeout
		
	get_tree().change_scene_to_file(scene_path)

	await get_tree().process_frame

	#fade back
	for i in range(0,255):
		fade_rect.color = Color(0,0,0,255-i)
		await get_tree().process_frame
		await get_tree().create_timer(0.005).timeout

	fade_rect.visible = false
