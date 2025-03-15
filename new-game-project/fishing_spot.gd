extends StaticBody2D

var is_ready_to_fish = (randf() >= 0.5)
var preparing = false

func set_fished():
	is_ready_to_fish = false

func is_fishing() -> bool:
	return true

func _on_timer_timeout():
	if preparing and not is_ready_to_fish:
		preparing = true
		await get_tree().create_timer(randf_range(10,20)).timeout
		$BlueExclamationMark.visible = true;
		is_ready_to_fish = true
		preparing = false
