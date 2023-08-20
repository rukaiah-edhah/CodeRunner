extends CanvasLayer

signal bought_item_data
signal item_bought

## SETS DEFAULT STARTING ITEM TO BERRY ##
var item = 1
var current_item = 0
var selection = 0



## CURRENTLY SETS DEFAULT ITEM VALUE SO THERE IS NO NULL VALUE ON START ##
func _ready():
    $Item_Icon.play("Berry")
    $Item_Name.text = "Berry"
    $Item_Description.text = "Makes for Good Yogurt"
    $Item_Price.text = "10"

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
                $Item_Icon.play("Orange")
#_____________________________________________________________________________#
## CONNECTED TO LEFT ARROW NODE AND USES FUNCTION TO CARRY OUT TASK ##
func _on_right_arrow_pressed():
    swap_item_forward()
    Switch_Item_Info()


func _on_left_arrow_pressed():
    swap_item_back()
    Switch_Item_Info()
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
        
        
#_____________________________________________________________________________#
## SWITCHES ITEM INFO DYNAMICALLY CHANGING THE LABEL/IMAGE ACCORDING TO DICTIONARY ASSIGNMENT ##
func Switch_Item_Info():
    if shop_inventory.has(item):  
        var item_data = shop_inventory[item]
        var item_name = item_data["Name"]
        var item_desc = item_data["Desc"]
        var item_cost = item_data["cost"]
        $Item_Name.text = item_name
        $Item_Description.text = item_desc
        $Item_Price.text = str(item_cost) 

#func _on_buy_pressed():
    #if shop_inventory.has(item):    ## Checks the items the shop will have for this level ##
        #var item_data = shop_inventory[item]
        #var item_cost = item_data["cost"]
        #if coins >= item_cost:						## Checks Player coins against item cost ##
            #emit_signal("item_bought", item_data)
            #coins -= item_cost
            #if player_inventory.has(item):			## Adds Item to players inventory ##
                #player_inventory[item]["count"] += 1
            #else:
                #player_inventory[item] = {
                    #"Name": item_data["Name"],
                    #"Desc": item_data["Desc"],
                    #"cost": item_data["cost"],
                    #"count": 1
                #}
            #print("Item bought:", item_data["Name"])
        #else:
            #print("Not enough coins to buy this")
#_____________________________________________________________________________#
## DICTIONARY FOR THE SHOPS INVENTORY ##
var gold = 10
var shop_inventory  = {
    1: {
        "Name": "Berry",
        "Desc": "Makes for good yogurt",
        "cost": 10
    },
    2: {
        "Name": "Carrot",
        "Desc": "For the rabbits",
        "cost": 2
    },
    3: {
        "Name": "Corn",
        "Desc": "Korny",
        "cost": 5
    },
    4: {
        "Name": "Orange",
        "Desc": "Orangnana",
        "cost": 10,
    }
}

#_____________________________________________________________________________#

 ## DICTIONARY FOR ITEMS IN PLAYERS INVENTORY ##
var player_inventory  = {
    1: {
        "Name": "Berry",
        "Desc": "Makes for good yogurt",
        "cost": 10,
        "count": 1,
    },
    2: {
        "Name": "Carrot",
        "Desc": "For the rabbits",
        "cost": 2,
        "count": 1,
    },
    3: {
        "Name": "Corn",
        "Desc": "Korny",
        "cost": 5,
        "count": 1,
    },
    4: {
        "Name": "Orange",
        "Desc": "Orangnana",
        "cost": 10,
        "count": 1,
    }
}



#func _on_item_bought():
    #if shop_inventory.has(item):    ## Checks the items the shop will have for this level ##
        #var item_data = shop_inventory[item]
        #var item_cost = item_data["cost"]
        #if coins >= item_cost:						## Checks Player coins against item cost ##
            #emit_signal("item_bought", item_data)
            #coins -= item_cost
            #if player_inventory.has(item):			## Adds Item to players inventory ##
                #player_inventory[item]["count"] += 1
            #else:
                #player_inventory[item] = {
                    #"Name": item_data["Name"],
                    #"Desc": item_data["Desc"],
                    #"cost": item_data["cost"],
                    #"count": 1
                #}
            #print("Item bought:", item_data["Name"])
        #else:
            #print("Not enough coins to buy this")


func _on_close__shop_pressed():
    get_node("Anim").play("Transition_Out")
    get_tree().paused = false
