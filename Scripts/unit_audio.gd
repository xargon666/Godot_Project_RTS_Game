extends AudioStreamPlayer

var pain_sounds_player : Array[AudioStream] = [
	preload("res://Audio/pain_1.wav"),
	preload("res://Audio/pain_2.wav"),
	preload("res://Audio/pain_3.wav")
]

var pain_sounds_ai : Array[AudioStream ] = [
	preload("res://Audio/pain_enemy_1.wav")
]

enum Team { PLAYER, AI}

func _ready ():
	var unit = get_parent()
	unit.OnTakeDamage.connect(_play_take_damage_sfx)

func _play_take_damage_sfx (health : int, unit : Unit):
	var chosen_sound
	if health > 0: 
		if unit.team == Team.AI:
			chosen_sound = pain_sounds_ai.pick_random()
		if unit.team == Team.PLAYER:
			chosen_sound = pain_sounds_player.pick_random()
	_play_sound(chosen_sound)

func _play_sound (audio : AudioStream):
	stream = audio
	var rand = randf_range(0.9,1.1)
	pitch_scale = rand
	volume_db = -4.0
	play()
