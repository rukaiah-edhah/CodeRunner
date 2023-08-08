extends Control

var messages = [
    'Python Comments:',
    'Comments can be used to explain Python code.

Comments can be used to make the code more readable.

Comments can be used to prevent execution when testing code.' ,
'#This is a comment'
    ]

var typing_speed = .2
var read_time = 2


var current_message = 0
var display = ""
var current_char = 0
var active = false


func _ready():
    start_dialogue()
    

func _process(delta):
    if Input.is_action_just_pressed("ui_accept"):
        #start_dialogue()
        stop_dialogue()
    
func start_dialogue():
    current_message = 0
    display = ""
    current_char = 0
    $Arrow.visible = active
    
    
    $next_char.set_wait_time(typing_speed)
    $next_char.start()

func stop_dialogue():
    # get_parent().remove_child(self)
    if (current_message == len(messages) - 1):
        #$Arrow.visible = true
        queue_free()

func _on_next_char_timeout():
    if (current_char < len(messages[current_message])):
        var next_char = messages[current_message][current_char]
        display += next_char
        
        $RichTextLabel.text = display
        current_char += 1
    else:
        $next_char.stop()
        $next_message.one_shot = true
        $next_message.set_wait_time(read_time)
        $next_message.start()

func _on_next_message_timeout():
    if (current_message == len(messages) - 1):
        $Arrow.visible = true
        if Input.is_action_just_pressed("ui_accept"):
            stop_dialogue()
    else: 
        current_message += 1
        display = ""
        current_char = 0
        $next_char.start()


