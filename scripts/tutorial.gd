extends Control


@onready var bg = $bg
@onready var tutorial_txt = $bg/tutorial_txt
@onready var next = $next
@onready var next_m = $next2
@onready var typing_sound = $typing

var typing_sa = preload("res://fonts-and-music/music/ding-126626.mp3")
var font = preload("res://fonts-and-music/fonts/quiz_code_pages_font/LibreBaskerville-Regular.ttf")

var text_speed = 0.05
var read_time = 3
var current_character = 0
var current_message = 0
var label = ''
var messages = [
    "Welcome to Code Runner!",
    "Use the left and right arrow keys to move forwards and backwards. Use your space key to jump.",
    "Running into the floating holograms will deliver your lessons. Those will be necessary for defeating the bosses.",
    "Collect coins from treasure chests, and defeat enemies by jumping on their heads along your way.",
    "Good luck! Your mission begins now!"
]

# Called when the node enters the scene tree for the first time.
func _ready():
    get_parent().can_move = false
    await get_tree().create_timer(1.5).timeout
    tutorial_txt.add_theme_font_override("normal_font", font)
    tutorial_txt.add_theme_color_override('font_outline_color', '000000')
    tutorial_txt.add_theme_constant_override('outline_size', 5)
    start_tutorial()
    
    typing_sound.stream = typing_sa
    typing_sound.volume_db = -5
    
    typing_sound.play(0)


func start_tutorial():
    # set variables to 0 and empty
    current_message = 0
    current_character = 0
    label = ''
    
    # set time for text to appear + start timer
    next.set_wait_time(text_speed)
    next.start()


func stop_tutorial():
    get_parent().can_move = true
    typing_sound.stream.loop = false
    # clear tutorial
    queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func _on_next_timeout():
    # go through each letter in the message and add them one by one
    if current_character < len(messages[current_message]):
        var next_character = messages[current_message][current_character]
        label += next_character
        
        tutorial_txt.text = label
        current_character += 1
    else:
        # move on
        next.stop()
        next_m.one_shot = true
        next_m.set_wait_time(read_time)
        next_m.start()


func _on_next_2_timeout():
    # if we are not at the end of the list then continue showing messages, if not then end tutorial
    if current_message == (len(messages) - 1):
        stop_tutorial()
    else:
        current_message += 1
        label = ''
        current_character = 0
        next.start()
