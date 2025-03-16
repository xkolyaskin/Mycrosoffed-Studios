extends Node

var dialogue_count = 0
var fishing_count = 0
var reindeer_count = 0
var farming_count = 0

func get_dialogue_count():
	dialogue_count += 1
	return dialogue_count
	
func get_fishing_count():
	fishing_count += 1
	return fishing_count

func get_reindeer_count():
	reindeer_count += 1
	return reindeer_count
		
func get_farming_count():
	farming_count += 1
	return farming_count


	
