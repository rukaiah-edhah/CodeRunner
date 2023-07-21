extends Control

var correct_answers = {
    "background_color/code_container/panel/player_answer": "+",
    "background_color/code_container/panel/player_answer2": "-",
    # You can add more and the right answer; however, keep in mind to put the path inside a string without using $
}

@onready var run_button =$background_color/run_button_conatiner/run_button 
@onready var feedback_label = $background_color/feedback_conatiner/panel_container/panel2/feedback_container/feedback_label


func _ready():
    feedback_label.text = "Click on Run to get your feedback."
    run_button.pressed.connect(_on_run_button_pressed)


func _on_run_button_pressed():
    var animation_player = $background_color/feedback_conatiner/panel_container/panel2/feedback_container/animation_player
    var all_correct = true
    var incorrect_answers = []
  
  
    for node_path in correct_answers.keys():
        var option_button = get_node(node_path)
        if option_button.selected == -1: 
            feedback_label.text = "Please answer all questions before running."
            animation_player.play("text_animation")
            return


    for node_path in correct_answers.keys():
        var option_button = get_node(node_path)
        var player_input = option_button.get_item_text(option_button.selected)
        if player_input != correct_answers[node_path]:
            all_correct = false
            incorrect_answers.append(node_path)
            option_button.text = "" # If we don't want to reveal the incorrect answer to the player, we can get rid of this line
    
    if all_correct:
        feedback_label.text = "All of your answers are correct, great job!"
        ## This line can be uncommented if we want to make the text green:
        #feedback_label.modulate = Color(0, 1, 0) 
    else:
        var answer_word = "answers"
        if incorrect_answers.size() == 1:
            answer_word = "answer"
        feedback_label.text = "You got " + number_to_word(incorrect_answers.size()) + " " + answer_word + " wrong." 
        ## This line can be uncommented if we want to make the text red:
        #feedback_label.modulate = Color(1, 0, 0)
        
    animation_player.play("text_animation")
    
        
func number_to_word(n):
    match n:
        0: return "zero"
        1: return "one"
        2: return "two"
        3: return "three"
        4: return "four"
        5: return "five"
        6: return "six"
        7: return "seven"
        8: return "eight"
        9: return "nine"
        10: return "ten"

