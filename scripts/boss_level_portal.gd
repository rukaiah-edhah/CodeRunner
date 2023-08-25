extends Area2D


@export var path : NodePath 

var portal_sound = preload("res://fonts-and-music/music/boss_level_portal.mp3")

func _on_area_entered(area: Area2D):
    if area.is_in_group("player"):
        play_sound(portal_sound)
        area.get_parent().disable_movement()
        $AnimationPlayer.play("dissolve")
        await $AnimationPlayer.animation_finished
        var linked_path = get_node(path)
        area.get_parent().global_position = linked_path.global_position

func play_sound(audio_stream):
    var audio_stream_player = AudioStreamPlayer.new()
    audio_stream_player.stream = audio_stream
    self.add_child(audio_stream_player)
    audio_stream_player.play()
