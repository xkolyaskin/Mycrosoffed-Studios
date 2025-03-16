extends AnimatedSprite2D

func _ready():
	var total_frames = sprite_frames.get_frame_count(animation)
	frame = randi() % total_frames
