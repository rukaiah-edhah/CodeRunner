extends Node2D


const music_path: String = "res://fonts-and-music/music/DavidKBD - Cosmic Pack 02 - Galactic Pulse-full.ogg"
@onready var player = $'in_game_items/2/player'
var enemy_scene = preload("res://scenes/Mini_Enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	create_connections()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func transport(body, place):
	# check if it is player falling -> if it is then put them in the position of the return area
	if body.is_in_group('player'):
		player.position = place.get_position()
		

func _on_fall_area_body_entered(body):
	transport(body, $fall_return_areas/return_area)


func _on_fall_area_2_body_entered(body):
	transport(body, $fall_return_areas/return_area2)


func _on_fall_area_3_body_entered(body):
	transport(body, $fall_return_areas/return_area3)


func _on_fall_area_4_body_entered(body):
	transport(body, $fall_return_areas/return_area4)


func _on_fall_area_5_body_entered(body):
	transport(body, $fall_return_areas/return_area5)


func _on_fall_area_6_body_entered(body):
	transport(body, $fall_return_areas/return_area6)


func _on_fall_area_7_body_entered(body):
	transport(body, $fall_return_areas/return_area7)


func _on_fall_area_8_body_entered(body):
	transport(body, $fall_return_areas/return_area8)


func _on_fall_area_9_body_entered(body):
	transport(body, $fall_return_areas/return_area9)


func _on_fall_area_10_body_entered(body):
	transport(body, $fall_return_areas/return_area10)


func _on_fall_area_11_body_entered(body):
	transport(body, $fall_return_areas/return_area11)


func _on_fall_area_12_body_entered(body):
	transport(body, $fall_return_areas/return_area12)


func _on_fall_area_13_body_entered(body):
	transport(body, $fall_return_areas/return_area13)


func _on_fall_area_14_body_entered(body):
	transport(body, $fall_return_areas/return_area14)


func _on_fall_area_15_body_entered(body):
	transport(body, $fall_return_areas/return_area15)


func _on_fall_area_16_body_entered(body):
	transport(body, $fall_return_areas/return_area16)


func _on_fall_area_17_body_entered(body):
	transport(body, $fall_return_areas/return_area17)


func _on_fall_area_18_body_entered(body):
	transport(body, $fall_return_areas/return_area18)


func _on_fall_area_19_body_entered(body):
	transport(body, $fall_return_areas/return_area19)


func _on_fall_area_20_body_entered(body):
	transport(body, $fall_return_areas/return_area20)


func _on_fall_area_21_body_entered(body):
	transport(body, $fall_return_areas/return_area21)


func _on_fall_area_22_body_entered(body):
	transport(body, $fall_return_areas/return_area22)


func _on_fall_area_23_body_entered(body):
	transport(body, $fall_return_areas/return_area23)


func _on_fall_area_24_body_entered(body):
	transport(body, $fall_return_areas/return_area24)


func _on_fall_area_25_body_entered(body):
	transport(body, $fall_return_areas/return_area25)


func _on_fall_area_26_body_entered(body):
	transport(body, $fall_return_areas/return_area26)


func _on_fall_area_27_body_entered(body):
	transport(body, $fall_return_areas/return_area27)


func _on_fall_area_28_body_entered(body):
	transport(body, $fall_return_areas/return_area28)


func _on_fall_area_29_body_entered(body):
	transport(body, $fall_return_areas/return_area29)


func _on_fall_area_30_body_entered(body):
	transport(body, $fall_return_areas/return_area30)


func _on_fall_area_31_body_entered(body):
	transport(body, $fall_return_areas/return_area31)


func _on_fall_area_32_body_entered(body):
	transport(body, $fall_return_areas/return_area32)


func _on_fall_area_33_body_entered(body):
	transport(body, $fall_return_areas/return_area33)


func _on_fall_area_34_body_entered(body):
	transport(body, $fall_return_areas/return_area34)


func _on_fall_area_35_body_entered(body):
	transport(body, $fall_return_areas/return_area35)


func _on_fall_area_36_body_entered(body):
	transport(body, $fall_return_areas/return_area36)


func _on_fall_area_37_body_entered(body):
	transport(body, $fall_return_areas/return_area37)


func _on_fall_area_38_body_entered(body):
	transport(body, $fall_return_areas/return_area38)


func _on_fall_area_39_body_entered(body):
	transport(body, $fall_return_areas/return_area39)


func _on_fall_area_40_body_entered(body):
	transport(body, $fall_return_areas/return_area40)


func _on_fall_area_41_body_entered(body):
	transport(body, $fall_return_areas/return_area41)


func _on_fall_area_42_body_entered(body):
	transport(body, $fall_return_areas/return_area42)


func _on_fall_area_43_body_entered(body):
	transport(body, $fall_return_areas/return_area43)


func _on_fall_area_44_body_entered(body):
	transport(body, $fall_return_areas/return_area44)


func _on_fall_area_45_body_entered(body):
	transport(body, $fall_return_areas/return_area45)


func _on_fall_area_46_body_entered(body):
	transport(body, $fall_return_areas/return_area46)


func _on_fall_area_47_body_entered(body):
	transport(body, $fall_return_areas/return_area47)

func create_connections():
	$fall_return_areas/fall_area.body_entered.connect(_on_fall_area_body_entered)
	$fall_return_areas/fall_area2.body_entered.connect(_on_fall_area_2_body_entered)
	$fall_return_areas/fall_area3.body_entered.connect(_on_fall_area_3_body_entered)
	$fall_return_areas/fall_area4.body_entered.connect(_on_fall_area_4_body_entered)
	$fall_return_areas/fall_area5.body_entered.connect(_on_fall_area_5_body_entered)
	$fall_return_areas/fall_area6.body_entered.connect(_on_fall_area_6_body_entered)
	$fall_return_areas/fall_area7.body_entered.connect(_on_fall_area_7_body_entered)
	$fall_return_areas/fall_area8.body_entered.connect(_on_fall_area_8_body_entered)
	$fall_return_areas/fall_area9.body_entered.connect(_on_fall_area_9_body_entered)
	$fall_return_areas/fall_area10.body_entered.connect(_on_fall_area_10_body_entered)
	$fall_return_areas/fall_area11.body_entered.connect(_on_fall_area_11_body_entered)
	$fall_return_areas/fall_area12.body_entered.connect(_on_fall_area_12_body_entered)
	$fall_return_areas/fall_area13.body_entered.connect(_on_fall_area_13_body_entered)
	$fall_return_areas/fall_area14.body_entered.connect(_on_fall_area_14_body_entered)
	$fall_return_areas/fall_area15.body_entered.connect(_on_fall_area_15_body_entered)
	$fall_return_areas/fall_area16.body_entered.connect(_on_fall_area_16_body_entered)
	$fall_return_areas/fall_area17.body_entered.connect(_on_fall_area_17_body_entered)
	$fall_return_areas/fall_area18.body_entered.connect(_on_fall_area_18_body_entered)
	$fall_return_areas/fall_area19.body_entered.connect(_on_fall_area_19_body_entered)
	$fall_return_areas/fall_area20.body_entered.connect(_on_fall_area_20_body_entered)
	$fall_return_areas/fall_area21.body_entered.connect(_on_fall_area_21_body_entered)
	$fall_return_areas/fall_area22.body_entered.connect(_on_fall_area_22_body_entered)
	$fall_return_areas/fall_area23.body_entered.connect(_on_fall_area_23_body_entered)
	$fall_return_areas/fall_area24.body_entered.connect(_on_fall_area_24_body_entered)
	$fall_return_areas/fall_area25.body_entered.connect(_on_fall_area_25_body_entered)
	$fall_return_areas/fall_area26.body_entered.connect(_on_fall_area_26_body_entered)
	$fall_return_areas/fall_area27.body_entered.connect(_on_fall_area_27_body_entered)
	$fall_return_areas/fall_area28.body_entered.connect(_on_fall_area_28_body_entered)
	$fall_return_areas/fall_area29.body_entered.connect(_on_fall_area_29_body_entered)
	$fall_return_areas/fall_area30.body_entered.connect(_on_fall_area_30_body_entered)
	$fall_return_areas/fall_area31.body_entered.connect(_on_fall_area_31_body_entered)
	$fall_return_areas/fall_area32.body_entered.connect(_on_fall_area_32_body_entered)
	$fall_return_areas/fall_area33.body_entered.connect(_on_fall_area_33_body_entered)
	$fall_return_areas/fall_area34.body_entered.connect(_on_fall_area_34_body_entered)
	$fall_return_areas/fall_area35.body_entered.connect(_on_fall_area_35_body_entered)
	$fall_return_areas/fall_area36.body_entered.connect(_on_fall_area_36_body_entered)
	$fall_return_areas/fall_area37.body_entered.connect(_on_fall_area_37_body_entered)
	$fall_return_areas/fall_area38.body_entered.connect(_on_fall_area_38_body_entered)
	$fall_return_areas/fall_area39.body_entered.connect(_on_fall_area_39_body_entered)
	$fall_return_areas/fall_area40.body_entered.connect(_on_fall_area_40_body_entered)
	$fall_return_areas/fall_area41.body_entered.connect(_on_fall_area_41_body_entered)
	$fall_return_areas/fall_area42.body_entered.connect(_on_fall_area_42_body_entered)
	$fall_return_areas/fall_area43.body_entered.connect(_on_fall_area_43_body_entered)
	$fall_return_areas/fall_area44.body_entered.connect(_on_fall_area_44_body_entered)
	$fall_return_areas/fall_area45.body_entered.connect(_on_fall_area_45_body_entered)
	$fall_return_areas/fall_area46.body_entered.connect(_on_fall_area_46_body_entered)
	$fall_return_areas/fall_area47.body_entered.connect(_on_fall_area_47_body_entered)
