extends Node2D

@onready var encounter_area = $AnimatedSprite2D/encounter_area
@onready var dialogue_box = $dialogue
@onready var _animated_sprite = $AnimatedSprite2D

var encounter_sound = preload("res://fonts-and-music/music/shifu.mp3")
#var fade_sound = preload("res://fonts-and-music/music/fadein_choir-91038.mp3")
#var data_sound = preload("res://fonts-and-music/music/keyboard-153960.mp3")

#var data_sound_player = AudioStreamPlayer.new() 

func _ready():
	encounter_area.body_entered.connect(_on_shifu_encounter_area_body_entered)
	encounter_area.body_exited.connect(_on_shifu_encounter_area_body_exited)
	#self.add_child(data_sound_player)
	
	dialogue_box.visible = false
func _on_shifu_encounter_area_body_entered(body):
	if body.is_in_group("player"):
		play_sound(encounter_sound, -10.0)
		dialogue_box.visible = true
		dialogue_box.reset_scene()
		_animated_sprite.play("wake_up")
		await _animated_sprite.animation_finished
		_animated_sprite.play("idle")
		#await get_tree().create_timer(0.5).timeout
		#data_sound_player.stream = data_sound  
		#data_sound_player.stream.loop = true  
		#data_sound_player.play()  

	
func _on_shifu_encounter_area_body_exited(body):
	if body.is_in_group("player"):
		#data_sound_player.stop()
		#play_sound(fade_sound)
		await get_tree().create_timer(0.5).timeout
		_animated_sprite.play("back_to_sleep")
		$dialogue/AnimationPlayer.play("dissolve")
		#dialogue_box.visible = false  

func play_sound(audio_stream, volume_db = 0.0):
	var audio_stream_player = AudioStreamPlayer.new()
	audio_stream_player.stream = audio_stream
	audio_stream_player.volume_db = volume_db
	self.add_child(audio_stream_player)
	audio_stream_player.play()

