extends Area2D

# signal to be sent to player to track coins picked up
signal coin_inventory_changed

@onready var coin_sound = $coin_audio

var audio = preload("res://fonts-and-music/music/pickupCoin.wav")

func _ready():
    coin_sound.stream = audio

func _on_body_entered(body):
    # send signal to player and make coin dissappear
    if body.is_in_group("player"):
        coin_sound.play(0)
        emit_signal("coin_inventory_changed")
        queue_free()
