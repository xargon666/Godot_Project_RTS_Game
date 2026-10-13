extends AudioStreamPlayer

var death_sound_ai = preload("res://Audio/death_enemy_1.wav")
var death_sound_player = preload("res://Audio/death_1.wav")
var take_damage = preload("res://Audio/take_damage.wav")

enum Team { PLAYER, AI}
func _play_die_sfx (unit : Unit):
	var chosen_sound
	match unit.team:
		Team.AI: 
			print("AI Died, playing sound...")
			chosen_sound = death_sound_ai
		Team.PLAYER: 
			print("Player Died, playing sound...")
			chosen_sound = death_sound_player
		_: chosen_sound = take_damage
		
	_play_sound(chosen_sound)

func _play_sound (audio : AudioStream):
	stream = audio
	var rand = randf_range(0.9,1.1)
	pitch_scale = rand
	volume_db = -4.0
	play()
