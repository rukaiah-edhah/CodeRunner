extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


var gold = 100000
var item  = {
    1: {
        "Name": "Apple",
        "Desc": "This is an apple.",
        "cost": 10
    },
    2: {
        "Name": "Berry",
        "Desc": "Great in yogurt",
        "cost": 2
    },
    3: {
        "Name": "Carrot",
        "Desc": "Whats up Doc?",
        "cost": 5
    }
}


var inventory = {
    0: {
        "Name": "Apple",
        "Desc": "This is an apple.",
        "cost": 10,
        "Count": 1,
        #"Item_Icon": preload("res://images/Berry.png")
    },
    1: {
        "Name": "Berry",
        "Desc": "Great in yogurt",
        "cost": 2,
        "Count": 0
    }
}
