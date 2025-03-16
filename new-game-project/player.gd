extends CharacterBody2D
var fishing = false
var can_move = true

@onready var _animatedBody = $PlayerSprite/AnimatedSprite2D

func _ready():
	add_to_group("player")

func _physics_process(delta):	
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * 200
	if velocity != Vector2.ZERO:
		_animatedBody.play("walk")
		if velocity.x < 0:
			_animatedBody.flip_h=true
			%FishingRod.flip_h = true
			%FishingRod.global_position = global_position + Vector2(-18,0)
		elif velocity.x > 0:
			%FishingRod.flip_h = false
			_animatedBody.flip_h=false
			%FishingRod.global_position = global_position + Vector2(18,0)
	else:
		_animatedBody.stop()
		_animatedBody.set_frame_and_progress(3,0.5)
	move_and_slide()
	var overlapping_bodies = %HurtBox.get_overlapping_bodies()
	if overlapping_bodies.size() > 0:
		if overlapping_bodies[0].has_method("is_fishing") and overlapping_bodies[0].get_fished():
			fish(overlapping_bodies[0])

func fish(fishing_spot):
	if fishing:
		%FishingRod.visible = true
		return
	fishing = true
	var fishing_interval = 0.2
	var interval_start = randf_range(0,0.8)
	var interval_end = interval_start + fishing_interval
	%FishingBar.visible = true
	%FishingBorder.visible = true
	
	var increasing = true
	var has_caught = false
	var speed = 3
	
	
	#load interval
	var fishing_rect = preload("res://fishing_rect_2.tscn")
	var right_interval = fishing_rect.instantiate()
	
	
	#make 2 rectangles for interval
	%PathFollow2D.progress_ratio = interval_start
	right_interval.global_position = %PathFollow2D.position  
	right_interval.global_position += Vector2(0,-12)

	%PathFollow2D.get_parent().add_child(right_interval)

	right_interval.z_index = 100
	var overlapping_bodies = %HurtBox.get_overlapping_bodies()
	#fishing sequence
	while not has_caught:
		overlapping_bodies = %HurtBox.get_overlapping_bodies()
		if overlapping_bodies.size() == 0:
			right_interval.queue_free()
			fishing = false
			%FishingBorder.visible = false
			%FishingRod.visible = false
			%FishingBar.visible = false
			return
		await get_tree().create_timer(0.01).timeout
		if increasing:
			%FishingBar.value += speed
			if %FishingBar.value >= 100:
				%FishingBar.value = 100
				increasing = false
		else:
			%FishingBar.value -= speed
			if %FishingBar.value <= 0:
				%FishingBar.value = 0
				increasing = true
		#fishing attempt
		if Input.is_action_just_pressed("interact"):  
			if (interval_start <= (%FishingBar.value / 100) and 
			(%FishingBar.value / 100) <= interval_end):
				$"Water-splash-46402".play()
				has_caught = true
				#show fish collection icon
				$"SalmonGainIcon-1_png".global_position = global_position + Vector2(0,-100)
				$"SalmonGainIcon-1_png".visible = true
				for i in range(1,15):
					await get_tree().create_timer(0.05).timeout
					$"SalmonGainIcon-1_png".position += Vector2(0,-5)
				
				$"SalmonGainIcon-1_png".visible = false
				get_parent().inc_score()
			else:
				$"Water-splash-46402".play()
				has_caught = true  
				
	#has caught fish or failed
	overlapping_bodies[0].get_node("BlueExclamationMark").visible = false
	overlapping_bodies[0].set_fished()
	
	%FishingRod.visible = false
	%FishingBorder.visible = false
	%FishingBar.visible = false
	right_interval.queue_free()
	
	fishing = false
