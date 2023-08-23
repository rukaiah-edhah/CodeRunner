extends Node2D

signal correct
signal incorrect

@onready var quiz_area = $final_boss_area
@onready var boss = $final_boss_area/boss_animation
@onready var healthbar = $final_boss_area/boss_level_window/TextureProgressBar
@onready var boss_quiz = $final_boss_area/boss_level_window/boss
@onready var boss_quiz2 = $final_boss_area/boss_level_window/boss2
@onready var boss_quiz3 = $final_boss_area/boss_level_window/boss3
@onready var boss_animation = $final_boss_area/boss_animation
@onready var blocking = $boss_area/StaticBody2D
@onready var boss_area = $boss_area
@onready var howl = $howl
@onready var growl = $growl

# variables for colors for the healthbar
var red_health = preload("res://unnecessary-files/red.png")
var yellow_health = preload("res://unnecessary-files/yellow.png")
var green_health = preload("res://unnecessary-files/green.png")

var howl_audio = preload('res://fonts-and-music/music/monster_howl.mp3')
var growl_audio = preload('res://fonts-and-music/music/growl.mp3')

var health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	howl.stream = howl_audio
	growl.stream = growl_audio
	howl.pitch_scale = -0.80
	growl.volume_db = -15
	boss_quiz.wrong_answer.connect(_on_boss_wrong_answer)
	boss_quiz.right_answer.connect(_on_boss_right_answer)
	boss_quiz2.wrong_answer.connect(_on_boss_wrong_answer)
	boss_quiz2.right_answer.connect(_on_boss2_right_answer)
	boss_quiz3.wrong_answer.connect(_on_boss_wrong_answer)
	boss_quiz3.right_answer.connect(_on_boss3_right_answer)
	set_healthbar()

func set_healthbar():
	# set healthbar
	healthbar.value = health

func healthbar_update(value):
	# ignore, this will come in handy if i add a timer instead
	# if we decide no timer then i can take this out
	healthbar.texture_progress = green_health
	if value < healthbar.max_value * 0.75:
		healthbar.texture_progress = yellow_health
	if value < healthbar.max_value * 0.50:
		healthbar.texture_progress = red_health
	set_healthbar()

func _process(_delta):
	pass

func _on_boss_wrong_answer():
	# play attack animation if player answers wrong and send out signal for player
	growl.play(0)
	boss_animation.play('attack')
	await boss_animation.animation_finished
	emit_signal('incorrect')

func _on_boss_right_answer():
	health -= 30
	healthbar_update(health)
	howl.play(4)
	emit_signal('correct')
	boss_animation.play('attacked')
	await boss_animation.animation_finished
	boss_animation.play('idle')
	boss_quiz.visible = false
	boss_quiz2.visible = true

func _on_boss2_right_answer():
	health -= 30
	healthbar_update(health)
	howl.play(4)
	emit_signal('correct')
	boss_animation.play('attacked')
	await boss_animation.animation_finished
	boss_animation.play('idle')
	boss_quiz2.visible = false
	boss_quiz3.visible = true

func _on_boss3_right_answer():
	# change health to 0, send incorrect signal to player, show death animation, and make it so player can continue forward
	health = 0
	healthbar_update(health)
	howl.play(0)
	emit_signal('correct')
	boss_animation.play('death')
	await boss_animation.animation_finished
	blocking.queue_free()
