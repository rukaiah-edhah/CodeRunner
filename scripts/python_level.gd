extends Node2D

const music_path: String = "res://fonts-and-music/music/DavidKBD - Cosmic Pack 05 - Stellar Confrontation-Variation1.ogg"
@onready var player = $'in_game_items/2/player'

func _ready():
    var transition = $Scene_Transition 
    transition.transition()
    await transition.transitioned.connect(_on_transition_complete)
    
    $bg_music.stream = preload(music_path)
    $bg_music.stream.loop = true  # This line sets the audio to loop
    $bg_music.volume_db = -13
    $bg_music.play()

    # Continue with scene initialization logic here...

func _on_transition_complete():
    # Initialization or other logic you want to happen right after the transition is over.
    pass

func change_bgm(new_bgm_path: String):
    $bg_music.stop()
    var new_bgm = load(new_bgm_path)
    $bg_music.stream = new_bgm
    $bg_music.stream.loop = true
    $bg_music.volume_db = -13
    $bg_music.play()
