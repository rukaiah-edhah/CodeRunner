extends CharacterBody2D

# variables for movement and healthbar and starter coins
@export var speed = 350
@export var gravity = 30
@export var jump_force = 700
@onready var healthbar = $RemoteTransform2D/Camera2D/health/healthbar
@onready var _animation = $AnimatedSprite2D
@onready var coin_panel = $RemoteTransform2D/Camera2D/coin_inventory/Panel
@onready var coin_inventory = $RemoteTransform2D/Camera2D/coin_inventory/Panel/num_coins
@onready var jump_sound = $jump_sound
@onready var shoot_sound = $shoot_sound

var coins = 0
var jump_count = 0
var double_jump = 2
var can_move = true

var jump_sa = preload("res://fonts-and-music/music/jump_sound.wav")
var shoot_sa = preload("res://fonts-and-music/music/laser-gun.mp3")

var _font = preload("res://fonts-and-music/fonts/quiz_code_pages_font/LibreBaskerville-Regular.ttf")

# variables for colors for the healthbar
var red_health = preload("res://unnecessary-files/red.png")
var yellow_health = preload("res://unnecessary-files/yellow.png")
var green_health = preload("res://unnecessary-files/green.png")

# set variables for beginning health/max health
const FULL_HEALTH = 100
var health = FULL_HEALTH

#_____________________Added bt Rukaiah_________________________   
var is_special_animation_playing = false
 
# Variabels for controlling the camera's position based in the player's diraction
@onready var player_camera = $RemoteTransform2D/Camera2D
# Camera 
const CAMERA_OFFSET_RIGHT = Vector2(420, -208)
const CAMERA_OFFSET_LEFT = Vector2(-384, -221)

# UI elements 
const HEALTHBAR_POSITION_RIGHT = Vector2(410, -215)
const HEALTHBAR_POSITION_LEFT = Vector2(-394, -228)
const COIN_PANEL_POSITION_RIGHT = Vector2(410, -215)
const COIN_PANEL_POSITION_LEFT = Vector2(-394, -228)
#___________________________________________________________

func _ready():
	
	#_________________________________________Added by Rukaiah__________________________________________
	assert(BossManager != null) #The purpose of this line is to check that the boss manager is not null. If the game is running smoothly, we can remove it.
	BossManager.set_player(self) # Sets the current player in the BossManager
	
	player_camera.offset = CAMERA_OFFSET_RIGHT
	healthbar.position = HEALTHBAR_POSITION_RIGHT 
	coin_panel.position = COIN_PANEL_POSITION_RIGHT
	#___________________________________________________________________________________________________
	
	#_____________________connecting signals_________________
	#var obstacles = get_tree().get_nodes_in_group("obstacles")
	#for obstacle in obstacles:
		#obstacle.Player_Damaged.connect(global_on_player_damaged)
		
	#var coins = get_tree().get_nodes_in_group("coins")
	#for coin in coins:
		#coin.coin_inventory_changed.connect(_on_coin_coin_inventory_changed)
		
	add_to_group("global_listeners")
	#_____________________________________________________________________
	
	
	# set screen size, health bar, and coin bar
	coin_inventory.add_theme_font_override("font", _font)
	set_health_bar()
	set_coin_bar()

	# set audioplayer to have jump sound and good volume and pitch
	jump_sound.stream = jump_sa
	jump_sound.volume_db = -10
	jump_sound.pitch_scale = 0.70
	
	shoot_sound.stream = shoot_sa
	shoot_sound.volume_db = -10
	
func set_coin_bar():
	# set coin bar to coins
	coin_inventory.text = str(coins)

func set_health_bar():
	# set health bar to full 
	healthbar.value = health

func _process(_delta): 
	pass
	
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
	
	if is_special_animation_playing:
		return
	
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
	
	move_and_slide()
#_____________________Added by Rukaiah_________________________    
	update_camera_position(velocity.x)
	
func update_camera_position(direction_x: float):
	if direction_x > 0:
		player_camera.offset = CAMERA_OFFSET_RIGHT
		healthbar.position = HEALTHBAR_POSITION_RIGHT 
		coin_panel.position = COIN_PANEL_POSITION_RIGHT
	elif direction_x < 0:
		player_camera.offset = CAMERA_OFFSET_LEFT
		healthbar.position = HEALTHBAR_POSITION_LEFT 
		coin_panel.position = COIN_PANEL_POSITION_LEFT 
#_______________________________________________________________    

# __________________________ Added by Rukaiah ______________________
func disable_movement():
	can_move = false
	velocity = Vector2(0, 0)   

func enable_movement():
	can_move = true
	
func global_on_player_damaged():
	_damage(2)
# ___________________________________________________________________
	
func _damage(damage_value):
	# let player take damage and set health bar accordingly
	health -= damage_value
	if health <= 0:
		death()
	update_healthbar(health)


func death():
	# play death animation, and then switch to death scene once completed
	_animation.play('die')
	await _animation.animation_finished
	get_tree().change_scene_to_file("res://scenes/death.tscn")


func update_healthbar(value):
	# update colors of healthbar as user loses health
	healthbar.texture_progress = green_health
	if value < healthbar.max_value * 0.75:
		healthbar.texture_progress = yellow_health
	if value < healthbar.max_value * 0.45:
		healthbar.texture_progress = red_health
	if value <= 0:
		death()
	set_health_bar()


func global_coin_inventory_changed():
	# add three coins to the coin bar when user picks up a coin
	coins += 3
	set_coin_bar()
	
#_________________________________________Added by Rukaiah__________________________________________
func _on_mini_boss_level_wrong_answer(): # Connect the signal wrong_answer to this function in main 
	# The reduction of health and coins per wrong answer can be adjusted below
	is_special_animation_playing = true
	health -= 3
	coins -= 3 
	if health <= 0:
		health = 0
		# Add the function that handles the death of the player
	if coins <= 0: # Further logic can be added here once the number of coins reaches zero e.q sound effects 
		coins = 0 
	update_healthbar(health)
	set_coin_bar()
	_animation.play("hurt")
	_animation.animation_finished.connect(_on_special_animation_finished)


func _on_mini_boss_level_all_correct(): # Connect the signal all_correct to this function in main
	#is_special_animation_playing = true
	#_animation.play("shoot")
	_animation.animation_finished.connect(_on_special_animation_finished)
	if health < 100: 
		health = 100  # I am restoring the player's health to full if all answers are correct, but we can only add specific numbers if we wish
	coins += 100
	update_healthbar(health)  # make sure to update the health bar
	set_coin_bar()  # make sure to update the coins
	_animation.play("shoot")
	shoot_sound.play(0)
	
	
func _on_special_animation_finished():
	is_special_animation_playing = false
	_animation.animation_finished.disconnect(_on_special_animation_finished)
#___________________________________________________________________________________________________

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y
		}
	return save_dict


