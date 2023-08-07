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

# Responsible for the flash effect 
@onready var top_border = $boss_encounter_area/boss_level_window/top_border
@onready var bottom_border = $boss_encounter_area/boss_level_window/bottom_border
@onready var right_border = $boss_encounter_area/boss_level_window/right_border
@onready var left_border = $boss_encounter_area/boss_level_window/left_border

# prioritize these animations over the block area animation
var is_displaying_window = false
var is_dissolving_window = false
var is_transitioning_to_code = false

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
    code_page.take_damage.connect(take_damage)
    code_page.all_correct.connect(_on_code_page_all_correct)
    
    # Initial visibility setup
    quiz_page.visible = true
    code_page.visible = false
    
    # connecting animation signals
    anim_player.animation_finished.connect(_on_animation_player_animation_finished)
    
    
# Signal handlers 
func _on_boss_encounter_area_body_entered(body):
    if body.is_in_group("player"): 
        is_displaying_window = true
        anim_player.play("display_window")
        boss_encounter_area.body_entered.disconnect(_on_boss_encounter_area_body_entered)
        
func on_quiz_finished():
    transition_to_code_page()
    
func _on_code_page_all_correct():
    health_bar.value = 0 #makes sure that the health goes to 0 befor the window dissolves 
    await get_tree().create_timer(1.5).timeout
    anim_sprite.play("death") # Remove/change based on the boss' animations
    is_dissolving_window = true
    anim_player.play("dissolve_window")
    block_area.queue_free()  # Removes the blocking area
    
    emit_signal("all_correct")

func _on_player_hit_block_area():
    if is_dissolving_window or is_displaying_window or is_transitioning_to_code:
       return
    
    flash_border(top_border)
    flash_border(bottom_border)
    flash_border(right_border)
    flash_border(left_border)
    
    anim_player.play("block_area")
    

# Quiz and code page handlers
func player_wrong_answer():
    anim_sprite.play("wrong_answer") # Remove/change based on the boss' animations
    emit_signal("wrong_answer")
    await anim_sprite.animation_finished
    anim_sprite.play("idle") # Remove/change based on the boss' animations
    
func take_damage(amount):
    health -= amount
    health_bar.value = health
    if health > 0:
        anim_sprite.play("right_answer") # Remove/change based on the boss' animations
        await anim_sprite.animation_finished
        anim_sprite.play("idle") # Remove/change based on the boss' animations
    
    
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
    
