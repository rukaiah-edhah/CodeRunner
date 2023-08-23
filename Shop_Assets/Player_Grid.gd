extends GridContainer

@onready var item = preload("res://Shop_Assets/item_slot.tscn")
var inv_size = 24


func _ready():
	for i in inv_size:
		var itemTemp = item.instantiate()
		add_child(itemTemp)
		#fill_inventory_slots()


func fill_inventory_slots():
	
	for i in inv_size:
		get_child(i).Item_Name = ""
		get_child(i).Item_Des = ""
		get_child(i).Item_Cost = 0
		get_child(i).Item_Count = 0
		get_child(i).hasitem = false
	
	for i in Global.inventory:
		get_child(i).Item_Name = Global.inventory[i]["Name"]
		get_child(i).Item_Des = Global.inventory[i]["Desc"]
		get_child(i).Item_Cost = Global.inventory[i]["cost"]
		get_child(i).Item_Count = Global.inventory[i]["Count"]
		get_child(i).get_node("Item_Icon").texture = Global.inventory[i]["Item_Icon"]
		get_child(i).hasitem = true 
