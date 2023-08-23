extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

## CHECKS IF THE PLAYER ENETERS THE AREA PAUSES THE GAME AND PLAYS ANIMATION TO BRING THE SHOP IN ##
func _on_body_entered(body):
	if body.name == ("player"):
		get_tree().paused = true
		get_node("Shop/Shop_Anim_Player").play("Trans_in")
