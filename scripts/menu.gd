extends Node2D

var load_saved_game = false #start with fresh game

var save_path = "res://savegame.json" #file path

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
	load_game()

func load_game():
	load_saved_game = true
	#Handling Exceptions
	if not FileAccess.file_exists("res://savegame.save"): #no save file
		print("Error! We don't have a save to load.")
	
	#delete the data in the save file
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		i.queue_free()
		
	var save_game = FileAccess.open("res://savegame.save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		#Get the data from the JSON object
		var node_data = json.get_data()

		#Firstly, we need to create the object and add it to the tree and set its position.
		var new_object = load(node_data["filename"]).instantiate()
		get_node(node_data["parent"]).add_child(new_object)
		new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])

		#Now we set the remaining variables.
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			new_object.set(i, node_data[i])
