extends Sprite2D

@onready var player = $"../../../in_game_items/3/player"
@onready var background = $"."

func _process(delta):
    background.position = player.global_position
