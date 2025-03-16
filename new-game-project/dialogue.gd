extends Node2D
@onready var dialogue_box = $DialogueBox
@onready var talking_audio = $Talking

var scene
var dialogueIntro = "Hey there, how are you doing? I’m Otap, one of the village elders. We could use some help keeping our village fed."

var dialogueFarm1_1 = "While we do love our meat, a balanced diet requires some veggies too. Can you help me in the garden this summer?"
var dialogueFarm1_2 = "Choose your seeds, plant them, and wait for them to grow. Harvest your crops before they go bad. Use WASD to move and E/SPACE to pick up/plant."

var dialogueFish1_1 = "Salmon is one of the most important foods here, but fishing is no easy work."
var dialogueFish1_2 = "Walk up to the fishing hole and when indicated, press SPACE or E at the right time to catch a fish. Catch enough fish and you will succeed."

var dialogueHerd1_1 = "Reindeer herding has sustained our culture for thousands of years, and over this time we have learned to find spots with lots of food for them."
var dialogueHerd1_2 = "A favorite of theirs is lichen, which grows under the snow around these parts."
var dialogueHerd1_3 = "Guide them to the green lichen patches and make sure they don’t wander too far."

var dialogueFarm2_1 = "One of the best things the Russians brought was telnoye."
var dialogueFarm2_2 = "This amazing dish consists of a mashed potato base with a mixture of salmon, eggs, flour, onions, dried porcini mushrooms and other plants."
var dialogueFarm2_3 = "Mmmm, actually, can you spare a few potatoes once you’re done?"

var dialogueFish2_1 = "I could really go for some yukola right now."
var dialogueFish2_2 = "The heavenly mixture of crushed dried salmon, red caviar, shiksha, pine, nuts, red bilberries, and other medicinal herbs always brightens my day."
var dialogueFish2_3 = "Unfortunately, it's been harder to fish with such unstable ice nowadays...  It's getting too hot too early in the year."

var dialogueHerd2_1 = "Oh, how I sometimes miss the good old days.  When I was a young man, I could take my reindeer to the same place every year to find food."
var dialogueHerd2_2 = "Everything’s been so hot the past few years… We’ve seen more rain than ever before. No good when it rains right after a good snowstorm."
var dialogueHerd2_3 = "Nowadays you youngins have to keep moving the reindeer to new spots when rainfall freezes the snow above the lichen."

var dialogueFarm3_1 = "Back in my day, farming was collectivized under the rule of the Soviet Union. We had to rotate crops in order to feed ourselves every year."
var dialogueFarm3_2 = "Nowadays they tell me that the climate has been worsening, and there have been freezes that destroy our entire crop in late summer."
var dialogueFarm3_3 = "Make sure to plant a different crop after harvesting to make your crops healthier and your soil more nutritious."

var dialogueFish3_1 = "Everything is so warm nowadays, even the ice isn’t as sturdy as it once was."
var dialogueFish3_2 = "Our fishermen have to keep moving if they don’t want to end up in the river. But don’t worry, the river isn’t too deep (I hope)."

var dialogueHerd3_1 = "While I do love caring for reindeer, their hide is amazingly warm."
var dialogueHerd3_2 = "Every once in a while I would have to kill one of my reindeer for the village to use its meat and hide."
var dialogueHerd3_3 = "I met a reindeer herder the other day who said their village burned down due to a wildfire. "
var dialogueHerd3_4 = "Never thought it could happen. The times really are changing."

var dialogueEnd_1 = "This is the worst (and only) wildfire I’ve ever seen!"

var dialogueEndGood_1 = "The village is in ruins, but we will survive. We Karyak are strong."
var dialogueEndGood_2 = "Due to your help, we have enough resources to rebuild and recover, though much was lost."

var dialogueEndBad_1 = "The village is in ruins, but we will survive. We Karyak are strong."
var dialogueEndBad_2 = "We don’t have enough resources to rebuild. Our people will have to be relocated to a safer location for the time being."

var randomDialogue = [
	"The Chawchu dance was one of my favorite things to watch and perform. I played the lalai drum, which I once broke by hitting it with my head.",
	"I once traveled from Tilichiki in a blizzard while being pulled by my blind dog, Dimitri. We had to cover ourselves in mud to hide from a bear.",
	"When I was a kid I loved sliding across the river ice with my friends. My friend Pepe once slid across on his bare stomach. He did not enjoy that.",
	"Did I ever tell you about my brothers? There were… uh… 20 of them. That would take too long to explain, I’ll tell you another time.",
	"Hey, have you seen my cane? I think it's buried in the snow somewhere around here.",
	"I once saw a reindeer so big I thought that even I could ride it. The reindeer thought otherwise.",
	"There was once a terrible blizzard that dumped so much snow it covered my entire house. It took me an entire day to dig myself out.",
	"I’ve heard rumors of a wild Purdue Pete fish in the rivers nearby…",
	"People often ask how I survive without my sight, let's just say I’m a really good elder.",
	"There’s something to be said about a salmon hot dog that most people just don’t understand.",
	"Where’s the fun in taking things one step at a time?",
	"We used to get enough snow to build a city when I was young. There’s only enough for a town these days.",
	"We get our power from oil, which I’ve been told is ‘not cool anymore’."
]

var usedDialogue = []

