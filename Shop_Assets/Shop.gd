extends CanvasLayer

var CurrItem = 0
var Select = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Item_Info/Item_Icon_Sprite").play("Apple")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func Switch_Item(Select):
	for i in range(Global.item.size() + 1 ):
		if Select == i:
			CurrItem = Select
			print(Global.item[Select])
			get_node("Item_Info/Item_Icon_Sprite").play(Global.item[CurrItem]["Name"])
			get_node("Item_Info/Name").text = Global.item[CurrItem]["Name"]
			get_node("Item_Info/Description").text = Global.item[CurrItem]["Desc"]
			get_node("Item_Info/Description").text +=  str(Global.item[CurrItem]["cost"])

func _on_close_button_pressed():
	get_node("Shop_Anim_Player").play("Trans_Out")
	get_tree().paused = false


func _on_left_arrow_pressed():
	Switch_Item(CurrItem-1)


func _on_right_arrow_pressed():
	Switch_Item(CurrItem+1)


func _on_buy_button_pressed():
	var hasItem = false
	if Global.gold >= Global.item[CurrItem]["cost"]:
		for i in Global.inventory:
			if Global.inventory[i]["Name"] == Global.item[CurrItem]["Name"]:
				Global.inventory[i]["Count"] += 1
				hasItem = true
			if hasItem == false:
				var TempDict = Global.item[CurrItem]
				TempDict["Count"] = 1
				Global.inventory[Global.inventory.size()] = TempDict
				Global.gold -= Global.item[CurrItem]["cost"]
	print(Global.inventory)
