extends StaticBody2D

signal player_hit

## THIS SCRIPT IS ATTACHED TO BOTH SHIFU AND THE BOSS LEVEL SCENES. WHEN MAKING ANY CHNAGES MAKE SURE TO DO IT FOR BOTH ##

@onready var area = $area_2d

func _ready():
    area.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
    if body.is_in_group("player"):
        emit_signal("player_hit")
