extends CharacterBody2D
@onready
var _animatedBody=$AnimatedSprite2D
@onready
var player = get_node("/root/reindeer_herding/Player")
var speed = 50

func _physics_process(delta):	
	var overlapping_bodies = $Hurtbox.get_overlapping_bodies()
	if overlapping_bodies.size() > 0:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed * -1
		move_and_slide()
	
	
	
	if velocity != Vector2.ZERO:
		_animatedBody.play("walk")
		if velocity.x < 0:
			_animatedBody.flip_h=true
		elif velocity.x > 0:
			_animatedBody.flip_h=false
	else:
		_animatedBody.stop()
		_animatedBody.set_frame_and_progress(3,0.5)
