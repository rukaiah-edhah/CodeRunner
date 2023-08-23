extends Panel

var hasitem = false
var Item_Name = ""
var Item_Des = ""
var Item_Cost = 0
var Item_Count = 0
var mouseEntered = false


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if hasitem == true:
        get_node("Item_Icon").show()
        get_node("Count").show()
    else:
        get_node("Item_Icon").hide()
        get_node("Count").hide()
        
        
        
func _input(event):
    if event.is_action("Left_Click"):
        if mouseEntered:
            get_node("res://Shop_Assets/Item_Info/Icon")


func _on_mouse_entered():
    if hasitem == true:
        mouseEntered= true


func _on_mouse_exited():
    mouseEntered = false

func _input2(event):
    if event.is_action_pressed("Left_Click"):
        if mouseEntered:
            get_node("Item_Info/Icon").texture = get_node("Icon")
            get_node("item_info").ItemName = Item_Name
            get_node("item_info").ItemDes = Item_Des
            get_node("item_info").ItemCost = Item_Cost
            get_node("item_info").ItemCount = Item_Count
            get_node("Item_Info_AP").play("Trans_In")
            get_node("/root/ItemInfo").UpdateInfo()

