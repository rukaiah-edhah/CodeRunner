extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(_delta):
	pass

func _on_body_entered(Body):
	if Body.is_in_group("player"):
		save()

func save():
	print("saved")
	var _save_game = FileAccess.open("user://savegame.txt", FileAccess.WRITE_READ)
	pass
