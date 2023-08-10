extends Node2D

@onready var encounter_area = $Sprite2D/encounter_area
@onready var dialogue_box = $dialogue_box
@onready var animation = $Sprite2D

func _ready():
    encounter_area.body_entered.connect(_on_shifu_encounter_area_body_entered)
    dialogue_box.visible = false

func _on_shifu_encounter_area_body_entered(body):
    if body.is_in_group("player"):
        # CHANGE SHIFU'S POSITION: animation.play("name_of_the_animation")
        # Add anything else you want before the dialougue box appear here 
        dialogue_box.visible = true
        
        
# Note: After the dialogue box scene has ended, try to make it appear again if the player collided with Shifu again
