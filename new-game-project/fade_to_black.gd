extends CanvasLayer

@onready var fade_rect = $FadeRect

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	fade_rect.visible = false
	fade_rect.modulate = Color(0, 0, 0, 0)

func change_scene_with_fade(scene_path: String, duration := 1.0):
	fade_rect.visible = true
	fade_rect.modulate.a = 0.0

	# fade to black
	var fade_out = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	fade_out.tween_property(fade_rect, "modulate:a", 1.0, duration)
	await fade_out.finished
	get_tree().change_scene_to_file(scene_path)
	await get_tree().process_frame
	await get_tree().process_frame
	# pause new loaded scene
	get_tree().paused = true

	#fade back in
	fade_rect.visible = true
	fade_rect.modulate.a = 1.0
	var fade_in = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	fade_in.tween_property(fade_rect, "modulate:a", 0.0, duration)
	await fade_in.finished

	fade_rect.visible = false
	get_tree().paused = false
