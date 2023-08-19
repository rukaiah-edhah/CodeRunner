extends Control

var messages = [
    "Ah, but the lower-level languages, akin to the ancient binary tongue, grant us mastery over the machine's very heart. They bestow control, efficiency, and proximity to the sacred hardware. In the crucible of performance-critical tasks, they shine like stars, demanding understanding of the computer's architecture. Witness the power of C and Assembly in this sacred domain."
    ]

var typing_speed = .1
var read_time = 2


var current_message = 0
var display = ""
var current_char = 0
var active = false
var block_area_active = true




#____________________________Added by Rukaiah_______________________
@onready var block_area = $block_area
@onready var dialogue_text = $dialogue_box_sprite/panel/dialogue_text
@onready var anim_player = $AnimationPlayer
@onready var enter_button = $dialogue_box_sprite/panel/VBoxContainer/Button

var current_line_visible = 0
var dialogue_complete = false

#____________________________________________________________________



func _ready():
    anim_player.play("display")
    
    #messages = StaticData.item_data
    #print(messages)
    start_dialogue()
    
    enter_button.visible = false 
    dialogue_text.scroll_active = false # Disable manual scrolling
        
func _process(_delta):
    if dialogue_text.scroll_active:
        if Input.is_action_pressed("scroll_up"):
            current_line_visible = max(0, current_line_visible - 1)
            dialogue_text.scroll_to_line(current_line_visible)
        if Input.is_action_pressed("scroll_down"):
            current_line_visible = min(dialogue_text.get_line_count() - 1, current_line_visible + 1)
            dialogue_text.scroll_to_line(current_line_visible)
        if Input.is_action_just_pressed("ui_accept"):
        #start_dialogue()
            stop_dialogue()

func start_dialogue():
    current_message = 0
    display = ""
    current_char = 0
    $dialogue_box_sprite/panel/Arrow.visible = false


    $next_char.set_wait_time(typing_speed)
    $next_char.start()

func stop_dialogue():
    # get_parent().remove_child(self)
    anim_player.play("dissolve")

func _on_next_char_timeout():
    if (current_char < len(messages[current_message])):
        var next_char = messages[current_message][current_char]
        display += next_char

        dialogue_text.text = display
        current_line_visible = dialogue_text.get_line_count() - 1
        dialogue_text.scroll_to_line(dialogue_text.get_line_count() - 1) # Automatically scroll to the end
        
        current_char += 1
    else:
        $next_char.stop()
        $next_message.one_shot = true
        $next_message.set_wait_time(read_time)
        $next_message.start()

func _on_next_message_timeout():
    if (current_message == len(messages) - 1):
        enter_button.visible = true
        $dialogue_box_sprite/panel/Arrow.visible = false
        dialogue_text.scroll_active = true # Enable manual scrolling when dialogue is done
        if Input.is_action_pressed("scroll_up"):
            current_line_visible = max(0, current_line_visible - 1)
            dialogue_text.scroll_to_line(current_line_visible)
        if Input.is_action_pressed("scroll_down"):
            current_line_visible = min(dialogue_text.get_line_count() - 1, current_line_visible + 1)
            dialogue_text.scroll_to_line(current_line_visible)
        if Input.is_action_just_pressed("ui_accept"):
            stop_dialogue()
    else: 
        current_message += 1
        display = ""
        current_char = 0
        $next_char.start()

#_____________________________Added by Rukaiah__________________________
func _on_button_pressed():
    if current_message == len(messages) - 1:
        stop_dialogue()
        if block_area_active:  # remove block area only when it is active
            block_area.queue_free()
            block_area_active = false
 

func reset_scene():
    # Reset animation
    anim_player.stop()
    anim_player.seek(0)
    anim_player.play("display")
    
    # Reset text and associated variables
    current_message = 0
    display = ""
    current_char = 0
    dialogue_text.text = ""

    
    # Reset other states
    enter_button.visible = false
    dialogue_text.scroll_active = false
    $dialogue_box_sprite/panel/Arrow.visible = false
    var block_area_active = true
    
    start_dialogue()
#________________________________________________________________________
