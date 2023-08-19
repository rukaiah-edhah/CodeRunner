extends Area2D


@export var linked_path_self : NodePath # Link the path to itself 

func _on_area_entered(area: Area2D):
    var linked_path = get_node(linked_path_self)
    area.get_parent().global_position = linked_path.global_position
