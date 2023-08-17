extends Control

# signals to send accordingly to change health of player and final boss
signal wrong_answer
signal right_answer

@onready var wordbank = $words/wordbank
@onready var output = $words/panel/output
@onready var results = $results/result
@onready var problem = $problems/problem
@onready var submit = $buttons/submit
@onready var clear = $buttons/clear
@onready var space = $text_buttons/space
@onready var newline = $text_buttons/newline
@onready var indent = $text_buttons/indent

@onready var font = preload("res://fonts-and-music/fonts/quiz_code_pages_font/LibreBaskerville-Regular.ttf")
@onready var bold = preload("res://fonts-and-music/fonts/quiz_code_pages_font/LibreBaskerville-Bold.ttf")


# options for words
var q_options = [
	'=', '/', 'string', '"FizzBuzz"',
	'print', 'num', '5', '""',
	'("Input number")', ':', 'elif', 'if',
	'for', 'while', '%', '15',
	'"Fizz"', '+=', '"Buzz"', '3',
	'(string)', 'min', '0', '<',
	'input', 'i', '==', '1'
	 ]

# index values corresponding with the correct answers in q_options dict + second list because there are two ways this could be done
var correct_answers1 = [
	2, 40, 0, 40, 7, 41,
	25, 40, 0, 40, 22, 41,
	13, 40, 25, 40, 23, 40, 6, 9, 41,
	42, 5, 40, 0, 40, 24, 8, 41,
	42, 11, 40, 5, 40, 14, 40, 15, 40, 26, 40, 22, 9, 41,
	42, 42, 2, 40, 17, 40, 3, 41,
	42, 10, 40, 5, 40, 14, 40, 6, 40, 26, 40, 22, 9, 41,
	42, 42, 2, 40, 17, 40, 18, 41,
	42, 10, 40, 5, 40, 14, 40, 19, 40, 26, 40, 22, 9, 41,
	42, 42, 2, 40, 17, 40, 16, 41,
	42, 25, 40, 17, 40, 27, 41,
	4, 20
]

var correct_answers2 = [
	25, 40, 0, 40, 22, 41,
	2, 40, 0, 40, 7, 41,
	13, 40, 25, 40, 23, 40, 6, 9, 41,
	42, 5, 40, 0, 40, 24, 8, 41,
	42, 11, 40, 5, 40, 14, 40, 15, 40, 26, 40, 22, 9, 41,
	42, 42, 2, 40, 17, 40, 3, 41,
	42, 10, 40, 5, 40, 14, 40, 6, 40, 26, 40, 22, 9, 41,
	42, 42, 2, 40, 17, 40, 18, 41,
	42, 10, 40, 5, 40, 14, 40, 19, 40, 26, 40, 22, 9, 41,
	42, 42, 2, 40, 17, 40, 16, 41,
	42, 25, 40, 17, 40, 27, 41,
	4, 20
]

var correct_answers3 = [
	2, 40, 0, 40, 7, 41,
	25, 40, 0, 40, 22, 41,
	13, 40, 25, 40, 23, 40, 6, 9, 41,
	42, 5, 40, 0, 40, 24, 8, 41,
	42, 11, 40, 5, 40, 14, 40, 15, 40, 26, 40, 22, 9, 41,
	42, 42, 2, 40, 17, 40, 3, 41,
	42, 10, 40, 5, 40, 14, 40, 19, 40, 26, 40, 22, 9, 41,
	42, 42, 2, 40, 17, 40, 16, 41,
	42, 10, 40, 5, 40, 14, 40, 6, 40, 26, 40, 22, 9, 41,
	42, 42, 2, 40, 17, 40, 18, 41,
	42, 25, 40, 17, 40, 27, 41,
	4, 20
]

