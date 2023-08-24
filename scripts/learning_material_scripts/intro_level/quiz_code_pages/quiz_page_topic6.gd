extends Control

## Follow the comments that start with a hashtag and a number if you want more or fewer options ##
## If the text inside of the options is long, you can increase the size of the options container or cut the text into two lines instead of one ##

signal wrong_answer
signal take_damage
signal quiz_finished

var questions = [
		{
		"question": 'What is the key difference between a "while" loop and a "for" loop?',
		"options": ['"While" for finite, "for" for infinite iterations', '"While" loop is faster than "for" loop', '"For" loops over items, "while" is conditional', 'Both loops are interchangeable'], # 1. Add all of the options you want to display 
		"answer": 2 # The index of the correct answer
	},
		{
		"question": 'How does a "while" loop decide when to stop running?',
		"options": ['It checks the start value', "It looks at how often it's repeated", 'It checks if the condition is no longer true', 'It stops when an error pops up'], # 1. Add all of the options you want to display 
		"answer": 2 # The index of the correct answer
	},
		{
		"question": 'Why would you use loops like "for" and "while" in your code?',
		"options": ['To make the code look complex', 'To make code run endlessly', 'To Iterate tasks and lists', 'To clean up data'], # 1. Add all of the options you want to display 
		"answer": 2 # The index of the correct answer
	},
		{
		"question": 'What are the three main parts of a "for" loop?',
		"options": ['Code section, check, and end', 'Start value, check, and update step', 'Beginning, middle, and end', 'Kick-off, process, and wrap-up'], # 1. Add all of the options you want to display 
		"answer": 1 # The index of the correct answer
	},
		{
		"question": 'Which of the following is the name for a loop that never stops?',
		"options": ['Non-Stop Loop', 'Powerful Loop', 'Unstoppable Loop', 'Infinite Loop'], # 1. Add all of the options you want to display 
		"answer": 3# The index of the correct answer
	},
		{
		"question": 'Which control structure is used to execute a block of code only if a specified condition is true?',
		"options": ['The else statement', 'The if statement', 'The elif statement', 'All of the above'], # 1. Add all of the options you want to display 
		"answer": 1 # The index of the correct answer
	},
		{
		"question": 'What is the primary purpose of pseudocode?',
		"options": ['Serve as a blueprint', 'Act as executable code', 'Focus on syntax', 'Present logic simply'], # 1. Add all of the options you want to display 
		"answer": 3 # The index of the correct answer
	},
		{
		"question": 'Which type of programming language prioritizes ease of use and productivity?',
		"options": ['Higher-level languages', 'Lower-level languages', 'General-purpose languages', 'Specific-purpose languages'], # 1. Add all of the options you want to display 
		"answer": 0 # The index of the correct answer
	},
		{
		"question": 'Which operator stands for greater than or equal to?',
		"options": ['!=', '<=', '>', '>='], # 1. Add all of the options you want to display 
		"answer": 3 # The index of the correct answer
	},
		{
		"question": 'Which data type would you use to represent a True or False Value?',
		"options": ['Float', 'Boolean', 'Integer', 'Char'], # 1. Add all of the options you want to display 
		"answer": 1 # The index of the correct answer
	},
		{
		"question": 'Which of the following is NOT a data type?',
		"options": ['String', 'Dialogue', 'Float', 'Character'], # 1. Add all of the options you want to display 
		"answer": 1 # The index of the correct answer
	},
		{
		"question": 'What does the "=" operator do when used with variables?',
		"options": ['Declares a variable', 'Compares two variable values', 'Assigns a value to a variable', 'None of the above'], # 1. Add all of the options you want to display 
		"answer": 2 # The index of the correct answer
	},
		{
		"question": 'Which statement accurately describes pseudocode?',
		"options": ['A specific code-writing language', 'A universal language for programmers', 'A mix of natural language and code', 'Visual diagram of algorithm flo'], # 1. Add all of the options you want to display 
		"answer": 2 # The index of the correct answer
	},
		{
		"question": 'Which statement accurately describes flowcharts?',
		"options": ['A specific code-writing language', 'A universal language for programmers', 'A mix of natural language and code', 'Visual diagram of algorithm flo'], # 1. Add all of the options you want to display 
		"answer": 3 # The index of the correct answer
	},
		{
		"question": 'Which naming convention is commonly used in Python?',
		"options": ['Camel case', 'Snake case', 'Upper case', 'Pascal case'], # 1. Add all of the options you want to display 
		"answer": 1 # The index of the correct answer
	},
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
