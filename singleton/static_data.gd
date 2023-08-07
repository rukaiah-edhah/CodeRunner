extends Node

var item_data = []


var data_file_path = "res://learning-material/data.txt"

func _ready():
	item_data = load_json_file(data_file_path)

func load_json_file(file_path: String):
	if FileAccess.file_exists(file_path):
		var data_file = FileAccess.open(file_path,FileAccess.READ) #return data_file
		
		var str_text = data_file.get_as_text()
		item_data.append(str_text)
		#print(item_data)
		return item_data
#		

	
