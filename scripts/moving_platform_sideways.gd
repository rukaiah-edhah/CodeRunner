extends AnimatableBody2D

@export var distance:Vector2
@export var phase_time:float = 6.0
@export_range(0.0, 1.0) var phase_offset:float
@export var debug:bool = true

var pivot:Vector2
var time:float


# Called when the node enters the scene tree for the first time.
func _ready()->void:
	pivot = global_position
	set_process(debug)  #is process enables

#the path
func get_pos(t:float)->Vector2:
	var x:float = pivot.x + cos(TAU * (t + phase_offset)) * distance.x
	var y:float = pivot.y + sin(TAU * t) * distance.y
	return Vector2(x, y)

#phisics postion change according to time
func _physics_process(delta:float)->void:
	time = fmod(time + delta/phase_time, 1.0)
	global_position = get_pos(time)


func _process(delta)->void:
	queue_redraw()

#visioalize the path begining and end	
func _draw()->void:
	if !debug:
		return
	var resolution:int = 20
	var increments:float = 1.0 / resolution
	for i in resolution:
		var a: = get_pos(increments * 1) - global_position
		var b: = get_pos(increments * (i + 1)) - global_position
		draw_line(a, b, Color.WHITE, -1)

