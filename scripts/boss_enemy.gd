extends Node2D

signal correct
signal incorrect

@onready var quiz_area = $final_boss_area
@onready var boss = $final_boss_area/boss_animation
@onready var healthbar = $final_boss_area/boss/TextureProgressBar
@onready var boss_quiz = $final_boss_area/boss
@onready var boss_animation = $final_boss_area/boss_animation
@onready var blocking = $boss_area/StaticBody2D
@onready var boss_area = $boss_area

# variables for colors for the healthbar
var red_health = preload("res://images/red.png")
var yellow_health = preload("res://images/yellow.png")
var green_health = preload("res://images/green.png")

var health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
    boss_quiz.wrong_answer.connect(_on_boss_wrong_answer)
    boss_quiz.right_answer.connect(_on_boss_right_answer)
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
    boss_animation.play('attack')
    await boss_animation.animation_finished
    emit_signal('incorrect')


func _on_boss_right_answer():
    # change health to red, send incorrect signal to player, show death animation, and make it so player can continue forward
    # there are two ways to do this: either make it red or make it disappear, I like maybe just making it red
    # i included both though, or I could try to create a timer to make it go down over the span of a few seconds or something
    healthbar.texture_progress = red_health
    emit_signal('correct')
    boss_animation.play('death')
    await boss_animation.animation_finished
    blocking.queue_free()
    # health = 0
    # healthbar_update(health)
