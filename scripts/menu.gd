extends Node2D

@onready var start_button = $start_button
@onready var load_button = $load_button
@onready var options_button = $options_button
@onready var quit_button = $quit_button

#var _font = preload("res://fonts-and-music/fonts/quiz_code_pages_font/LibreBaskerville-Regular.ttf")
#var button_bg = preload("res://images/themes/purple_button.tres")

#background music path
const music_path: String = "res://fonts-and-music/music/DavidKBD - Cosmic Pack 03 - Nebula Run-variation5.ogg"
func _ready():
    pass
    # menu option labels
    #start_button.text = "New Game"
    #load_button.text = "Load Game"
    #options_button.text = "Options"
    #quit_button.text = "Quit"
    
    
    #start_button.add_theme_font_override("font", _font)
    #load_button.add_theme_font_override("font", _font)
    #options_button.add_theme_font_override("font", _font)
    #quit_button.add_theme_font_override("font", _font)
    
    #start_button.add_theme_stylebox_override("normal", button_bg)
    #load_button.add_theme_stylebox_override("normal", button_bg)
    #options_button.add_theme_stylebox_override("normal", button_bg)
    #quit_button.add_theme_stylebox_override("normal", button_bg)
    
    #start_button.add_theme_stylebox_override("hover", button_bg)
    #load_button.add_theme_stylebox_override("hover", button_bg)
    #options_button.add_theme_stylebox_override("hover", button_bg)
    #quit_button.add_theme_stylebox_override("hover", button_bg)
    
    #start_button.add_theme_stylebox_override("pressed", button_bg)
    #load_button.add_theme_stylebox_override("pressed", button_bg)
    #options_button.add_theme_stylebox_override("pressed", button_bg)
    #quit_button.add_theme_stylebox_override("pressed", button_bg)


func _on_start_button_pressed():
    # when you press start -> go to game
    get_tree().change_scene_to_file("res://scenes/intro_level.tscn")

func _on_options_button_pressed():
    # when you press options -> go to options menu
    get_tree().change_scene_to_file("res://scenes/options_menu.tscn")

func _on_quit_button_pressed():
    # when you press quit -> leave game 
    get_tree().quit()

func _on_load_button_pressed():
    #Handling Exceptions
    if not FileAccess.file_exists("res://savegame.json"): #no save file
        print("Error! We don't have a save to load.")
    
    
    var save_nodes = get_tree().get_nodes_in_group("Persist")
    for i in save_nodes:
        i.queue_free() #delete the curent node in Persist group
    
    var save_game = FileAccess.open("res://savegame.json", FileAccess.READ)
    """
    var json = JSON.new()
    var content = save_game.get_as_text()
    var json_data = json.parse_string(content)
    
    if json_data == null:
        print("Failed to parse JSON data.")
        return
    
    print(json_data)
    var file_name = json_data["filename"]
    print(file_name)

    var pos_x = json_data["pos_x"]
    print(pos_x)

    var pos_y= json_data["pos_y"]
    print(pos_y)
    var postion_x
    """
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

