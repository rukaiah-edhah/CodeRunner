extends Control

@onready var volume_button = $volume_button
@onready var volume_bar = $volume_button/volume_bar
@onready var mute_button = $volume_button/mute_button

var font = preload('res://fonts-and-music/fonts/quiz_code_pages_font/LibreBaskerville-Bold.ttf')
var button = preload('res://images/themes/button_bg.tres')


# Called when the node enters the scene tree for the first time.
func _ready():
	# do not let these become visible unless volume button is pressed
	volume_bar.visible = false
	mute_button.visible = false
	
	# set text, themes, etc.
	volume_button.text = 'VOLUME'
	
	volume_button.add_theme_font_override('font', font)
	volume_button.add_theme_font_size_override('font_size', 10)
	
	volume_button.add_theme_stylebox_override('normal', button)
	volume_button.add_theme_stylebox_override('hover', button)
	volume_button.add_theme_stylebox_override('pressed', button)
	
	# set min and max values of the hslider to the min and max values of the volume_db property
	volume_bar.min_value = -80
	volume_bar.max_value = 24


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_volume_button_pressed():
	# set them to appear and dissappear when button is pressed
	if volume_bar.visible == false:
		volume_bar.visible = true
		mute_button.visible = true
	else:
		volume_bar.visible = false
		mute_button.visible = false


func _on_volume_bar_value_changed(value):
	# change volume based on slider value
	BgMusic.volume_db = value
	# when slider value reaches the minimum, automatically set the mute button to pressed, otherwise unpressed
	if value > -80:
		mute_button.button_pressed = false
	else:
		mute_button.button_pressed = true


func _on_mute_button_toggled(button_pressed):
	# when mute button is pressed, muted
	if button_pressed == true:
		BgMusic.volume_db = -80
	else:
		BgMusic.volume_db = volume_bar.value
