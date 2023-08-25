extends Area2D

signal coin_inventory_changed

var active = false
var has_played = false

@onready var anim_coin_box = $coin_box
var box_sound = preload("res://fonts-and-music/music/coin_box.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
    pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    for coin_name in ["coin", "coin2", "coin3", "coin4", "coin5", "coin6"]:
        var coin = $coins.get_node_or_null(coin_name)
        if coin:
            coin.visible = active 
    
    
    
    
        #$c_style_box.visible = active


func _on_body_entered(body):
    if body.is_in_group("player") and not has_played:
        play_sound(box_sound, -10.0)
        anim_coin_box.play("coin_box")
        active = true
        has_played = true
        #emit_signal("coin_inventory_changed")
        get_tree().call_group("global_listeners", "global_coin_inventory_changed")


func play_sound(audio_stream, volume_db = 0.0):
    var audio_stream_player = AudioStreamPlayer.new()
    audio_stream_player.stream = audio_stream
    audio_stream_player.volume_db = volume_db
    self.add_child(audio_stream_player)
    audio_stream_player.play()
