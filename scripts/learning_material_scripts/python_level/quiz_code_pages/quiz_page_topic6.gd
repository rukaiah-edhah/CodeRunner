extends Control

## Follow the comments that start with a hashtag and a number if you want more or fewer options ##
## If the text inside of the options is long, you can increase the size of the options container or cut the text into two lines instead of one ##

signal wrong_answer
signal take_damage
signal quiz_finished

var questions = [
		{
		"question": "What does the slice my_string[0:5] return if my_string is 'Hello, World!'?",
		"options": ["Hell", "Hello", "Hello,", ", World!"], # 1. Add all of the options you want to display 
		"answer": 1 # The index of the correct answer
	},
	{
		"question": "If you want to access the last character of a string in Python, which index would you use?",
		"options": ["0", "-1", "1", "The length of the string"], # 1. Add all of the options you want to display 
		"answer": 1 # The index of the correct answer
	},
	{
		"question": 'If my_string is "Hello, World!", what would my_string[-5] return?',
		"options": [',', 'W', 'o','l'], # 1. Add all of the options you want to display 
		"answer": 2 # The index of the correct answer
	},
	{
		"question": 'When slicing a string in Python, if you omit the end index, it will:',
		"options": ["Return an empty string, Slice the string until its end, Result in an error, Return only the character at the start index"], # 1. Add all of the options you want to display 
		"answer": 1 # The index of the correct answer
	},
	{
		"question": 'What would be the result of my_string[7:] if my_string is "Hello, World!"?',
		"options": ["Hello, ", "World!", ", World!", "World"], # 1. Add all of the options you want to display 
		"answer": 1 # The index of the correct answer
	},
	{
		"question": "What do the parentheses after a function name in Python denote?",
		"options": ["Pass arguments to the function", "Signify the end of a function", "Represent the return value", "Define global variables"], # 1. Add all of the options you want to display 
		"answer": 0 # The index of the correct answer
	},
	{
		"question": "Which logical operator will return True only when both its operands are True?",
		"options": ["or", "and", "not", "None of the above"], # 1. Add all of the options you want to display 
		"answer": 1 # The index of the correct answer
	},
	{
		"question": "Which arithmetic operator is used to raise the first operand to the power of the second operand?",
		"options": ["Addition (+)", "Multiplication (*)", "Exponentiation (**)", "Modulus (%)"], # 1. Add all of the options you want to display 
		"answer": 2 # The index of the correct answer
	},
	{
		"question": "What will Python raise if you have inconsistent or missing indentation within a code block?",
		"options": ["SyntaxWarning", "CodeFlowError", "StructureMismatch", "IndentationError"], # 1. Add all of the options you want to display 
		"answer": 3 # The index of the correct answer
	},
	{
		"question": "What is the primary purpose of defining a function in Python?",
		"options": ["To store a value", "To improve the speed of a program", "To repeat a block of code multiple times", "To group code into logical, reusable units"], # 1. Add all of the options you want to display 
		"answer": 3 # The index of the correct answer
	},
	{
		"question": "What does the 'f' in an f-string in Python denote?",
		"options": ["It stands for 'formatted'", "It signals a floating-point number", "It represents 'file' type", "It's an indication of a failure string"], # 1. Add all of the options you want to display 
		"answer": 0 # The index of the correct answer
	},
	{
		"question": "Which arithmetic operator is used for division that results in a floating-point value?",
		"options": ["Multiplication (*)", "Modulus (%)", "Integer Division (//)", "Division (/)"], # 1. Add all of the options you want to display 
		"answer": 3 # The index of the correct answer
	},
	{
		"question": "Which of the following correctly calls the add_one function with the number 7 as an argument?",
		"options": ["add_one(7)", "add_one = 7", "7(add_one)", "call add_one(7)"], # 1. Add all of the options you want to display 
		"answer": 0 # The index of the correct answer
	},
	{
		"question": "In Python, which operator is used to check if two values are NOT equal?",
		"options": ["=!", "/=", "<>", "!="], # 1. Add all of the options you want to display 
		"answer": 3 # The index of the correct answer
	},
	{
		"question": "Which part of the function provides a result back to the caller?",
		"options": ["The return statement", "The function name", "The def keyword", "The parameters"], # 1. Add all of the options you want to display 
		"answer": 0 # The index of the correct answer
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
