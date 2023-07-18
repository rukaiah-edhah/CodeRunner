extends CharacterBody2D

## DEFINES VARIABLES TO BE USED FOR ENEMY MOVEMENT ##
const SPEED = 75.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var direction = $player.position
#_________________________________________________#
## ENEMY MOVEMENT ##
func _physics_process(delta):
	direction = Vector2.LEFT
	velocity = direction * 75
	move_and_slide()
#_________________________________________________#




	#if not is_on_floor():
		#velocity.y += gravity * delta
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	#if direction:
			#velocity.x = direction * SPEED
		###velocity.x = move_toward(velocity.x, 0, SPEED)'
	#velocity.x = move_toward(velocity.x, 0, SPEED)
