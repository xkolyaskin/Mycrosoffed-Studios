extends Node2D
@onready
var _animatedBody=$Reindeer/AnimatedSprite2D

func _physics_process(delta):	
	var velocity = 0;
	if velocity != Vector2.ZERO:
		_animatedBody.play("walk")
		if velocity.x < 0:
			_animatedBody.flip_h=true
		elif velocity.x > 0:
			_animatedBody.flip_h=false
	else:
		_animatedBody.stop()
		_animatedBody.set_frame_and_progress(3,0.5)
