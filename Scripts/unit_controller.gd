extends Node2D

var selected_unit : Unit

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_try_select_unit()
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			_try_command_unit()
			
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			_unselect_unit()
	
func _try_select_unit():
	var unit = _get_selected_unit()
	
	if unit == null or unit.team != Unit.Team.PLAYER:
		_unselect_unit()
	else:
		_select_unit(unit)

func _select_unit (unit : Unit):
	_unselect_unit()
	selected_unit = unit
	unit.get_node("PlayerUnit").toggle_selection_visual(true)
	
func _unselect_unit ():
	if selected_unit != null:
		selected_unit.get_node("PlayerUnit").toggle_selection_visual(false)
	selected_unit = null

func _try_command_unit ():
	if selected_unit == null:
		return
	
	var target = _get_selected_unit()
	
	if target != null:
		if target.team != Unit.Team.PLAYER:
			selected_unit.set_attack_target(target)
	else:
		selected_unit.set_move_to_target(get_global_mouse_position())

func _get_selected_unit () -> Unit:
	var space = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	query.collide_with_areas = true
	var intersection = space.intersect_point(query ,1)
	
	if intersection.is_empty():
		return null
	
	if intersection[0].collider is not Unit:
		return null
	
	return intersection[0].collider
	
