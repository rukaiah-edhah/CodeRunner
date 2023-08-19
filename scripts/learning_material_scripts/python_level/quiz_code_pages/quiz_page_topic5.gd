extends Control

## Follow the comments that start with a hashtag and a number if you want more or fewer options ##
## If the text inside of the options is long, you can increase the size of the options container or cut the text into two lines instead of one ##

signal wrong_answer
signal take_damage
signal quiz_finished

var questions = [
	{
		"question": "How do 'if,' 'elif,' and 'else' statements help manage how a program runs?",
		"options": ["They set the program's start point", "They determine code's loop count", "They modify variable types", "They specify conditions for code paths"], # 1. Add all of the options you want to display 
		"answer": 4 # The index of the correct answer
	},
	{
		"question": "Which control structure is used to execute a block of code only if a specified condition is true?",
		"options": ["The else statement", "The if statement", "The elif statement", "All of the above"],
		"answer": 2
	},
	{
		"question": "What is the purpose of the else statement?",
		"options": ["Executes code if a condition is false", "Executes code if a condition is true", "Executes code regardless of prior condition", "Manages exceptions and errors"],
		"answer": 1
	},
	{
		
		"question": "What is the purpose of the elif statement in conditional control structures?",
		"options": ["Checks conditions and runs the first true one", "Runs code for a true condition", "Offers alternate block for false conditions.", "Prints variable's message"],
		"answer": 1
	},
	{
		"question": "Which statement must be used to start a chain of conditional statements?",
		"options": ["if", "elif", "else", "for"],
		"answer": 1
	}
]
@onready var question_label = $background_color/question_container/question_label

var current_question_index = 0
var option_buttons = []

func _ready():
	for button in range(4): # 2. Adjust range based on the number of options
		var option_button = $background_color/options_container.get_node("option_button" + str(button + 1))
		option_buttons.append(option_button)
	display_question()
  
  
func display_question():
	var question = "[center]" + questions[current_question_index]["question"] + "[/center]"
	
	question_label.bbcode_text = question
	question_label.set_custom_minimum_size(Vector2(400, 50))  
	
	for button in range(4): # 3. Do the same here 
		option_buttons[button].text = questions[current_question_index]["options"][button]
		option_buttons[button].disabled = false
		option_buttons[button].modulate = Color(1, 1, 1)


func check_answer(selected_index):
	var correct_answer = questions[current_question_index]["answer"]
	if selected_index == correct_answer:
		option_buttons[selected_index].modulate = Color(0, 1, 0)  
		emit_signal("take_damage", 50 / questions.size())
		next_question()
	else:
		option_buttons[selected_index].modulate = Color(1, 0, 0)  
		option_buttons[selected_index].disabled = true  
		emit_signal("wrong_answer")
	
func next_question():
	current_question_index += 1
	
	if current_question_index < questions.size():
		display_question()
	else:
		question_label.bbcode_text = "[center]" + "Quiz finished! Now it's time to go to the Code page." + "[/center]"
		for button in range(4): # 4. Here as well
			option_buttons[button].disabled = true
		emit_signal("quiz_finished")


# 5. If the number of options is less than 4, turn off the toggle visibility of the option_button node you do not want to see, otherwise add another OptionButton node and connect it to the pressed() signal:
func _on_option_button_1_pressed(): 
	check_answer(0)
	
func _on_option_button_2_pressed():
	check_answer(1)

func _on_option_button_3_pressed():
	check_answer(2)
	
func _on_option_button_4_pressed():
	check_answer(3)    
