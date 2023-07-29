extends Node2D

signal wrong_answer
signal all_correct

var health = 100 
@onready var health_bar = $boss_encounter_area/boss_level_window/health_bar
@onready var anim_sprite = $boss_encounter_area/animated_sprite_2d
@onready var anim_player = $boss_encounter_area/animation_player
@onready var boss_level_window = $boss_encounter_area/boss_level_window
@onready var quiz_page = $boss_encounter_area/boss_level_window/quiz_page
@onready var code_page = $boss_encounter_area/boss_level_window/code_page
@onready var block_area = $block_area
@onready var boss_encounter_area = $boss_encounter_area


func _ready():
    BossManager.add_boss(self) # Connects the boss's signals to the player's methods
    boss_encounter_area.body_entered.connect(_on_boss_encounter_area_body_entered)
    
    # Connecting quiz signals
    quiz_page.wrong_answer.connect(player_wrong_answer)
    quiz_page.take_damage.connect(take_damage)
    quiz_page.quiz_finished.connect(on_quiz_finished)
    
    # Connecting code page signals
    code_page.wrong_answer.connect(player_wrong_answer)
    code_page.take_damage.connect(take_damage)
    code_page.all_correct.connect(_on_code_page_all_correct)
    
    # Initial visibility setup
    quiz_page.visible = true
    code_page.visible = false
    
    
# Signal handlers  
func _on_boss_encounter_area_body_entered(body):
    if body is CharacterBody2D: 
        anim_player.play("display_window")
        boss_encounter_area.body_entered.disconnect(_on_boss_encounter_area_body_entered)
        
func on_quiz_finished():
    transition_to_code_page()
    
func _on_code_page_all_correct():
    health_bar.value = 0 #makes sure that the health goes to 0 befor the window dissolves 
    await get_tree().create_timer(1.5).timeout
    anim_sprite.play("death")
    anim_player.play("dissolve_window")
    block_area.queue_free()  # Removes the blocking area
    
    emit_signal("all_correct")
    

# Quiz and code page handlers
func player_wrong_answer():
    anim_sprite.play("wrong_answer")
    emit_signal("wrong_answer")
    await anim_sprite.animation_finished
    anim_sprite.play("idle")
    
func take_damage(amount):
    health -= amount
    health_bar.value = health
    if health <= 0:
        anim_sprite.play("death")
    else:
        anim_sprite.play("right_answer")
        await anim_sprite.animation_finished
        anim_sprite.play("idle")
    
    
# Utility functions
func transition_to_code_page():
    code_page.visible = true
    anim_player.play("quiz_to_code")
