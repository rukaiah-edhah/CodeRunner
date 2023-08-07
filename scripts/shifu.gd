extends Sprite2D

@onready var encounter_area = $encounter_area
@onready var block_area = $block_area

func _ready():
    encounter_area.body_entered.connect(_on_shifu_encounter_area_body_entered)
    block_area.player_hit.connect(_on_player_hit_block_area)
    

func _on_shifu_encounter_area_body_entered(body):
    if body.is_in_group("player"):
        pass
        # anim_player.play("display_dialogue") # HERE WE CAN DISPLAY THE DIALOGUE BOX USING ANIMATIONS 
        # encounter_area.body_entered.disconnect(_on_shifu_encounter_area_body_entered) # HERE WE DISCONNECT THE SIGNAL BECAUSE WE DO NOT WANT THE DIALOGUE BOX TO APPEAR EACH TIME THE PLAYER COLLIDES WITH THE ENCOUNTER AREA
        
func _on_player_hit_block_area():
    pass 
    # anim_player.play("block_area") # HERE WE CAN DO A SHAKE ANIMATION 
