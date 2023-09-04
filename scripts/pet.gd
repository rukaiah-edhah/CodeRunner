extends CharacterBody2D

@onready var _animation = $AnimatedSprite2D

var player = null
var offset = Vector2(-200, 0)
var hover_amplitude = 20
var hover_speed = 2
var time_passed = 0

func _ready():
    player = get_node("../player")

func _physics_process(delta):
    if player != null:
        _animation.flip_h = player._animation.flip_h  
        
        var player_current_animation = player._animation.animation
        
        if player_current_animation == "hurt":
            _animation.play("hurt")
        elif player_current_animation == "die":
            _animation.play("die")
        else:
            _animation.play("idle")
            

        global_position.x = lerp(global_position.x, player.global_position.x + offset.x, 0.1)

        time_passed += delta
        var hover_offset = sin(time_passed * hover_speed) * hover_amplitude
        global_position.y = player.global_position.y + offset.y + hover_offset

        move_and_slide()


