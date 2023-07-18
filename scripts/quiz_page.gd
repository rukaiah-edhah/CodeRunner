extends Control

## Follow the comments that start with a hashtag and a number if you want more or fewer options 

var questions = [
    {
        "question": "Which type of programming language prioritizes ease of use and productivity?",
        "options": [" Higher-level languages", "Lower-level languages", "General-purpose languages", "Specific-purpose languages"], # 1. Add all of the options you want to display 
        "answer": 0 # The index of the correct answer
    },
    {
        "question": "Which category of programming languages offers a broad range of capabilities and can be used in various contexts?",
        "options": [" Higher-level languages", "Lower-level languages", "General-purpose languages", "Specific-purpose languages"],
        "answer": 2
    },
    {
        "question": "Which programming language is used for performance-critical tasks and provides more control and proximity to the hardware? ",
        "options": ["Python", "JavaScript", "Assembly", "C++"],
        "answer": 1
    }
]

var current_question_index = 0

func _ready():
    display_question()
  
  
func display_question():
    var question_label = $question_container/question_label
    var question = "[center]" + questions[current_question_index]["question"] + "[/center]"
    
    question_label.bbcode_text = question
    question_label.set_custom_minimum_size(Vector2(400, 100))  
    
    for button in range(4): # 2. Change the number based on the number of options you want 
        var option_button = $options_container.get_node("option_button" + str(button + 1))
        option_button.text = questions[current_question_index]["options"][button]
        option_button.disabled = false
        option_button.modulate = Color(1, 1, 1)  


func check_answer(selected_index):
    var correct_answer = questions[current_question_index]["answer"]
    if selected_index == correct_answer:
        var option_button = $options_container.get_node("option_button" + str(selected_index + 1))
        option_button.modulate = Color(0, 1, 0)  
        next_question()
    else:
        var option_button = $options_container.get_node("option_button" + str(selected_index + 1))
        option_button.modulate = Color(1, 0, 0)  
        option_button.disabled = true  
    
    
func next_question():
    var question_label = $question_container/question_label
    current_question_index += 1
    
    if current_question_index < questions.size():
        display_question()
    else:
        question_label.bbcode_text = "[center]" + "Quiz finished! Now it's time to go to the Code page." + "[/center]"
        for button in range(4): # 3. Do the same here 
            var option_button = $options_container.get_node("option_button" + str(button + 1))
            option_button.disabled = true


# 4. If the number of options is less than 4, turn off the toggle visibility of the option_button node you do not want to see, otherwise add another OptionButton node and connect it to the pressed() signal:
func _on_option_button_1_pressed(): 
     check_answer(0)
    
func _on_option_button_2_pressed():
    check_answer(1)

func _on_option_button_3_pressed():
    check_answer(2)
    
func _on_option_button_4_pressed():
    check_answer(3)    
