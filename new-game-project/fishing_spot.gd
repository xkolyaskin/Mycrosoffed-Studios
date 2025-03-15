extends StaticBody2D

var is_ready_to_fish = (randf() >= 0.5)
var preparing = false

func set_fished():
	is_ready_to_fish = false

func get_fished() -> bool:
	return is_ready_to_fish

func is_fishing() -> bool:
	return true

func _on_timer_timeout():
	if is_ready_to_fish:
		$BlueExclamationMark.visible = true
	if not preparing and not is_ready_to_fish:
		preparing = true
		await get_tree().create_timer(randf_range(5,20)).timeout
		$BlueExclamationMark.visible = true
		is_ready_to_fish = true
		preparing = false
