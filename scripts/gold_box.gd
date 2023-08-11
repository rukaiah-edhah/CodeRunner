extends Area2D

# set variable active to false
var active = false

func _ready():
    pass

func _process(delta):
    # set text in welcome box and set welcome box to variable active (don't let it be seen yet)
    $welcome_box.text = "Welcome to Code Runner!"
    $welcome_box.visible = active


func _on_body_entered(body):
    # show welcome box after player body collides with gold box only
    if body.is_in_group("player"):
        active = true
