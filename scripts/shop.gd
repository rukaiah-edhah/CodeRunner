extends Node2D

## DISPLAYS ANIMATION FOR THE SHOP OWNER ##
func _physics_process(delta):
	if self.visible:
		var shopOwner = get_node("Shop_Owner")

#_________________________________________________#
## SETS A RANDOM OWNER'S ANIMATION TO DISPLAY FOR EACH LEVEL ##
		var randomOwner = generate_random_owner()
		if randomOwner == 1:
			shopOwner.play("Sally")
		elif randomOwner == 2:
			shopOwner.play("Bob")
## RANDOM NUMBER GENERATOR TO CHOOSE BETWEEN OWNER ANIMATIONS ##
func generate_random_owner():
	return randf_range(1, 2)
