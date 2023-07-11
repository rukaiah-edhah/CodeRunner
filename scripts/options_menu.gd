extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	# menu labels for options menu
	$volume.text = "Volume"
	$brightness.text = "Brightness"
	$back.text = "Back"

func _on_volume_pressed():
	# allow for volume control (must do later)
	pass # Replace with function body.

func _on_brightness_pressed():
	# allow for in-game brightness adjustment (maybe do later - or get rid of)
	pass # Replace with function body.

func _on_back_pressed():
	# allow for player to go back to main menu
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
