extends Area2D


## NOT IN USE ##
func _ready():
	pass # Replace with function body.


## NOT IN USE ##
func _process(delta):
	pass

## CHECKS IF THE PLAYER ENETERS THE AREA PAUSES THE GAME AND PLAYS ANIMATION TO BRING THE SHOP IN ##
func _on_body_entered(body):
	if body.name == ("player"):
		get_tree().paused = true
		get_node("Shop/Anim").play("Transin")



