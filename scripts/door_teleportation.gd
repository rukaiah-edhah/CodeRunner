extends Area2D


@export var linked_door_path : NodePath # The property references another door node in the scene, and when a player interacts with it, they will be teleported to the specified location of the other door

func _on_area_entered(area: Area2D):
    var linked_door = get_node(linked_door_path)
    area.get_parent().global_position = linked_door.global_position
