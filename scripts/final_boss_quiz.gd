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

@onready var font = preload("res://fonts-and-music/fonts/quiz_code_pages_font/LibreBaskerville-Regular.ttf")

# variable to track number of items clicked
var items_clicked = 0

# options for words
var q_options = [
	'even_list, odd_list', '=', 'else:', 'even_list', '(num_list)',
	'odd_list', '2', 'def', '(i)', 'num_list', ':', 'while',
	'func', '5', '[]', 'split_even_odd', 'total',
	'int', 'even_list.append', 'str', 'for',
	'i', 'return', 'print', '%', 'in', 'if',
	'==', 'odd_list.append', '0:', '(num)', 'elif'
	]

# index values corresponding with the correct answers in q_options dict + second list because there are two ways this could be done
var correct_answers1 = [
	7, 15, 4, 10, 3, 1, 14, 5, 1, 14,
	20, 21, 25, 9, 10, 26, 20, 24, 6, 27,
	29, 18, 8, 2, 28, 8, 22, 0
]

var correct_answers2 = [
	7, 15, 4, 10, 5, 1, 14, 3, 1, 14,
	20, 21, 25, 9, 10, 26, 20, 24, 6, 27,
	29, 18, 8, 2, 28, 8, 22, 0
]

# list to add answers to
var answer_list = []

# which numbers of items clicked will require new lines, spaces + levels of indentation
var newline_req = [4, 7, 10, 15, 21, 23, 24, 26]
var no_space = [2, 3, 14, 22, 25]
var indentation = [4, 7, 10, 15, 21, 23, 24, 26]
var double_indentation = [15, 21, 23, 24]
var triple_indentation = [21, 24]

# variable to track wrong answers
var wrong = false

# active variable to keep label inactive until player submits
var active = false


func _ready():
	# create text for nodes and add fonts
	problem.text = 'Create a program that will take a list and seperate it into even and odd lists.'
	problem.add_theme_font_override('font', font)
	# make sure label is inactive until player submits
	results.visible = active
	results.add_theme_font_override('font', font)
	submit.text = 'Submit'
	submit.add_theme_font_override('font', font)
	clear.text = 'Clear'
	clear.add_theme_font_override('font', font)
	# set column number + width + fonts to word bank
	wordbank.max_columns = 4
	wordbank.same_column_width = true
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
	items_clicked = 0


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
	# append text to the output when clicked on, also append to answer list for checking
	output.append_text(q_options[index])
	answer_list.append(index)
	# add one to items clicked after each item chosen and then add new lines, indentation and spaces where they would be needed in the correct program
	items_clicked += 1
	if items_clicked in newline_req:
		output.append_text('
')
	elif items_clicked in no_space:
		output.append_text('')
	else:
		output.append_text(' ')
	if items_clicked in indentation:
		output.append_text('    ')
	if items_clicked in double_indentation:
		output.append_text('    ')
	if items_clicked in triple_indentation:
		output.append_text('    ')
	return answer_list
