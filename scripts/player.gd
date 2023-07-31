extends CharacterBody2D

# variables for movement and healthbar and starter coins
@export var speed = 300
@export var gravity = 30
@export var jump_force = 700
@onready var healthbar = $health/healthbar
var coins = 0

# variables for colors for the healthbar
var red_health = preload("res://images/red.png")
var yellow_health = preload("res://images/yellow.png")
var green_health = preload("res://images/green.png")


# set variables for beginning health/max health
const FULL_HEALTH = 100
var health = FULL_HEALTH

func _ready():
	# set screen size, health bar, and coin bar
	set_health_bar()
	set_coin_bar()
	
func set_coin_bar():
	# set coin bar to coins
	$coin_inventory/num_coins.text = str(coins)

func set_health_bar():
	# set health bar to full 
	healthbar.value = health

func _physics_process(_delta):
	# set velocity to max out at 1,000
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
			
	if velocity.x == 0 and velocity.y == 1000:
		# (TEMPORARY UNTIL I FIND A BETTER WAY TO HANDLE THIS) -> restart game for user if they go wrong direction
		get_tree().change_scene_to_file("res://scenes/main.tscn")
		
	if Input.is_action_just_pressed("jump") && is_on_floor():
		# allow for jumping
		velocity.y = -jump_force
	
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

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y
		}
	return save_dict
