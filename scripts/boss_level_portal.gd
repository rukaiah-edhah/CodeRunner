extends Area2D


@export var path : NodePath 

var portal_sound = preload("res://fonts-and-music/music/boss_level_portal.mp3")

func _on_area_entered(area: Area2D):
    if area.is_in_group("player"):
        play_sound(portal_sound)
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

func play_sound(audio_stream):
    var audio_stream_player = AudioStreamPlayer.new()
    audio_stream_player.stream = audio_stream
    self.add_child(audio_stream_player)
    audio_stream_player.play()
