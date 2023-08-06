extends CharacterBody2D


# variables for movement and healthbar and starter coins
@export var speed = 350
@export var gravity = 30
@export var jump_force = 700
@onready var healthbar = $health/healthbar
@onready var _animation = $AnimatedSprite2D
@onready var coin_inventory = $coin_inventory/Panel/num_coins
var coins = 0
var jump_count = 0
var double_jump = 2

var _font = preload("res://fonts/quiz_code_pages_font/LibreBaskerville-Regular.ttf")

# variables for colors for the healthbar
var red_health = preload("res://images/red.png")
var yellow_health = preload("res://images/yellow.png")
var green_health = preload("res://images/green.png")

# set variables for beginning health/max health
const FULL_HEALTH = 100
var health = FULL_HEALTH

func _ready():
    
    #_________________________________________Added by Rukaiah__________________________________________
    assert(BossManager != null) #The purpose of this line is to check that the boss manager is not null. If the game is running smoothly, we can remove it.
    BossManager.set_player(self) # Sets the current player in the BossManager
    #___________________________________________________________________________________________________
    
    # set screen size, health bar, and coin bar
    coin_inventory.add_theme_font_override("font", _font)
    set_health_bar()
    set_coin_bar()
    
func set_coin_bar():
    # set coin bar to coins
    coin_inventory.text = str(coins)

func set_health_bar():
    # set health bar to full 
    healthbar.value = health

func _process(_delta):
    # setting player animation to movement
    if Input.is_action_pressed("jump"):
        _animation.play("jump")
    elif Input.is_action_pressed("move_left"):
        _animation.play("walk_left")
    elif Input.is_action_pressed("move_right"):
        _animation.play("walk_right")
    else:
        _animation.play("idle")
    
func _physics_process(_delta):
    # set velocity to max out at 1,000
    if !is_on_floor():
        velocity.y += gravity
        if velocity.y > 1000:
            velocity.y = 1000
        
    if Input.is_action_just_pressed("jump") && is_on_floor():
        # allow for jumping, set jump_count back to 0 when on the floor and add 1 to jump_count after jump
        jump_count = 0
        velocity.y = -jump_force
        jump_count += 1
        
    if Input.is_action_just_pressed("jump") && not is_on_floor():
        # allow for double jump.. no more
        if jump_count < double_jump:
            velocity.y = -jump_force
            jump_count += 1
        
    # allow for movement left and right through input
    var horizontal_direction = Input.get_axis("move_left", "move_right")
    
    velocity.x = speed * horizontal_direction
    
    move_and_slide()
    

func _damage():
    # let player take damage and set health bar accordingly
    health -= 20
    if health <= 0:
        health = FULL_HEALTH
    update_healthbar(health)

func update_healthbar(value):
    # update colors of healthbar as user loses health
    healthbar.texture_progress = green_health
    if value < healthbar.max_value * 0.75:
        healthbar.texture_progress = yellow_health
    if value < healthbar.max_value * 0.45:
        healthbar.texture_progress = red_health
    set_health_bar()


func _on_coin_coin_inventory_changed():
    # add three coins to the coin bar when user picks up a coin
    coins += 3
    set_coin_bar()
    
#_________________________________________Added by Rukaiah__________________________________________
func _on_mini_boss_level_wrong_answer(): # Connect the signal wrong_answer to this function in main 
    # The reduction of health and coins per wrong answer can be adjusted below
    health -= 3
    coins -= 3  
    if health <= 0:
        health = 0
        _damage() # Replace it with the function that handles the death of the player
    if coins <= 0: # Further logic can be added here once the number of coins reaches zero e.q sound effects 
        coins = 0 
    update_healthbar(health)
    set_coin_bar()


func _on_mini_boss_level_all_correct(): # Connect the signal all_correct to this function in maih
    if health < 100: 
        health = 100  # I am restoring the player's health to full if all answers are correct, but we can only add specific numbers if we wish
    coins += 100
    update_healthbar(health)  # make sure to update the health bar
    set_coin_bar()  # make sure to update the coins
#___________________________________________________________________________________________________

func save():
    var save_dict = {
        "filename" : get_scene_file_path(),
        "parent" : get_parent().get_path(),
        "pos_x" : position.x, # Vector2 is not supported by JSON
        "pos_y" : position.y
        }
    return save_dict
