extends Node2D

var damage_per_second = 10  

func _on_lava_puddle_body_entered(body):
    if body.is_in_group("player"):
        pass
        #body.timer_process(delta)

func _process(delta):
    var bodies = get_overlapping_bodies()
    for body in bodies:
        if body.is_in_group("player"):
