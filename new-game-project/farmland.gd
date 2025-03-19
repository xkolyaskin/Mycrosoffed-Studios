extends StaticBody2D

var plant_type

var prev_plant

var grown = false
var plantable = true

func set_plantable(boo):
	plantable = boo

func is_farmland():
	return true

func _on_plant(plant):
	if grown or not plantable:
		return
	plant_type = plant
	
	plantable = false
	match plant_type:
		"c":
			$CabbageSeeds.show()
			if prev_plant == "c":
				await get_tree().create_timer(10).timeout
			else:
				await get_tree().create_timer(5).timeout
			$CabbageSeeds.hide()
			$CabbageGrown.show()
		"b":
			$BeetSeeds.show()
			if prev_plant == "b":
				await get_tree().create_timer(9).timeout
			else:
				await get_tree().create_timer(5).timeout
			$BeetSeeds.hide()
			$BeetGrown.show()
		"p":
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
	
