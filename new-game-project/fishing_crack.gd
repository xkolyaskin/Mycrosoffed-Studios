extends StaticBody2D

@onready var player = get_node("/root/fishing_minigame/Player")

var is_cracked = false
var has_been_stepped_on = false

func _physics_process(delta):
	if is_cracked:
		return
	var overlapping = $HurtBox.get_overlapping_bodies()
	if overlapping.size() >= 1:
		has_been_stepped_on = true
	if overlapping.size() == 0 and has_been_stepped_on and not is_cracked:
		$IceHole.visible = true
		set_collision_layer_value(8, true)
		play_sound()
		is_cracked = true

func play_sound():
	$"Water-splash-46402".play()
