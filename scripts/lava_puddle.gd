extends Node2D

signal Player_Damaged

func _ready():
    $AnimationPlayer.play("boil")

func _on_lava_area_entered(body):
    if body.is_in_group("player"):
        $AnimationPlayer.play("smoke")
        #emit_signal("Player_Damaged")
        get_tree().call_group("global_listeners", "global_on_player_damaged")



