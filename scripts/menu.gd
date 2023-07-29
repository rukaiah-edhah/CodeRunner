extends Node2D

var load_saved_game = false #start with fresh game

var save_path = "user://savegame.json" #file path

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

func _on_load_button_pressed(): #press the load to access saved files
	load_saved_game = true
	var file = FileAccess.open(save_path, FileAccess.READ)
	
	if file.file_exists(save_path):
		file = FileAccess.open(save_path, FileAccess.READ)
		var json = JSON.new()
		var data = JSON.parse_string(file.get_as_text())
		
		#%Player.from_dictionary(data.player)
		#%Level.from_dictionary(data.level)
