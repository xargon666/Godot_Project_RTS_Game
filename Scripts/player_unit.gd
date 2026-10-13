extends Node2D

@onready var selection_visual = $"../SelectionVisual"

func toggle_selection_visual (toggle: bool): 
	selection_visual.visible = toggle
