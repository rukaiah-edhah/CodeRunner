extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_close_button_pressed():
	get_node("Inv_Anim").play("Transition_Out")


func _input(event):
	if event.is_action("Open_Inventory"):
		if self.offset.y == 300:
			get_node("AnimationPlayer").play("Transition_In")
		elif self.offset.y == 300:
			get_node("AnimationPlayer").play("Transition_In")
		elif self.offset.y == 0:
			get_node("AnimationPlayer").play("Transition_Out")
		get_node("Inventory_Container").fill_inventory_slots()
		
