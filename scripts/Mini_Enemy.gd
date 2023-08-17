extends CharacterBody2D

## DEFINES VARIABLES TO BE USED FOR ENEMY MOVEMENT ##
const SPEED = 75.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var direction = Vector2.LEFT
@onready var _animation = $AnimatedSprite2D
# Enemy state variables
var is_dead = false
signal Player_Damaged

func _ready():
    _animation = $AnimatedSprite2D
#_________________________________________________#
## ENEMY MOVEMENT ##
func _physics_process(delta):
    direction = Vector2.LEFT
    if !is_dead:
        velocity = direction * SPEED
        _animation.play("Run")
        move_and_slide()
    else:
        pass
        #_animation.play("Death")
#_________________________________________________#
## CHECKS IF THE PLAYER CHARACTER IS JUMPING ON THE ENEMY FOR DEATH PARAMETERS ##
func _on_collision_shape_2d_child_entered_tree(body):
    print("Entered Area")
    if body.is_in_group("player") and !is_dead:
        var player_velocity = body.get_slide_collision(0).normal
        if player_velocity.y > 0:
            enemy_died()
        else:
            emit_signal("Player_Damaged")
## ANOTHER PARAMETER CHECK TO MAKE SURE THE PLAYER CHARACTER IS NOT ON FLOOR WHEN DEFEATING ENEMY ##
func _on_area_2d_body_entered(body):
    if body.name == "player" and !is_dead:
        if is_on_floor() == false:
            enemy_died()
        else:
            emit_signal("Player_Damaged")

## ENEMY DEATH FUNCTION PLAYS DEATH ANIMATION AND TAKES AWAY THEIR COLLISION ##
func enemy_died():
    _animation.play("Death")
    is_dead = true
    collision_layer = 0

