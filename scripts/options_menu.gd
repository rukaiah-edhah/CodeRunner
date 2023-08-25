extends Control

@onready var volume = $volume
@onready var brightness = $brightness
@onready var back = $back
@onready var slider = $volume/slider
@onready var mute = $volume/mute

var _font = preload("res://fonts-and-music/fonts/quiz_code_pages_font/LibreBaskerville-Regular.ttf")
var button_bg = preload("res://images/themes/purple_button.tres")
# Called when the node enters the scene tree for the first time.
func _ready():
    slider.visible = false
    mute.visible = false
    
    # set min and max values of the hslider to the min and max values of the volume_db property
    slider.min_value = -80
    slider.max_value = 24
    
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
    # set them to appear and dissappear when button is pressed
    if slider.visible == false:
        slider.visible = true
        mute.visible = true
    else:
        slider.visible = false
        mute.visible = false

func _on_brightness_pressed():
    # allow for in-game brightness adjustment (maybe do later - or get rid of)
    pass # Replace with function body.

func _on_back_pressed():
    # allow for player to go back to main menu
    get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_slider_value_changed(value):
    # change volume based on slider value
    BgMusic.volume_db = value
    # when slider value reaches the minimum, automatically set the mute button to pressed, otherwise unpressed
    if value > -80:
        mute.button_pressed = false
    else:
        mute.button_pressed = true


func _on_mute_toggled(button_pressed):
    # when mute button is pressed, muted
    if button_pressed == true:
        BgMusic.volume_db = -80
    else:
        BgMusic.volume_db = slider.value
