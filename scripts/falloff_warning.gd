extends Area2D

# set active variable to false -- don't let things show too early 
var active = false

func _ready():
	pass 

func _process(delta):
	# set right arrow to variable active (don't let it show yet)
	$right_arrow.visible = active

func _on_body_entered(body):
	# set variable active to true (only when the player is colliding with area) to show user arrow
	if body.is_in_group("player"):
		active = true
