extends Area2D


@export var path : NodePath 

var portal_sound = preload("res://fonts-and-music/music/spaceship_teleportation.mp3")

func _on_area_entered(area: Area2D):
    if area.is_in_group("player"):
        play_sound(portal_sound, -10.0)

        area.get_parent().disable_movement()
        area.get_parent().get_node("PlayerAnimation").play("Dissolve")
        
        var pet_node = get_node("../../../3/pet")
        pet_node.get_node("PetAnimation").play("Dissolve")
            
        await get_tree().create_timer(0.5).timeout
        
        var linked_path = get_node(path)
        area.get_parent().global_position = linked_path.global_position
        
        area.get_parent().get_node("PlayerAnimation").play("Appear")
        pet_node.get_node("PetAnimation").play("Appear")
        
        area.get_parent().enable_movement()
        
        
        var intro_level = get_node("../../../..")  
        intro_level.change_bgm("res://fonts-and-music/music/DavidKBD - Cosmic Pack 01 - Cosmic Journey-variation3.ogg")

func play_sound(audio_stream, volume_db = 0.0):
    var audio_stream_player = AudioStreamPlayer.new()
    audio_stream_player.stream = audio_stream
    audio_stream_player.volume_db = volume_db
    self.add_child(audio_stream_player)
    audio_stream_player.play()
