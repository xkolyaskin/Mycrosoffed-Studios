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
			fish()




func fish():
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
	
	var fishing_rect = preload("res://fishing_rect.tscn")
	var right_interval = fishing_rect.instantiate()
	var left_interval = fishing_rect.instantiate()
	
	
	# Set the positions along the path
	%PathFollow2D.progress_ratio = interval_start
	left_interval.global_position = %PathFollow2D.position  # Get global position from PathFollow2D

	%PathFollow2D.progress_ratio = interval_end
	right_interval.global_position = %PathFollow2D.position

	# Add them to the scene
	%PathFollow2D.get_parent().add_child(left_interval)
	%PathFollow2D.get_parent().add_child(right_interval)

	# Optionally adjust Z index to make sure they're on top
	left_interval.z_index = 100
	right_interval.z_index = 100
	
	while not has_caught:
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
