extends CharacterBody2D

# variables for movement and healthbar and starter coins
@export var speed = 350
@export var gravity = 30
@export var jump_force = 700
@onready var healthbar = $health/healthbar
@onready var _animation = $AnimatedSprite2D
@onready var coin_inventory = $coin_inventory/num_coins
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
    
    print(velocity) # track velocity 

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
