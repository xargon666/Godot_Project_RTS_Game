extends Camera2D

@export var move_speed : float = 70.0
@export var zoom_amount : float = 0.2

func _process(delta: float) -> void:
	_move(delta)
	_zoom(delta)

func _move (delta):
	var input = Input.get_vector("cam_left","cam_right","cam_up","cam_down")
	var zoom_mod = 6.0 - zoom.x
	global_position += input * delta * move_speed * zoom_mod
	
func _zoom (_delta):
	var z = zoom.x
	
	if Input.is_action_just_released("zoom_in"):
		z += zoom_amount
	elif Input.is_action_just_released("zoom_out"):
		z -= zoom_amount
	
	z = clamp(z, 2.0, 4.0)
	
	zoom.x = z
	zoom.y = z
		
