extends Sprite2D

@onready var encounter_area = $encounter_area

func _ready():
    encounter_area.body_entered.connect(_on_shifu_encounter_area_body_entered)
    

func _on_shifu_encounter_area_body_entered(body):
    if body.is_in_group("player"):
        pass
        # anim_player.play("display_dialogue") # HERE WE CAN DISPLAY THE DIALOGUE BOX USING ANIMATIONS 
        # encounter_area.body_entered.disconnect(_on_shifu_encounter_area_body_entered) # HERE WE DISCONNECT THE SIGNAL BECAUSE WE DO NOT WANT THE DIALOGUE BOX TO APPEAR EACH TIME THE PLAYER COLLIDES WITH THE ENCOUNTER AREA
        
