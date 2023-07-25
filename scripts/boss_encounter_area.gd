extends Area2D

@onready var anim_player = $animation_player

func _ready():
    self.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
    if body is CharacterBody2D: # WHAT IS THE TYPE OF THE MINI ENEMIES?
        anim_player.play("display_window")
        self.body_entered.disconnect(_on_body_entered)
