extends CharacterBody2D
@onready
var _animatedBody=$AnimatedSprite2D
@onready
var player = get_node("/root/reindeer_herding/Player")
@onready
var lichen = get_node("/root/reindeer_herding/lichen")
@onready
var ice_lichen = get_node("/root/reindeer_herding/iceLichen")
@onready
var point = $Point
@onready
var happy = $Happy
var speed = 150
var count = 0
var revx = 1
var revy = 1
var eating = false
var timeleft = 100

func _physics_process(delta):	
	velocity=Vector2(0,0)
	point.hide()
	happy.hide()
	#eating=false
	var overlapping_bodies = $Hurtbox.get_overlapping_bodies()
	var touching_bodies = $EatBox.get_overlapping_bodies()
	var l = false
	var p = false
	var il = false
	for body in overlapping_bodies:
		if body == player:
			p=true
	for body in touching_bodies:
		if body == lichen:
			l=true
		if body == ice_lichen:
			il = true
	if l:
		happy.show()
		if !eating:
			eating=true
			_animatedBody.play("feeding")
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
	elif il: 
		point.show()
		if !eating:
			eating=true
			if _animatedBody.animation != "ice":
				_animatedBody.play("ice")
			_animatedBody.set_frame_and_progress(3,0.5)
	else:
		_animatedBody.play("walk")
		_animatedBody.set_frame_and_progress(3,0.5)

func _on_timer_timeout():
	count+=1
	if count==100:
		if randf()>0.5: 
			revx=-1
		else:
			revx=1
		if randf()>0.5:
			revy=-1
		else:
			revy=1
		count=0
	velocity=Vector2(revx*randi_range(0,50),revy*randi_range(0,50))
	move_and_slide()
	if eating:
		timeleft-=1
		if timeleft==0:
			eating=false
			timeleft=100
