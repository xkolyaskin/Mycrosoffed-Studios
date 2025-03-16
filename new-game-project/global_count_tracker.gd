extends Node

var dialogue_count = 0
var fishing_count = 0
var reindeer_round_count = 0
var farming_count = 0
var reindeer_count = 5
var lichen_count=8

func get_dialogue_count():
	dialogue_count += 1
	return dialogue_count
	
func get_fishing_count():
	fishing_count += 1
	return fishing_count

func get_reindeer_round_count():
	reindeer_round_count += 1
	return reindeer_round_count
	
func get_reindeer_count():
	return reindeer_count;
	
func set_reindeer_count(num):
	reindeer_count=num

func get_lichen_count():
	return lichen_count

func set_lichen_count(num):
	lichen_count=num

func get_farming_count():
	farming_count += 1
	return farming_count


	
