extends StaticBody2D

signal player_hit

@onready var area = $area_2d

func _ready():
    area.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
    if body is CharacterBody2D:
        emit_signal("player_hit")
