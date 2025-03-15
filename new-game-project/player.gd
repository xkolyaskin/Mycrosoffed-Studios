extends CharacterBody2D

func _physics_process(delta):	
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * 200
	move_and_slide()
	var overlapping_bodies = %HurtBox.get_overlapping_bodies()
	if overlapping_bodies.size() > 0:
		var fishing = false
		if overlapping_bodies[0].has_method("is_fishing"):
			if !fishing:
				fish()
			fishing = true
			
	



func fish():
	var fishing_interval = Vector2(0.4,0.6)
	%FishingBar.visible = true
	var increasing = true
	var has_caught = false
	while (!has_caught):
		await get_tree().create_timer(0.1).timeout
		if increasing:
			%FishingBar.value += %FishingBar.value + 1
			if %FishingBar.value == %FishingBar.max_value:
				increasing = false;
		else:
			%FishingBar.value += %FishingBar.value - 1
			if %FishingBar.value == %FishingBar.min_value:
				increasing = true;
