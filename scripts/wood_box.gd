extends Area2D

var active = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if $coin != null:
		$coin.visible = active
		
	
	
	
	
	
	
	
		#$c_style_box.visible = active


func _on_body_entered(body):
	if body.is_in_group("player"):
		active = true
		
