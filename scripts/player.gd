extends CharacterBody2D


# variables for movement and healthbar and starter coins
@export var speed = 350
@export var gravity = 30
@export var jump_force = 700
@onready var healthbar = $health/healthbar
@onready var _animation = $AnimatedSprite2D
@onready var coin_inventory = $coin_inventory/Panel/num_coins
@onready var jump_sound = $jump_sound

var coins = 0
var jump_count = 0
var double_jump = 2
var can_move = true

var jump_sa = preload("res://fonts-and-music/music/jump_sound.wav")
var _font = preload("res://fonts-and-music/fonts/quiz_code_pages_font/LibreBaskerville-Regular.ttf")

# variables for colors for the healthbar
var red_health = preload("res://unnecessary-files/red.png")
var yellow_health = preload("res://unnecessary-files/yellow.png")
var green_health = preload("res://unnecessary-files/green.png")

# set variables for beginning health/max health
const FULL_HEALTH = 100
var health = FULL_HEALTH

#_____________________Ignore for now_________________________    
## Controlling Camera position
#@onready var player_camera = $Camera2D
#var camera_offset_right = Vector2(420, -208)
#var camera_offset_left = Vector2(-384, -221)
#___________________________________________________________

func _ready():
	
	#_________________________________________Added by Rukaiah__________________________________________
	assert(BossManager != null) #The purpose of this line is to check that the boss manager is not null. If the game is running smoothly, we can remove it.
	BossManager.set_player(self) # Sets the current player in the BossManager
	#___________________________________________________________________________________________________
	
	# set screen size, health bar, and coin bar
	coin_inventory.add_theme_font_override("font", _font)
	set_health_bar()
	set_coin_bar()

	# set audioplayer to have jump sound and good volume and pitch
	jump_sound.stream = jump_sa
	jump_sound.volume_db = -10
	jump_sound.pitch_scale = 0.70
	
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
		_animation.play("walk")
		_animation.flip_h = false
	elif Input.is_action_pressed("move_right"):
		_animation.flip_h = true
		_animation.play("walk")
	else:
		_animation.play("idle")
	
func _physics_process(_delta):
	if not can_move:
		return
	
	# play jump sound when player jumps
	if Input.is_action_just_pressed("jump"):
		jump_sound.play()
   
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
#_____________________Ignore for now_________________________    
	#update_camera_position(velocity.x)
	
#func update_camera_position(direction_x: float):
	#f direction_x > 0:
		#player_camera.offset = camera_offset_right
	#elif direction_x < 0:
		#player_camera.offset = camera_offset_left
#_______________________________________________________________    

# __________________________ Added by Rukaiah ______________________
func disable_movement():
	can_move = false
	velocity = Vector2(0, 0)   

func enable_movement():
	can_move = true
# ___________________________________________________________________
	
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
	_animation.play("hurt") # NOT WORKING
	print("Trying to play hurt animation") 
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
		_animation.play("shoot") # NOT WORKING 
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
