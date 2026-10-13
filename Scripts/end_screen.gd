extends Panel

@onready var header_text : Label = $Container/HeaderText

func set_screen (winning_team : String):
	visible = true
	header_text.text = winning_team + " HAS WON!"


func _on_menu_button_pressed() -> void:
	#load in menu screen
	pass # Replace with function body.
