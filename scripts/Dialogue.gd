extends Control

var messages
#	'Python Comments:',
#	'Comments can be used to explain Python code.
#
#Comments can be used to make the code more readable.
#
#Comments can be used to prevent execution when testing code.' ,
#'#This is a comment'
#	]

var typing_speed = .2
var read_time = 2


var current_message = 0
var display = ""
var current_char = 0
var active = false


#____________________________Added by Rukaiah_______________________
@onready var block_area = $block_area
@onready var dialogue_text = $dialogue_box_sprite/panel/dialogue_text
@onready var anim_player = $AnimationPlayer

# prioritize these animations over the block area animation
var is_displaying_window = false
var is_dissolving_window = false
#____________________________________________________________________



func _ready():
    block_area.player_hit.connect(_on_block_area_player_hit)
    anim_player.animation_finished.connect(_on_animation_player_animation_finished)
    
    messages = StaticData.item_data
    print(messages)
    start_dialogue()
    
    dialogue_text.scroll_active = false # Disable manual scrolling
    

func _process(_delta):
    if Input.is_action_just_pressed("ui_accept"):
        #start_dialogue()
        stop_dialogue()

func start_dialogue():
    #anim_player.play("display")
    current_message = 0
    display = ""
    current_char = 0
    $dialogue_box_sprite/panel/Arrow.visible = active


    $next_char.set_wait_time(typing_speed)
    $next_char.start()

func stop_dialogue():
    # get_parent().remove_child(self)
    if (current_message == len(messages) - 1):
        anim_player.play("dissolve")
        queue_free()
        block_area.queue_free()

func _on_next_char_timeout():
    if (current_char < len(messages[current_message])):
        var next_char = messages[current_message][current_char]
        display += next_char

        dialogue_text.text = display
        dialogue_text.scroll_to_line(dialogue_text.get_line_count() - 1) # Automatically scroll to the end
        
        current_char += 1
    else:
        $next_char.stop()
        $next_message.one_shot = true
        $next_message.set_wait_time(read_time)
        $next_message.start()

func _on_next_message_timeout():
    if (current_message == len(messages) - 1):
        $dialogue_box_sprite/panel/Arrow.visible = true
        if Input.is_action_just_pressed("ui_accept"):
            stop_dialogue()
    else: 
        current_message += 1
        display = ""
        current_char = 0
        $next_char.start()

#_____________________________Added by Rukaiah__________________________
func _on_block_area_player_hit():
    if is_dissolving_window or is_displaying_window:
        return

    anim_player.play("shake_animation")
    
func _on_animation_player_animation_finished(anim_name):
    match anim_name:
        "display":
            is_displaying_window = false
        "dissolve":
            is_dissolving_window = false
#________________________________________________________________________