func _ready():
	scene = GlobalCountTracker.get_dialogue_count()
	#scene = 10
	if scene == 10:
		$ColorRect.show()
	print("dialogue number " + str(scene))
	$Fire/move.play("move")
	await get_tree().create_timer(1).timeout
	
	match scene:
		
		1:
			
			await play_dialogue(dialogueIntro)
			print("next")
			await play_dialogue(dialogueFarm1_1)
			print("next")
			await play_dialogue(dialogueFarm1_2)
			print("next_scene")
			FadeToBlack.change_scene_with_fade("res://Visual Assets/Farming.tscn")
		2:
			await play_dialogue(pickRandom())
			
			await play_dialogue(dialogueFish1_1)
			print("next")
			await play_dialogue(dialogueFish1_2)
			print("next_scene")
			FadeToBlack.change_scene_with_fade("res://fishing_minigame.tscn")

		3:
			await play_dialogue(pickRandom())
			
			await play_dialogue(dialogueHerd1_1)
			print("next")
			await play_dialogue(dialogueHerd1_2)
			print("next")
			await play_dialogue(dialogueHerd1_3)
			print("next_scene")
			FadeToBlack.change_scene_with_fade("res://reindeer_herding.tscn")

		4:
			await play_dialogue(pickRandom())
			
			await play_dialogue(dialogueFarm2_1)
			print("next")
			await play_dialogue(dialogueFarm2_2)
			print("next")
			await play_dialogue(dialogueFarm2_3)
			print("next_scene")
			FadeToBlack.change_scene_with_fade("res://Visual Assets/Farming.tscn")

			
		5:
			await play_dialogue(pickRandom())
			
			await play_dialogue(dialogueFish2_1)
			print("next")
			await play_dialogue(dialogueFish2_2)
			await play_dialogue(dialogueFish2_3)
			
			FadeToBlack.change_scene_with_fade("res://fishing_minigame.tscn")
			print("next_scene")
		6:
			await play_dialogue(pickRandom())
			
			await play_dialogue(dialogueHerd2_1)
			print("next")
			await play_dialogue(dialogueHerd2_2)
			await play_dialogue(dialogueHerd2_3)
			print("next_scene")
			FadeToBlack.change_scene_with_fade("res://reindeer_herding.tscn")
		7:
			await play_dialogue(pickRandom())
			
			await play_dialogue(dialogueFarm3_1)
			print("next")
			await play_dialogue(dialogueFarm3_2)
			await play_dialogue(dialogueFarm3_3)
			FadeToBlack.change_scene_with_fade("res://Visual Assets/Farming.tscn")
			print("next_scene")
		8:
			await play_dialogue(pickRandom())
			
			await play_dialogue(dialogueFish3_1)
			print("next")
			await play_dialogue(dialogueFish3_2)
			print("next_scene")
			FadeToBlack.change_scene_with_fade("res://fishing_minigame.tscn")
		9:
			await play_dialogue(pickRandom())
			
			await play_dialogue(dialogueHerd3_1)
			print("next")
			await play_dialogue(dialogueHerd3_2)
			print("next")
			await play_dialogue(dialogueHerd3_3)
			print("next_scene")
			FadeToBlack.change_scene_with_fade("res://reindeer_herding.tscn")
		10:
			
			var burning_scene = preload("res://ending.tscn").instantiate()
			burning_scene.z_index = 120
			add_child(burning_scene)
			$DialogueBox.z_index = 127
			$ColorRect.modulate.a = 0.95
			await get_tree().create_timer(0.5).timeout
			$ColorRect.modulate.a = 0.9
			await get_tree().create_timer(0.5).timeout
			$ColorRect.modulate.a = 0.85
			await get_tree().create_timer(0.5).timeout
			$ColorRect.modulate.a = 0.8
			await get_tree().create_timer(0.5).timeout
			$ColorRect.modulate.a = 0.7
			await get_tree().create_timer(0.5).timeout
			$ColorRect.modulate.a = 0.5
			await get_tree().create_timer(0.5).timeout
			$ColorRect.modulate.a = 0.3
			await get_tree().create_timer(0.5).timeout
			$ColorRect.modulate.a = 0.1
			await get_tree().create_timer(0.5).timeout
			$ColorRect.hide()
			

			
			await play_dialogue(dialogueEnd_1)
			if GlobalCountTracker.score_is_good():
				await play_dialogue(dialogueEndGood_1)
				await play_dialogue(dialogueEndGood_2)
			else:
				await play_dialogue(dialogueEndBad_1)
				await play_dialogue(dialogueEndBad_2)
			FadeToBlackSpecial.change_scene_with_fade("res://credits.tscn",true)
			await play_credits()
			
	scene+=1
func pickRandom():
	randomDialogue=GlobalCountTracker.get_random_dialogue()
	var ind = randi_range(0,len(randomDialogue)-1)   
	var line = randomDialogue[ind]
	randomDialogue.remove_at(ind)
	usedDialogue.append(line)
	GlobalCountTracker.set_random_dialogue(randomDialogue)
	return line

func play_dialogue(string):
	if not dialogue_box.is_typing():
		dialogue_box.visible = true
		talking_audio.playing = true
		await dialogue_box.type_text(string)
		talking_audio.playing = false
	while(true):
		await get_tree().create_timer(0.01).timeout
		if Input.is_action_just_pressed("interact") and not dialogue_box.is_typing(): 
			dialogue_box.visible = false
			return

func play_credits():
	print("play credits")
	return
