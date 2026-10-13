extends Sprite2D

@onready var unit : Unit = get_parent()

var unit_pos_last_frame : Vector2

func _ready ():
	unit.OnTakeDamage.connect(_damage_flash)

func _process (_delta):
	var time = Time.get_unix_time_from_system()
	var r = sin(time * 10) * 5
	
	if unit.global_position.distance_to(unit_pos_last_frame) == 0:
		r = 0
	
	rotation = deg_to_rad(r)
	
	var dir = unit.global_position.x - unit_pos_last_frame.x
	
	if dir > 0:
		flip_h = false
	elif dir < 0:
		flip_h = true
		
	unit_pos_last_frame = unit.global_position

func  _damage_flash (_health : int,_unit:Unit):
	modulate = Color.RED
	await get_tree().create_timer(0.05).timeout
	modulate = Color.WHITE
