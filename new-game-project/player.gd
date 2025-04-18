extends CharacterBody2D
var fishing = false
var can_move = true
var seed_holding = "c"


signal plant_b
signal plant_c
signal plant_p

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
		elif overlapping_bodies[0].has_method("is_seed_bag") and Input.is_action_just_pressed("interact"):
			pick_up_seed(overlapping_bodies[0].is_seed_bag())
		elif overlapping_bodies[0].has_method("is_farmland") and Input.is_action_just_pressed("interact"):
			plant_seed(overlapping_bodies[0])
			harvest_seed(overlapping_bodies[0])

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
	var needs_to_fish_again = false
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
				var refish_chance = randf()
				if refish_chance < 0.3:
					needs_to_fish_again = true
					break
				has_caught = true
				# fishing sequence
				
				var fish_value = randf()
				
				if fish_value < 0.01: #purdue pete
					$PurduePeteGainIcon.global_position = global_position + Vector2(0,-100)
						#show fish collection icon
					$PurduePeteGainIcon.global_position = global_position + Vector2(0,-100)
					$PurduePeteGainIcon.visible = true
					for i in range(1,15):
						await get_tree().create_timer(0.05).timeout
						$PurduePeteGainIcon.position += Vector2(0,-5)
					$PurduePeteGainIcon.visible = false
					get_parent().inc_score(10)
					
				elif fish_value < 0.10: #taimen 
					#show fish collection icon
					$"SalmonGainIcon-1_png".global_position = global_position + Vector2(0,-100)
					$"SalmonGainIcon-1_png".scale = Vector2(2, 2)
					$"SalmonGainIcon-1_png".visible = true
					
					for i in range(1,15):
						await get_tree().create_timer(0.05).timeout
						$"SalmonGainIcon-1_png".position += Vector2(0,-5)
						
					get_parent().inc_score(5)
					$"SalmonGainIcon-1_png".visible = false
				elif fish_value < 0.70: #salmon
					$SalmonIcon.global_position = global_position + Vector2(0,-100)
					$SalmonIcon.scale = Vector2(1.2, 1.2)
					$SalmonIcon.visible = true
					for i in range(1,15):
						await get_tree().create_timer(0.05).timeout
						$SalmonIcon.position += Vector2(0,-5)
					
					get_parent().inc_score(3)
					$SalmonIcon.visible = false
				elif fish_value < 0.90: # grayling
					$Grayling.global_position = global_position + Vector2(0,-100)
					$Grayling.visible = true
					for i in range(1,15):
						await get_tree().create_timer(0.05).timeout
						$Grayling.position += Vector2(0,-5)
					
					get_parent().inc_score()
					$Grayling.visible = false
				else: #trash
					$Trash.global_position = global_position + Vector2(0,-100)
					$Trash.visible = true
					for i in range(1,15):
						await get_tree().create_timer(0.05).timeout
						$Trash.position += Vector2(0,-5)
					$Trash.visible = false
			else:
				$"Water-splash-46402".play()
				has_caught = true  
				
	if not needs_to_fish_again:
		#has caught fish or failed
		overlapping_bodies[0].get_node("BlueExclamationMark").visible = false
		overlapping_bodies[0].set_fished()
		
		%FishingRod.visible = false
		%FishingBorder.visible = false
		%FishingBar.visible = false
	right_interval.queue_free()
	
	fishing = false
	


func pick_up_seed(string):
	seed_holding = string
	print("seed holding: " + string)
	
func plant_seed(farmland):
	farmland._on_plant(seed_holding)
	
func harvest_seed(farmland):
	var plant_harvested = farmland.on_harvest()
	match plant_harvested:
		"c":
			$CabbageGainIcon.global_position = global_position + Vector2(0,-50)
			$CabbageGainIcon.visible = true
			for i in range(1,10):
				await get_tree().create_timer(0.05).timeout
				$CabbageGainIcon.position += Vector2(0,-3)
			$CabbageGainIcon.visible = false
			get_parent().inc_score(5)
		"b":
			$TurnipGainIcon.global_position = global_position + Vector2(0,-50)
			$TurnipGainIcon.visible = true
			for i in range(1,10):
				await get_tree().create_timer(0.05).timeout
				$TurnipGainIcon.position += Vector2(0,-3)
			$TurnipGainIcon.visible = false
			get_parent().inc_score(4)
		"p":
			$PotatoGainIcon.global_position = global_position + Vector2(0,-50)
			$PotatoGainIcon.visible = true
			for i in range(1,10):
				await get_tree().create_timer(0.05).timeout
				$PotatoGainIcon.position += Vector2(0,-3)
			$PotatoGainIcon.visible = false
			get_parent().inc_score(6)
