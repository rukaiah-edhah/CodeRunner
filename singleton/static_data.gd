extends Node

var item_data = []
var files_arr = []

var data_file_path = "res://Data/data.txt"

func _ready():
	item_data = load_json_file(data_file_path)

func load_json_file(file_path: String):
	if FileAccess.file_exists(file_path):
		var data_file = FileAccess.open(file_path,FileAccess.READ)
		#return data_file
		#var parsed_result = Array#JSON.parse_string(data_file.get_as_text())
		#if parsed_result is Dictionary:
		var x = data_file.get_as_text()
		files_arr.append(x)
		return files_arr
#		else:
#			print("Error loading the file")
#
#	else:
#		print("file doesn't exist")
		

	
