extends Area2D

signal coin_inventory_changed

var active = false
var has_played = false

@onready var anim_coin_box = $coin_box

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
        anim_coin_box.play("coin_box")
        active = true
        has_played = true
        #emit_signal("coin_inventory_changed")
        get_tree().call_group("global_listeners", "global_coin_inventory_changed")

