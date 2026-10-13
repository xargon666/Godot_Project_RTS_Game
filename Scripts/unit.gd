extends Area2D
class_name Unit

signal OnTakeDamage (health : int, unit : Unit)
signal OnDie (unit : Unit)

@export var move_speed : float = 20.0

@export var cur_hp: int = 20
@export var max_hp : int = 20

@export var attack_range : float = 20.0
@export var attack_rate : float = 0.5
var last_attack_time : float
@export var attack_damage : int = 5

enum Team { PLAYER, AI}
@export var team : Team

var attack_target : Unit

@onready var agent : NavigationAgent2D = $NavigationAgent2D

#func _ready():
	#set_move_to_target(Vector2.ZERO)

func _process (delta):
	if not agent.is_navigation_finished():
		_move(delta)
	_target_check()

func _move (delta):
	var move_pos = agent.get_next_path_position()
	var move_dir = global_position.direction_to(move_pos)
	var movement = move_dir * move_speed * delta
		
	translate(movement)
	
func _target_check ():
	if attack_target == null:
		return
	
	var dist = global_position.distance_to(attack_target.global_position)
	
	if dist <= attack_range:
		agent.target_position = global_position
		_try_attack_target()
	else:
		agent.target_position = attack_target.global_position

func _try_attack_target():
	if cur_hp <= 0: return
	var time = Time.get_unix_time_from_system()
	if time - last_attack_time < attack_rate:
		return
	last_attack_time = time
	attack_target.take_damage(attack_damage)

func set_move_to_target (target : Vector2):
	agent.target_position = target
	attack_target = null

func set_attack_target (target : Unit):
	if target.team == team:
		return
	
	attack_target = target 

func take_damage (amount : int):
	cur_hp -= amount
	OnTakeDamage.emit(cur_hp,self)
	if cur_hp <= 0:
		_die()
	
func _die ():
	OnDie.emit(self)
	GlobalAudioManager.get_node("AudioStreamPlayer")._play_die_sfx(self)
	queue_free()
