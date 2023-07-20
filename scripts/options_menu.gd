extends Control

@onready var volume = $volume
@onready var brightness = $brightness
@onready var back = $back
var _font = preload("res://fonts/quiz_page_font/LibreBaskerville-Regular.ttf")
var button_bg = preload("res://images/purple_button.tres")
# Called when the node enters the scene tree for the first time.
func _ready():
	# menu labels for options menu
	volume.text = "Volume"
	brightness.text = "Brightness"
	back.text = "Back"
	
	volume.add_theme_font_override("font", _font)
	brightness.add_theme_font_override("font", _font)
	back.add_theme_font_override("font", _font)
	
	volume.add_theme_stylebox_override("normal", button_bg)
	brightness.add_theme_stylebox_override("normal", button_bg)
	back.add_theme_stylebox_override("normal", button_bg)
	
	volume.add_theme_stylebox_override("hover", button_bg)
	brightness.add_theme_stylebox_override("hover", button_bg)
	back.add_theme_stylebox_override("hover", button_bg)
	
	volume.add_theme_stylebox_override("pressed", button_bg)
	brightness.add_theme_stylebox_override("pressed", button_bg)
	back.add_theme_stylebox_override("pressed", button_bg)
	
func _on_volume_pressed():
	# allow for volume control (must do later)
	pass # Replace with function body.

func _on_brightness_pressed():
	# allow for in-game brightness adjustment (maybe do later - or get rid of)
	pass # Replace with function body.

func _on_back_pressed():
	# allow for player to go back to main menu
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
