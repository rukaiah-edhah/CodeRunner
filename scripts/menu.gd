extends Node2D

func _ready():
	# menu option labels
	$start_button.text = "Start"
	$load_button.text = "Load Game"
	$options_button.text = "Options"
	$quit_button.text = "Quit"

func _on_start_button_pressed():
	# when you press start -> go to game
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_options_button_pressed():
	# when you press options -> go to options menu
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")

func _on_quit_button_pressed():
	# when you press quit -> leave game 
	get_tree().quit()

func _on_load_button_pressed():
	# when you press load game (must be filled later when shevan is done with save functions)
	pass # Replace with function body.
