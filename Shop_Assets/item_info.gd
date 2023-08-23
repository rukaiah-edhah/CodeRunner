extends CanvasLayer

var Item_Name = ""
var Item_Des = ""
var Item_Cost = 0
var Item_Count = 0
var hasItem = false


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func _on_close_button_pressed():
    get_node("Item_Info_AP").play("Trans_Out")


func _on_use_button_pressed():
    for i in Global.inventory:
        if Global.inventory[i]["Name"] == Item_Name:
            Item_Count -= 1
            emit_signal("Player_Healed")
            if Item_Cost == 0:
                var TempDic = {}
                for x  in Global.inventory:
                    if x > 1:
                        TempDic[x - 1] = Global.inventory[x]
                    elif x < 1:
                        TempDic[x] = Global.inventory[x]
                    Global.inventory.clear()
                    Global.inventory = TempDic
                    _on_close_button_pressed()
            else:
                Global.inventory[i]["Count"] -= 1
            get_node("Player_Inventory")



func UpdateInfo():
    get_node("Title").text = Item_Name
    get_node("Description").text = Item_Des 
