extends Node2D

## SETS DEFAULT STARTING ITEM TO BERRY ##
var item = 1
func _ready():
	$Item_Icon.play("Berry")

#_____________________________________________________________________________#
## CHANGES SPRITE ANIMATIONS TO CORRESPONDING ITEM WHEN ARROWS ARE CLICKED ##
func _physics_process(delta):
	if self.visible:
		match item:
			1:
				$Item_Icon.play("Berry")
			2:
				$Item_Icon.play("Carrot")
			3:
				$Item_Icon.play("Corn")
			4:
				$Item_Icon.play("Onion")
#_____________________________________________________________________________#
## CONNECTED TO LEFT ARROW NODE AND USES FUNCTION TO CARRY OUT TASK ##
func _on_left_arrow_click_pressed():
	swap_item_back()
## CONNECTED TO RIGHT ARROW NODE AND USES FUNCTION TO CARRY OUT TASK ##
func _on_right_arrow_click_pressed():
	swap_item_forward()
	
## WORK IN PROGRESS ##
func _on_buy_button_pressed():
	print("buy")

#_____________________________________________________________________________#
## FUNCTION FOR THE LEFT ARROW TO SCROLL BACK ##
func swap_item_back():
	item -= 1
	if item < 1:
		item = 10
## FUNCTION FOR THE RIGHT ARROW TO SCROLL FORWARD ##
func swap_item_forward():
	item += 1
	if item > 10:
		item = 1
