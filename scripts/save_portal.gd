extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(Body):
	if Body.is_in_group("player"):
		save()

func save():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
