extends Area2D

# signal to be sent to player to track coins picked up
signal coin_inventory_changed

func _on_body_entered(body):
	# send signal to player and make coin dissappear
	if body.is_in_group("player"):
		emit_signal("coin_inventory_changed")
		queue_free()

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y
		}
	return save_dict
