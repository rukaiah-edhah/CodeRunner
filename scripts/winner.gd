extends Control

@onready var winner_label = $congratulations
@onready var menu_button = $menu
@onready var quit_button = $quit
@onready var next = $next
@onready var border1 = $border1
@onready var border2 = $border1/border2
@onready var border3 = $border1/border3
@onready var border4 = $border1/border4
@onready var shifu_next_c = $shifu_nextc
@onready var shifu_next_m = $shifu_nextm
@onready var shifu_message = $shifu/shifu_message
@onready var lighten = $lighten
@onready var shifu = $shifu
@onready var shifu_audio = $shifu_audio

var audio = preload('res://fonts-and-music/music/shifu.mp3')

var font = preload("res://fonts-and-music/fonts/elnath/ELNATH.ttf")
var button = preload("res://images/themes/button_bg.tres")

# different hex codes to make bg slowly lighter later
var modulates = ['3d3d3d', '4d4d4d', '787878', 'ffffff', 'ffffff', 'e1ffde', 'cbffc5', 'b2ffaa', 'aeffa6', '8aff80', '54ff49', '13da00',
'11c900', '0dab00', '099200']

# variables for different timers
var type_speed = 0.10

var read_time = 2
var current_character = 0
var current_message = 0

var current_light = 0
var message = ''
var shifu_messages = ['Congratulations, student. You have passed all of the tests and saved the world.',
'Now that I have taught you all that I can, I will send you on your way. I hope that you decide to continue on your programming journey.',
'What will you choose to do now?']

# colors
var green = '009e68'
var black = '000000'

# Called when the node enters the scene tree for the first time.
func _ready():
	# make not visible until amimation is done
	quit_button.visible = false
	menu_button.visible = false
	winner_label.visible = false
	
	# darken bg
	$bg.modulate = '2f2f2f'
	# set labels and formatting
	winner_label.text = 'CONGRATULATIONS'
	winner_label.add_theme_font_override('normal_font', font)
	winner_label.add_theme_font_size_override("normal_font_size", 80)
	winner_label.add_theme_constant_override('outline_size', 15)
	winner_label.add_theme_color_override('font_outline_color', green)
	shifu_message.add_theme_font_override('normal_font', font)
	shifu_message.add_theme_font_size_override('normal_font_size', 30)
	
	menu_button.add_theme_stylebox_override('normal', button)
	menu_button.add_theme_stylebox_override('hover', button)
	menu_button.add_theme_stylebox_override('pressed', button)
	quit_button.add_theme_stylebox_override('normal', button)
	quit_button.add_theme_stylebox_override('hover', button)
	quit_button.add_theme_stylebox_override('pressed', button)
	menu_button.text = 'MAIN MENU'
	menu_button.add_theme_font_override('font', font)
	quit_button.text = 'QUIT'
	quit_button.add_theme_font_override('font', font)
	menu_button.add_theme_constant_override('outline_size', 10)
	quit_button.add_theme_constant_override('outline_size', 10)
	menu_button.add_theme_color_override('font_outline_color', black)
	quit_button.add_theme_color_override('font_outline_color', black)
	
	# set border colors
	border1.color = green
	border2.color = green
	border3.color = green
	border4.color = green
	
	shifu_audio.stream = audio
	shifu_audio.volume_db = 10
	
	# start shifu animation and dialogue
	start_shifu()


func start_shifu():
	shifu_audio.play(0)
	# set timer variables and start timer
	current_character = 0
	current_message = 0
	message = ''
	
	shifu_next_c.set_wait_time(type_speed)
	shifu_next_c.start()


func stop_shifu():
	# start other timer to lighten bg
	start_lightening()


func start_lightening():
	# set variables and start timer
	current_light = 0
	
	lighten.set_wait_time(0.06)
	lighten.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quit_pressed():
	# quit when they want to quit
	get_tree().quit()


func _on_restart_pressed():
	# go to menu if choice is made
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_restart_mouse_entered():
	# change outlines if hovered for both buttons
	menu_button.add_theme_color_override('font_outline_color', green)

func _on_restart_mouse_exited():
	menu_button.add_theme_color_override('font_outline_color', black)


func _on_quit_mouse_entered():
	quit_button.add_theme_color_override('font_outline_color', green)


func _on_quit_mouse_exited():
	quit_button.add_theme_color_override('font_outline_color', black)


func _on_shifu_nextc_timeout():
	# show dialogue character by character
	if current_character < len(shifu_messages[current_message]):
		var next_character = shifu_messages[current_message][current_character]
		message += next_character
		
		shifu_message.text = message
		current_character += 1
	else:
		# start next message
		shifu_next_c.stop()
		shifu_next_m.one_shot = true
		shifu_next_m.set_wait_time(read_time)
		shifu_next_m.start()


func _on_shifu_nextm_timeout():
	# if we are not at the end of the list then continue showing messages, if not then end shifu
	if current_message == (len(shifu_messages) - 1):
		stop_shifu()
	else:
		# continue messages if not done yet
		current_message += 1
		message = ''
		current_character = 0
		shifu_next_c.start()


func _on_lighten_timeout():
	# show different colors on bg and animate shifu to fall asleep
	if current_light < 15:
		$bg.modulate = modulates[current_light]
		if current_light == 7:
			shifu.play('sleep')
			shifu_message.queue_free()
		current_light += 1
	else:
		# show buttons and congratulations banner
		menu_button.visible = true
		quit_button.visible = true
		winner_label.visible = true
