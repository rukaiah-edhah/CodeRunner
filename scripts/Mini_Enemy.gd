extends CharacterBody2D

## DEFINES VARIABLES TO BE USED FOR ENEMY MOVEMENT ##
const SPEED = 75.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var direction = Vector2.LEFT
@onready var _animation = $AnimatedSprite2D
@onready var flip_timer = $flip_timer
@onready var player_damage_area = $player_damage_area
# Enemy state variables
var is_dead = false
var can_flip = true
signal Player_Damaged

func _ready():
    flip_timer.timeout.connect(_on_flip_timer_timeout)
    player_damage_area.body_entered.connect(_on_enemy_body_collision)
    
    
    direction = Vector2.LEFT
    _animation = $AnimatedSprite2D
#_________________________________________________#
## ENEMY MOVEMENT ##
func _physics_process(delta): 
    if !is_dead:
        #________________________Added by Rukaiah_____________________
        if !is_on_floor():
            velocity.y += gravity * delta # Applying gravity
        
        velocity.x = direction.x * SPEED
        move_and_slide()
        
        var player_jumped_on_head = false
        
        for i in range(get_slide_collision_count()):
            var collision = get_slide_collision(i)
            var normal = collision.get_normal()
            var collider = collision.get_collider()

            if collider and collider.is_in_group("player"):
                # Check if player jumped on head
                if normal.y > 0:
                    player_jumped_on_head = true
                    break
                    
            if can_flip and normal.x != 0:
                direction.x = -direction.x
                can_flip = false
                flip_timer.start()
        
            """elif normal.x != 0:  # It's a wall or other static object
                direction.x = -direction.x
                #_animation.flip_h = !_animation.flip_h
                break"""

        # If player jumped on enemy's head
        if player_jumped_on_head:
            enemy_died()
        else:
            _animation.play("Run")
            
        if direction.x < 0:
            _animation.flip_h = false
        else:
            _animation.flip_h = true
         #_______________________________________________________________       
    else:
        pass
        #_animation.play("Death")   
        
#_________________________________________________#
## CHECKS IF THE PLAYER CHARACTER IS JUMPING ON THE ENEMY FOR DEATH PARAMETERS ##
func _on_enemy_body_collision(body):
    print("Enemy collided with: ", body.name)  # Keep this for debugging
    if body.is_in_group("player"):
        body.emit_signal("Player_Damaged")
        
## ANOTHER PARAMETER CHECK TO MAKE SURE THE PLAYER CHARACTER IS NOT ON FLOOR WHEN DEFEATING ENEMY ##
func _on_area_2d_body_entered(body):
    if body.name == "player" and !is_dead:
        if !body.is_on_floor():
            enemy_died()
    else:
        emit_signal("Player_Damaged")
        
func _on_flip_timer_timeout():
    can_flip = true

## ENEMY DEATH FUNCTION PLAYS DEATH ANIMATION AND TAKES AWAY THEIR COLLISION ##
func enemy_died():
    _animation.play("Death")
    is_dead = true
    player_damage_area.call_deferred("set", "disabled", true)
    #  We can use queue_free() or the following: 
    collision_layer = 0
    $CollisionShape2D.call_deferred("set", "disabled", true)

