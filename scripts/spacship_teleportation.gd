extends Area2D

var player_in_range = false

func _ready():
    $timer.timeout.connect(_on_timer_timeout)
    
func _on_area_entered(area: Area2D):
    if area.is_in_group("player"):
        player_in_range = true
        $anim_spacship.play("light_effect")
        $timer.start()
        area.get_parent().disable_movement() # We may need to use the function named enable_movement() to let the player move again in the Python level

func _on_timer_timeout():
    if player_in_range:
        _change_scene()
 
func _change_scene():
    # Joel, you can fade in/out or do any animation here for smoother transitions between the scenes
    
    
    var new_scene = get_tree().change_scene_to_file("res://scenes/python_envir.tscn")

    
