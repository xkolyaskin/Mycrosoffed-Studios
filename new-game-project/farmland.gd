extends StaticBody2D

var plant_type

var prev_plant
var plantingSound

var grown = false
var plantable = true

func set_plantable(boo):
	plantable = boo

func is_farmland():
	return true

func planting_Sounds():
	plantingSound = randf()
	if plantingSound <= 0.25:
		$"FarmingSound1".play()
	elif plantingSound <= 0.5:
		$"FarmingSound2".play()
	elif plantingSound <= 0.75:
		$"FarmingSound3".play()
	elif plantingSound <= 1:
		$"FarmingSound4".play()
	return

func _on_plant(plant):
	if grown or not plantable:
		return
	plant_type = plant
	
	plantable = false
	match plant_type:
		"c":
			planting_Sounds()
			$CabbageSeeds.show()
			if prev_plant == "c":
				await get_tree().create_timer(10).timeout
			else:
				await get_tree().create_timer(5).timeout
			$CabbageSeeds.hide()
			$CabbageGrown.show()
		"b":
			planting_Sounds()
			$BeetSeeds.show()
			if prev_plant == "b":
				await get_tree().create_timer(9).timeout
			else:
				await get_tree().create_timer(5).timeout
			$BeetSeeds.hide()
			$BeetGrown.show()
		"p":
			planting_Sounds()
			$PotatoSeeds.show()
			if prev_plant == "p":
				await get_tree().create_timer(12).timeout
			else:
				await get_tree().create_timer(6).timeout
			$PotatoSeeds.hide()
			$PotatoGrown.show()
	prev_plant = plant_type
	grown = true
	
	
	
func on_harvest() -> String:
	if grown:
		$PotatoGrown.hide()
		$BeetGrown.hide()
		$CabbageGrown.hide()
	else:
		return ""
	grown = false
	plantable = true
	return plant_type
	
