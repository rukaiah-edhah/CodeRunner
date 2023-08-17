extends Node2D

const music_path: String = "res://fonts-and-music/music/DavidKBD - Cosmic Pack 01 - Cosmic Journey-variation2.ogg"
# Called when the node enters the scene tree for the first time.
func _ready():
    $bg_music.stream = preload(music_path)
    $bg_music.volume_db = -15
    $bg_music.play()
    


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

