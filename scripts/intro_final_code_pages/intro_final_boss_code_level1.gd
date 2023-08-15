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

@onready var font = preload("res://fonts-and-music/fonts/quiz_code_pages_font/LibreBaskerville-Regular.ttf")
@onready var bold = preload("res://fonts-and-music/fonts/quiz_code_pages_font/LibreBaskerville-Bold.ttf")


# options for words
var q_options = [
	'=', 'for', 'total', 'count',
	'else if', '0', 'while', 'max',
	'if', '1', '/', 'is less than',
	'score', 'input', '//', 'average',
	'display', '10', 'next score', 'sum',
	'+', 'end', '%', 'min'
	 ]

# index values corresponding with the correct answers in q_options dict + second list because there are two ways this could be done
var correct_answers1 = [
	2, 32, 0, 32, 5, 33,
	3, 32, 0, 32, 5, 33,
	6, 32, 3, 32, 11, 32, 17, 33,
	13, 32, 18, 33,
	2, 32, 0, 32, 2, 32, 20, 32, 12, 33,
	21, 32, 7, 33,
	15, 32, 0, 32, 2, 32, 10, 32, 17, 33,
	16, 32, 15
]

var correct_answers2 = [
	3, 32, 0, 32, 5, 33,
	2, 32, 0, 32, 5, 33,
	6, 32, 3, 32, 11, 32, 17, 33,
	13, 32, 18, 33,
	2, 32, 0, 32, 2, 32, 20, 32, 12, 33,
	21, 32, 7, 33,
	15, 32, 0, 32, 2, 32, 10, 32, 17, 33,
	16, 32, 15
]

# list to add answers to
var answer_list = []

# variable to track wrong answers
var wrong = false


func _ready():
	# create text for nodes and add fonts
	problem.text = 'Create a program that will find and display the average of ten scores.'
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
	answer_list.append(32)


func _on_newline_pressed():
	output.append_text('
')
	answer_list.append(33)