var correct_answers4 = [
	25, 40, 0, 40, 22, 41,
	2, 40, 0, 40, 7, 41,
	13, 40, 25, 40, 23, 40, 6, 9, 41,
	42, 5, 40, 0, 40, 24, 8, 41,
	42, 11, 40, 5, 40, 14, 40, 15, 40, 26, 40, 22, 9, 41,
	42, 42, 2, 40, 17, 40, 3, 41,
	42, 10, 40, 5, 40, 14, 40, 19, 40, 26, 40, 22, 9, 41,
	42, 42, 2, 40, 17, 40, 16, 41,
	42, 10, 40, 5, 40, 14, 40, 6, 40, 26, 40, 22, 9, 41,
	42, 42, 2, 40, 17, 40, 18, 41,
	42, 25, 40, 17, 40, 27, 41,
	4, 20
]

# list to add answers to
var answer_list = []

# variable to track wrong answers
var wrong = false

func _ready():
	# create text for nodes and add fonts
	problem.text = 'Create a program that will take five numbers and add the correct words to a string depending on what they are divisible by.
Add FizzBuzz if the number is divisible by both 5 and 3, Fizz if it is divisible by 3, or Buzz if it is divisible by 5.'
	problem.add_theme_font_override('font', font)
	# make sure label is inactive until player submits
	results.visible = false
	results.add_theme_font_override('font', font)
	submit.text = 'SUBMIT'
	submit.add_theme_font_override('font', bold)
	clear.text = 'CLEAR'
	clear.add_theme_font_override('font', bold)
	space.text = 'SPACE'
	space.add_theme_font_override('font', bold)
	newline.text = 'NEWLINE'
	newline.add_theme_font_override('font', bold)
	indent.text = 'INDENT'
	indent.add_theme_font_override('font', bold)
	# set column number + width + fonts to word bank
	wordbank.max_columns = 4
	wordbank.same_column_width = true
	wordbank.fixed_column_width = 155
	wordbank.add_theme_font_override('font', font)
	wordbank.add_theme_color_override('font_color', 'ffff')
	wordbank.add_theme_color_override('font_hovered_color', 'ffff')
	wordbank.add_theme_color_override('font_selected_color', 'ffff')
	output.push_font(font, 16)
	
	# go through list and assign the values to options in item list
	for option in q_options:
		wordbank.add_item(option)


func check_answers(answers):
	# checking the answers, go through the lists of correct answer indexes and the list of answers given and check if they are the same
	for i in correct_answers1:
		for j in correct_answers2:
			for x in correct_answers3:
				for y in correct_answers4:
					for a in answers:
						if a == i:
							wrong = false
						else:
							wrong = true
						if wrong == true:
							if a == j:
								wrong = false
							else:
								wrong = true
						if wrong == true:
							if a == x:
								wrong = false
							else:
								wrong = true
						if wrong == true:
							if a == y:
								wrong = false
							else:
								wrong = true
	if answers == []:
		# make sure if the list is empty that it is still wrong
		wrong = true
	
	# if they are different, call the retry quiz function, otherwise winner function
	if wrong == true:
		retry_quiz()
	else:
		winner()


func retry_quiz():
	# reset quiz, create loser label and send wrong_answer signal
	results.text = 'You missed... Try again.'
	emit_signal('wrong_answer')
	reset_quiz()


func reset_quiz():
	# reset quiz and reset variables as needed
	output.clear()
	output.push_font(font, 16)
	answer_list.clear()


func winner():
	# declare winner and send right_answer signal
	results.text = 'Congratulations!'
	emit_signal('right_answer')


func _on_clear_pressed():
	# clear output and reset variables as needed
	reset_quiz()


func _on_submit_pressed():
	# check answers when user submits and make label visible
	check_answers(answer_list)
	results.visible = true


func _on_wordbank_item_activated(index):
#	# append text to the output when clicked on, also append to answer list for checking
	output.append_text(q_options[index])
	answer_list.append(index)
	return answer_list


func _on_space_pressed():
	output.append_text(' ')
	answer_list.append(40)


func _on_newline_pressed():
	output.append_text('
')
	answer_list.append(41)


func _on_indent_pressed():
	output.append_text('    ')
	answer_list.append(42)
