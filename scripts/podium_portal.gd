extends Area2D


@export var path : NodePath 

var python_portal_sound = preload("res://fonts-and-music/music/boss_level_portal.mp3")

func _on_area_entered(area: Area2D):
    if area.is_in_group("player"):
        play_sound(python_portal_sound, -5.0)
        area.get_parent().disable_movement()
        $AnimationPlayer.play("light_effect")
        await $AnimationPlayer.animation_finished
        area.get_parent().get_node("PlayerAnimation").play("Dissolve")
        await get_tree().create_timer(1.0).timeout
        var linked_path = get_node(path)
        area.get_parent().global_position = linked_path.global_position
        area.get_parent().get_node("PlayerAnimation").play("Appear")
        area.get_parent().enable_movement()

func play_sound(audio_stream, volume_db = 0.0):
    var audio_stream_player = AudioStreamPlayer.new()
    audio_stream_player.stream = audio_stream
    audio_stream_player.volume_db = volume_db
    self.add_child(audio_stream_player)
    audio_stream_player.play()
