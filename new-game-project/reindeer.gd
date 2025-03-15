extends CharacterBody2D
@onready
var _animatedBody=$AnimatedSprite2D
@onready
var player = get_node("/root/reindeer_herding/Player")
@onready
var lichen = get_node("/root/reindeer_herding/lichen")
var speed = 50

func _physics_process(delta):	
	var overlapping_bodies = $Hurtbox.get_overlapping_bodies()
	var touching_bodies = $EatBox.get_overlapping_bodies()
	var l = false
	var p = false
	for body in overlapping_bodies:
		if body == player:
			p=true
	for body in touching_bodies:
		if body == lichen:
			l=true
	if l:
		_animatedBody.play("feeding")
		_animatedBody.stop()
		_animatedBody.set_frame_and_progress(3,0.5)
	elif p:
		_animatedBody.play("walk")
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed * -1
		move_and_slide()
		if velocity.x < 0:
			_animatedBody.flip_h=true
		elif velocity.x > 0:
			_animatedBody.flip_h=false
	else:
		_animatedBody.play("walk")
		_animatedBody.stop()
		_animatedBody.set_frame_and_progress(3,0.5)
