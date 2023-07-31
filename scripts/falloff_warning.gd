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

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y
		}
	return save_dict
