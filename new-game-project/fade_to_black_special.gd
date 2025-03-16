extends CanvasLayer

@onready var fade_rect = $FadeRect
# USED CHATGPT AS ASSISTANCE WITH THIS SCENE SCRIPT

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	fade_rect.visible = false
	fade_rect.modulate = Color(0, 0, 0, 0)
	$Label.modulate = Color(255,255,255,0)
	$Label.text="In a small village, Khailino, in the Kamchatka Peninsula of eastern Russia…"

func change_scene_with_fade(scene_path: String, credits, duration := 1.0):
	if credits:
		if GlobalCountTracker.score_is_good():
			$Label.text="Due to your help herding reindeer, planting crops,\n
			and fishing, this village will be able to rebuild.\n
			But in real life, many Indigenous communities, including the Koryak people,\n
			are facing similar difficulties as a result of climate change. You can help.\n
			Click the Resources button on the menu to learn more."
		else:
			$Label.text="You weren’t able to gain enough resources through herding reindeer,\n
			planting crops, or fishing, so this village will not be able to rebuild.\n
			But in real life, many Indigenous communities, including the Koryak people,\n
			are facing similar difficulties as a result of climate change.\n
			You can help. Click the Resources button on the menu to learn more."
	else:
		$Label.text="In a small village, Khailino, in the Kamchatka Peninsula of eastern Russia…"
	fade_rect.visible = true
	fade_rect.modulate.a = 0.0

	# fade to black
	var fade_out = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	fade_out.tween_property(fade_rect, "modulate:a", 1.0, duration)
	await fade_out.finished
	
	#text
	var fade = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	$Label.modulate = Color(255,255,255,0)

	
	fade.tween_property($Label, "modulate:a", 1.0, duration)
	await fade.finished
	await get_tree().create_timer(5).timeout
	
	var fadeagain = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	fadeagain.tween_property($Label, "modulate:a", 0.0, duration)
	await fadeagain.finished

	

	
	get_tree().change_scene_to_file(scene_path)
	
	await get_tree().process_frame
	await get_tree().process_frame
	get_tree().paused = true
	
	
	

	await get_tree().process_frame
	await get_tree().process_frame
	
	
	#fade back in
	fade_rect.visible = true
	fade_rect.modulate.a = 1.0
	var fade_in = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	fade_in.tween_property(fade_rect, "modulate:a", 0.0, duration)
	await fade_in.finished

	fade_rect.visible = false
	get_tree().paused = false

	
	
	
