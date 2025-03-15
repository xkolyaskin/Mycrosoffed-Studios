extends CharacterBody2D
var fishing = false


@onready
var _animatedBody = $PlayerSprite/AnimatedSprite2D


func _physics_process(delta):	
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * 200
	if velocity != Vector2.ZERO:
		_animatedBody.play("walk")
		if velocity.x < 0:
			_animatedBody.flip_h=true
		elif velocity.x > 0:
			_animatedBody.flip_h=false
	else:
		_animatedBody.stop()
		_animatedBody.set_frame_and_progress(3,0.5)
	move_and_slide()
	var overlapping_bodies = %HurtBox.get_overlapping_bodies()
	if overlapping_bodies.size() > 0:
		if overlapping_bodies[0].has_method("is_fishing"):
			fish(overlapping_bodies[0])




func fish(fishing_spot):
	
	if fishing:
		return
	fishing = true
	var fishing_interval = 0.2
	var interval_start = randf_range(0,0.8)
	var interval_end = interval_start + fishing_interval
	%FishingBar.visible = true
	var increasing = true
	var has_caught = false
	var speed = 3
	
	
	#load interval
	var fishing_rect = preload("res://fishing_rect.tscn")
	var right_interval = fishing_rect.instantiate()
	var left_interval = fishing_rect.instantiate()
	
	#make 2 rectangles for interval
	%PathFollow2D.progress_ratio = interval_start
	left_interval.global_position = %PathFollow2D.position  

	%PathFollow2D.progress_ratio = interval_end
	right_interval.global_position = %PathFollow2D.position

	%PathFollow2D.get_parent().add_child(left_interval)
	%PathFollow2D.get_parent().add_child(right_interval)
	left_interval.z_index = 100
	right_interval.z_index = 100
	
	#fishing sequence
	while not has_caught:
		if %HurtBox.get_overlapping_bodies().size() == 0:
			left_interval.queue_free()
			right_interval.queue_free()
			fishing = false
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
				emit_signal("fish_caught")  
				has_caught = true
				$"SalmonGainIcon-1_png".global_position = global_position + Vector2(0,-100)
				$"SalmonGainIcon-1_png".visible = true
				for i in range(1,15):
					await get_tree().create_timer(0.05).timeout
					$"SalmonGainIcon-1_png".position += Vector2(0,-5)
				
				$"SalmonGainIcon-1_png".visible = false
			else:
				emit_signal("fish_failed")
				has_caught = true  
	%FishingBar.visible = false
	left_interval.queue_free()
	right_interval.queue_free()
	%HurtBox.get_overlapping_bodies()[0].set
	
	#show fish collection icon
	
	
	fishing = false
