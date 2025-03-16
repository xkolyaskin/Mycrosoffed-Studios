extends AnimatedSprite2D
"""
Generated from ChatGPT. Prompt:
	"is there a way to randomize the starting point of an animatedsprite2d that has autoplay on load"
"""
func _ready():
	var total_frames = sprite_frames.get_frame_count(animation)
	frame = randi() % total_frames
