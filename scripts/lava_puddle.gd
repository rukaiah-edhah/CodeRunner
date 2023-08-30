extends Node2D

signal Player_Damaged

var lava_sound = preload("res://fonts-and-music/music/lava.mp3")
var damage_timer = Timer.new()

func _ready():
    $AnimationPlayer.play("boil")
    damage_timer.set_wait_time(1.0) 
    damage_timer.set_one_shot(false)  # Sets the timer to repeat
    damage_timer.timeout.connect(_on_damage_timer_timeout)
    add_child(damage_timer)

func _on_lava_area_entered(body):
    if body.is_in_group("player"):
        #emit_signal("Player_Damaged")
        damage_timer.start()
        
func _on_damage_timer_timeout():
    # Code to reduce player's health
    emit_signal("Player_Damaged")
    play_sound(lava_sound)
    $AnimationPlayer.play("smoke")
    get_tree().call_group("global_listeners", "global_on_player_damaged")

func play_sound(audio_stream):
    var audio_stream_player = AudioStreamPlayer.new()
    audio_stream_player.stream = audio_stream
    self.add_child(audio_stream_player)
    audio_stream_player.play()



func _on_area_2d_body_exited(body):
    if body.is_in_group("player"):
        damage_timer.stop()
