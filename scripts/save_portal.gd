extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		save_game()


func save_game():
	var save_game = FileAccess.open("res://savegame.json", FileAccess.WRITE_READ)
	
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		#handling exceptions
		if node.scene_file_path.is_empty(): #skiping nodes that non instanced scenes
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue
		
		if !node.has_method("save"): #skiping scenes that do not have a save function
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue
		
		var node_data = node.call("save") #calling the save function with in the node
		
		var json_string = JSON.stringify(node_data,"", true, false) #converting dictionary to JASON
		save_game.store_string(json_string) #save the dictionary as a new line in the save_game file

