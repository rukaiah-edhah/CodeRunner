extends Node2D

@onready var encounter_area = $AnimatedSprite2D/encounter_area
@onready var dialogue_box = $dialogue_box
@onready var _animated_sprite = $AnimatedSprite2D

func _ready():
	encounter_area.body_entered.connect(_on_shifu_encounter_area_body_entered)
	encounter_area.body_exited.connect(_on_shifu_encounter_area_body_exited)

	dialogue_box.visible = false
	
func _on_shifu_encounter_area_body_entered(body):
	if body.is_in_group("player"):
		_animated_sprite.play_backwards("wakeup")
		dialogue_box.visible = true
	
func _on_shifu_encounter_area_body_exited(body):
	if body.is_in_group("player"):
		_animated_sprite.play("wakeup")
		dialogue_box.visible = false
