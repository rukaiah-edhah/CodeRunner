extends Node2D

@onready var start_button = $start_button
@onready var load_button = $load_button
@onready var options_button = $options_button
@onready var quit_button = $quit_button

var _font = preload("res://fonts/quiz_code_pages_font/LibreBaskerville-Regular.ttf")
var button_bg = preload("res://images/themes/purple_button.tres")

func _ready():
	# menu option labels
	start_button.text = "New Game"
	load_button.text = "Load Game"
	options_button.text = "Options"
	quit_button.text = "Quit"
	
	start_button.add_theme_font_override("font", _font)
	load_button.add_theme_font_override("font", _font)
	options_button.add_theme_font_override("font", _font)
	quit_button.add_theme_font_override("font", _font)
	
	start_button.add_theme_stylebox_override("normal", button_bg)
	load_button.add_theme_stylebox_override("normal", button_bg)
	options_button.add_theme_stylebox_override("normal", button_bg)
	quit_button.add_theme_stylebox_override("normal", button_bg)
	
	start_button.add_theme_stylebox_override("hover", button_bg)
	load_button.add_theme_stylebox_override("hover", button_bg)
	options_button.add_theme_stylebox_override("hover", button_bg)
	quit_button.add_theme_stylebox_override("hover", button_bg)
	
	start_button.add_theme_stylebox_override("pressed", button_bg)
	load_button.add_theme_stylebox_override("pressed", button_bg)
	options_button.add_theme_stylebox_override("pressed", button_bg)
	quit_button.add_theme_stylebox_override("pressed", button_bg)

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
