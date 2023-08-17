extends Control

@onready var game_over_label = $g_label
@onready var restart_button = $restart
@onready var quit_button = $quit

var font = preload('res://fonts-and-music/fonts/quiz_code_pages_font/LibreBaskerville-Bold.ttf')

# Called when the node enters the scene tree for the first time.
func _ready():
    # set labels and formatting
    game_over_label.text = 'GAME OVER'
    game_over_label.add_theme_font_override('normal_font', font)
    game_over_label.add_theme_font_size_override("normal_font_size", 30)
    game_over_label.fit_content = true
    
    restart_button.text = 'RESTART'
    restart_button.add_theme_font_override('font', font)
    quit_button.text = 'QUIT AND EXIT'
    quit_button.add_theme_font_override('font', font)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func _on_quit_pressed():
    # quit when they want to quit
    get_tree().quit()


func _on_restart_pressed():
    # check scene name and move back to restart correct scene if that is what you want to do
    print(get_tree().current_scene.name)
    if get_tree().current_scene.name == 'intro_level':
        get_tree().change_scene_to_file("res://scenes/intro_level.tscn")
    if get_tree().current_scene.name == 'python_level':
        get_tree().change_scene_to_file("res://scenes/python_level.tscn")
