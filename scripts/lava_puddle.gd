extends Node2D

signal Player_Damaged

var lava_sound = preload("res://fonts-and-music/music/lava.mp3")

func _ready():
	$AnimationPlayer.play("boil")

func _on_lava_area_entered(body):
	if body.is_in_group("player"):
		play_sound(lava_sound)
		$AnimationPlayer.play("smoke")
		#emit_signal("Player_Damaged")
		get_tree().call_group("global_listeners", "global_on_player_damaged")

func play_sound(audio_stream):
	var audio_stream_player = AudioStreamPlayer.new()
	audio_stream_player.stream = audio_stream
	self.add_child(audio_stream_player)
	audio_stream_player.play()

