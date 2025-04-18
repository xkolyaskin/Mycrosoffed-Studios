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
var speed = 120
var count = 0
var revx = 1
var revy = 1
var eating = false
var timeleft = 100
var score = 0
var wait = false
var walking = false

func _physics_process(delta):	
	velocity=Vector2(0,0)
	#happy.hide()
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
		if body.has_method("is_lichen"):
			l=true
		if body.has_method("is_ice_lichen"):
			il = true
	if il:
		point.show()
	else:
		point.hide()
	if l:
		#happy.show()
		if !eating:
			eating=true
			animate("feeding")
	elif p:
		walk()
		animate("walk")
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed * -1
		move_and_slide()
		if velocity.x < 0:
			_animatedBody.flip_h=true
		elif velocity.x > 0:
			_animatedBody.flip_h=false
	elif il: 
		if randi_range(0,100)==5:
			$Reindeer3.play()
		animate("feeding")
	else:
		animate("idle")

func animate(cycle):
	if !wait:
		wait = true
		await get_tree().create_timer(0.5).timeout
		wait = false
	_animatedBody.play(cycle)
	#_animatedBody.set_frame_and_progress(3,0.5)
	
func walk():
	walking = true
	await get_tree().create_timer(1).timeout
	walking = false

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
	if !walking:
		velocity=Vector2(revx*randi_range(0,50),revy*randi_range(0,50))
		move_and_slide()
	if eating:
		timeleft-=1
		if timeleft==0:
			eating=false
			timeleft=100
			score+=1
			$Happy.go()
			get_parent().incScore()
			if randi_range(0,10)==5:
				$Reindeer1.play()
			if randi_range(0,10)==5:
				$Reindeer2.play()
