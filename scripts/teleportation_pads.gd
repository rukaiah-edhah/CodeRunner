extends Area2D


@export var path : NodePath 

func _on_area_entered(area: Area2D):
    $AnimationPlayer.play("dissolve")
    await $AnimationPlayer.animation_finished
    var linked_path = get_node(path)
    area.get_parent().global_position = linked_path.global_position
