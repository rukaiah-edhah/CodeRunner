extends Control

@onready var game_over_label = $g_label
@onready var restart_button = $restart
@onready var quit_button = $quit
@onready var next = $next
@onready var pulse = $pulse
@onready var border1 = $border1
@onready var border2 = $border1/border2
@onready var border3 = $border1/border3
@onready var border4 = $border1/border4
@onready var lighten = $lighten
@onready var shifu = $shifu
@onready var music = $AudioStreamPlayer

var audio = preload('res://fonts-and-music/music/player_death.mp3')
var font = preload("res://fonts-and-music/fonts/elnath/ELNATH.ttf")
# setting variables for timers
var type_speed = 0.10
var pulse_speed = 0.50
var current_character = 0
var current_pulse = 0
var label = 'GAME OVER'
# color variables
var red = 'd00000'
var black = '000000'

var current_light = 0
var modulates = ['505050', '505050', '505050', '585858', '585858', '787878', '787878', 'ffffff', 'ffffff',
'ffc3ba', 'ff9e90', 'ff5b4a', 'ff5b4a', 'd00000', 'd00000']

# Called when the node enters the scene tree for the first time.
func _ready():
	# assign music, darken bg
	music.stream = audio
	music.stream.loop = true
	$bg.modulate = '2f2f2f'
	# set labels and formatting
	game_over_label.add_theme_font_override('normal_font', font)
	game_over_label.add_theme_font_size_override("normal_font_size", 80)
	game_over_label.add_theme_constant_override('outline_size', 15)
	game_over_label.add_theme_color_override('font_outline_color', black)
	
	restart_button.text = 'RESTART'
	restart_button.add_theme_font_override('font', font)
	quit_button.text = 'QUIT'
	quit_button.add_theme_font_override('font', font)
	restart_button.add_theme_constant_override('outline_size', 10)
	quit_button.add_theme_constant_override('outline_size', 10)
	restart_button.add_theme_color_override('font_outline_color', black)
	quit_button.add_theme_color_override('font_outline_color', black)
	
	# set border color
	border1.color = black
	border2.color = black
	border3.color = black
	border4.color = black
	
	#change music
	music_change()
	# start label making
	start_label()


func music_change():
	# stop regular music and begin death music
	BgMusic.stop()
	music.play(0)


func start_label():
	# set variables and start timer
	current_character = 0

	next.set_wait_time(type_speed)
	next.start()


func start_pulse():
	# set variables for pulse timer and start
	current_pulse = 0
	
	pulse.set_wait_time(pulse_speed)
	pulse.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quit_pressed():
	# quit when they want to quit
	get_tree().quit()


func _on_restart_pressed():
	# check scene name and move back to restart correct scene if that is what you want to do
	print(get_tree().current_scene.name)
	if get_tree().current_scene.name == 'Intro_level':
		get_tree().change_scene_to_file('res://scenes/intro_level.tscn')
	if get_tree().current_scene.name == ('python_level'):
		get_tree().change_scene_to_file("res://scenes/python_level.tscn")


func _on_next_timeout():
	# print character by character until done w label
	if current_character < len(label):
		var next_character = label[current_character]
		game_over_label.text += next_character
		current_character += 1
	else:
		# if done with message go on to pulsing
		next.stop()
		next.one_shot = true
		start_pulse()
		start_lightening()


func _on_pulse_timeout():
	# pulse borders and outlines
	if current_pulse < 5:
		game_over_label.add_theme_color_override('font_outline_color', red)
		border1.color = red
		border2.color = red
		border3.color = red
		border4.color = red
		current_pulse += 1
	else:
		current_pulse = 0
		game_over_label.add_theme_color_override('font_outline_color', black)
		border1.color = black
		border2.color = black
		border3.color = black
		border4.color = black


func _on_restart_mouse_entered():
	# set text outlines to be different when hovered over
	restart_button.add_theme_color_override('font_outline_color', red)

func _on_restart_mouse_exited():
	restart_button.add_theme_color_override('font_outline_color', black)


func _on_quit_mouse_entered():
	quit_button.add_theme_color_override('font_outline_color', red)


func _on_quit_mouse_exited():
	quit_button.add_theme_color_override('font_outline_color', black)


func start_lightening():
	# set variables and start timer
	current_light = 0
	
	lighten.set_wait_time(0.06)
	lighten.start()


func _on_lighten_timeout():
	# show different colors on bg and animate shifu to fall asleep
	if current_light < 9:
		$bg.modulate = modulates[current_light]
		if current_light == 2:
			shifu.play('sleep')
	if current_light < 14:
		$bg.self_modulate = modulates[current_light]
		current_light += 1
	else:
		# show buttons and game over banner
		restart_button.visible = true
		quit_button.visible = true
		game_over_label.visible = true
