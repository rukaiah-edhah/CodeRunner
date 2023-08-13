extends CanvasLayer

signal transitioned

func transition():
	$AnimationPlayer.play("Fade_To_Black")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Fade_To_Black":
		emit_signal("transitioned")
		$AnimationPlayer.play("Fade_To_Normal")
	if anim_name == "Fade_To_Normal":
		print("Finished Fadin")
