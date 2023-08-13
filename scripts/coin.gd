extends Area2D

# signal to be sent to player to track coins picked up
signal coin_inventory_changed

func _on_body_entered(body):
	# send signal to player and make coin dissappear
	if body.is_in_group("player"):
		emit_signal("coin_inventory_changed")
		queue_free()
