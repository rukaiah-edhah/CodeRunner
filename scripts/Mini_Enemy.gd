extends CharacterBody2D

## DEFINES VARIABLES TO BE USED FOR ENEMY MOVEMENT ##
const SPEED = 75.0
const JUMP_VELOCITY = -400.0
const ENEMY_HEIGHT = 180.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var direction = Vector2.LEFT
@onready var _animation = $AnimatedSprite2D
@onready var flip_timer = $flip_timer
# Enemy state variables
var is_dead = false
var can_flip = true
signal Player_Damaged

func _ready():
    flip_timer.timeout.connect(_on_flip_timer_timeout)
    for lava_area in get_tree().get_nodes_in_group("lava"):
        lava_area.body_entered.connect(_on_lava_area_body_entered)

#_________________________________________________#
## ENEMY MOVEMENT ##
func _physics_process(delta): 
    if !is_dead:
        #________________________Added by Rukaiah_____________________
        if !is_on_floor():
            velocity.y += gravity * delta # Applying gravity
        
        velocity.x = direction.x * SPEED
        move_and_slide()
        
        var has_processed_collision = false
        
        for i in range(get_slide_collision_count()):
            var collision = get_slide_collision(i)
            var normal = collision.get_normal()
            var collider = collision.get_collider()
            
            if has_processed_collision:
                break

            if collider and collider.is_in_group("player"):
                if normal.y > 0 and collider.global_position.y < (self.global_position.y - ENEMY_HEIGHT * 0.5):
                        enemy_died()
                        has_processed_collision = true
                else:
                    emit_signal("Player_Damaged")
                    has_processed_collision = true
    
            if can_flip and normal.x != 0:
                direction.x = -direction.x
                can_flip = false
                flip_timer.start()
            
            if has_processed_collision:
                return
        
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
func _on_flip_timer_timeout():
    can_flip = true

## ENEMY DEATH FUNCTION PLAYS DEATH ANIMATION AND TAKES AWAY THEIR COLLISION ##
func enemy_died():
    _animation.play("Death")
    is_dead = true
    #  We can use queue_free() or the following: 
    collision_layer = 0
    $CollisionShape2D.call_deferred("set", "disabled", true)

func _on_lava_area_body_entered(body):
    if body == self and can_flip:
        direction.x = -direction.x
        can_flip = false
        flip_timer.start()
