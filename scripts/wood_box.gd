extends Area2D

var active = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if $coin != null:
		$coin.visible = active
		
	
	
	
		#$c_style_box.visible = active


func _on_body_entered(body):
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
