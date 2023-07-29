extends Node

var FILE_PATH = "res://savedgame.json"

func save():
	var data = {
		"name": "Zippy"
		#"health": %player.to_dictionary()
		#"player" : %Player.to_dictionary(),
		#"level" : %Level.to_dictionary(),
	}
	var file = FileAccess.new()
	if file.open(FILE_PATH, FileAccess.WRITE) == OK:
		file.store_var(data)
		file.close()
	
