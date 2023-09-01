extends Node2D

signal wrong_answer
signal all_correct

var health = 100 
@onready var final_boss = $boss_encounter_area/animated_sprite_2d
@onready var health_bar = $boss_encounter_area/boss_level_window/health_bar
@onready var anim_sprite = $boss_encounter_area/animated_sprite_2d
@onready var anim_player = $boss_encounter_area/animation_player
@onready var boss_level_window = $boss_encounter_area/boss_level_window
@onready var quiz_page = $boss_encounter_area/boss_level_window/quiz_page
@onready var code_page = $boss_encounter_area/boss_level_window/boss
@onready var block_area = $block_area
@onready var boss_encounter_area = $boss_encounter_area
@onready var growl = $growl
@onready var howl = $howl
@onready var encounter = $encounter
@onready var beat = $beat
@onready var block = $block

# Responsible for the flash effect 
@onready var top_border = $boss_encounter_area/boss_level_window/top_border
@onready var bottom_border = $boss_encounter_area/boss_level_window/bottom_border
@onready var right_border = $boss_encounter_area/boss_level_window/right_border
@onready var left_border = $boss_encounter_area/boss_level_window/left_border

# prioritize these animations over the block area animation
var is_displaying_window = false
var is_dissolving_window = false
var is_transitioning_to_code = false

var growl_audio = preload('res://fonts-and-music/music/growl.mp3')
var howl_audio = preload('res://fonts-and-music/music/monster_howl.mp3')
var ecounter_audio = preload("res://fonts-and-music/music/final_boss_intro_encounter.mp3")
var beat_audio = preload("res://fonts-and-music/music/beat_final_boss.mp3")
var block_area_sound = preload("res://fonts-and-music/music/block_area.mp3")

func _ready():

    BossManager.add_boss(self) # Connects the boss's signals to the player's methods
    
    # Connecting area signals
    boss_encounter_area.body_entered.connect(_on_boss_encounter_area_body_entered)
    block_area.player_hit.connect(_on_player_hit_block_area)
    
    # Connecting quiz signals
    quiz_page.wrong_answer.connect(player_wrong_answer)
    quiz_page.take_damage.connect(take_damage)
    quiz_page.quiz_finished.connect(on_quiz_finished)
    
    # Connecting code page signals
    code_page.wrong_answer.connect(player_wrong_answer)
    code_page.right_answer.connect(_on_code_page_all_correct)
    
    # Initial visibility setup
    quiz_page.visible = true
    code_page.visible = false
    
    # connecting animation signals
    anim_player.animation_finished.connect(_on_animation_player_animation_finished)
    
    # setting audio and changing effects/volume
    howl.stream = howl_audio
    howl.pitch_scale = -0.50
    
    growl.stream = growl_audio
    growl.volume_db = -10
    
    encounter.stream = ecounter_audio
    encounter.volume_db = 1 
    
    beat.stream = beat_audio
    beat.volume_db = 1 
    
    block.stream = block_area_sound
    block.volume_db = 5
    
    # setting healthbar to 100 initially
    health_bar.value = health



# Signal handlers 
func _on_boss_encounter_area_body_entered(body):
    if body.is_in_group("player"):
        encounter.play(0) 
        is_displaying_window = true
        anim_player.play("display_window")
        boss_encounter_area.body_entered.disconnect(_on_boss_encounter_area_body_entered)
        

func on_quiz_finished():
    transition_to_code_page()

func _on_code_page_all_correct():
    health_bar.value = 0 #makes sure that the health goes to 0 befor the window dissolves await get_tree().create_timer(1.5).timeout

    # turn off growl if it is still happening
    if growl.playing == true:
        growl.playing = false
    howl.play(0)
    anim_sprite.play("death") # Remove/change based on the boss' animations
    await anim_sprite.animation_finished

    # turn off howl after animation is done
    howl.playing = false
    is_dissolving_window = true
    
    anim_player.play("dissolve_window")
    final_boss.queue_free()
    block_area.queue_free()  # Removes the blocking area

    beat.play(0)
    emit_signal("all_correct")

func _on_player_hit_block_area():
    if is_dissolving_window or is_displaying_window or is_transitioning_to_code:
        return
    block.play(0)

    flash_border(top_border)
    flash_border(bottom_border)
    flash_border(right_border)
    flash_border(left_border)

    anim_player.play("block_area")


# Quiz and code page handlers
func player_wrong_answer():
    # turn off howl if it is still happening
    if howl.playing == true:
        howl.playing = false

    growl.play(0)
    anim_sprite.play("wrong_answer") # Remove/change based on the boss' animations
    emit_signal("wrong_answer")
    await anim_sprite.animation_finished

    # turn off growl after animation is done
    growl.playing = false
    anim_sprite.play("idle") # Remove/change based on the boss' animations

func take_damage(amount):
    # turn off growl if it is still happening
    if growl.playing == true:
        howl.playing = false

    howl.play(3)
    health -= amount
    health_bar.value = health
    if health > 0:
        anim_sprite.play("attacked") # new animation for when boss is attacked
        await anim_sprite.animation_finished

        # turn off howl after animation is done
        howl.playing = false
        anim_sprite.play("a_idle") # second idle animation to match the end of the attack animation


# Utility functions
func transition_to_code_page():
    code_page.visible = true
    is_transitioning_to_code = true 
    anim_player.play("quiz_to_code")

func flash_border(border):
    border.color = Color(1, 1, 1, 1)
    await get_tree().create_timer(0.3).timeout 
    border.color = Color(0, 0, 0, 1)  


func _on_animation_player_animation_finished(anim_name):
    match anim_name:
        "display_window":
            is_displaying_window = false
        "dissolve_window":
            is_dissolving_window = false
        "quiz_to_code":
            is_transitioning_to_code = false
