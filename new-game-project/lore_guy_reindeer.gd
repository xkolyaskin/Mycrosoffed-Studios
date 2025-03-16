extends StaticBody2D

var is_eating = 0

func _on_timer_timeout():
	if (is_eating % 5 == 0):
		$"Reindeer-1_png".visible = false
		$"ReindeerEatingPlaceholder".visible = true
	else:
		$"Reindeer-1_png".visible = true
		$"ReindeerEatingPlaceholder".visible = false
	is_eating += 1
		
