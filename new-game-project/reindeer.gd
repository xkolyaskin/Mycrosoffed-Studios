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
var timeleft = 0

func _physics_process(delta):	
	velocity=Vector2(0,0)
	point.hide()
	happy.hide()
	eating=false
	var overlapping_bodies = $Hurtbox.get_overlapping_bodies()
	var touching_bodies = $EatBox.get_overlapping_bodies()
	var l = false
	var p = false
	var il = false
	for body in overlapping_bodies:
		if body == player:
			p=true
	for body in touching_bodies:
		if body == lichen && !eating:
			l=true
		if body == ice_lichen && !eating:
			il = true
	if l:
		eating=true
		happy.show()
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
		eating=true
		point.show()
		if _animatedBody.animation != "ice":
			_animatedBody.play("ice")
		_animatedBody.set_frame_and_progress(3,0.5)
		while(timeleft>0):
			await get_tree().create_timer(1).timeout
		eating=false
		await get_tree().create_timer(3).timeout
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
