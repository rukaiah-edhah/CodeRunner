extends Area2D

# signal to be sent to player to track coins picked up
signal coin_inventory_changed


func _ready():
	pass

func _process(_delta):
	pass

func _on_body_entered(_body):
	# send signal to player and make coin dissappear
	emit_signal("coin_inventory_changed")
	queue_free()
