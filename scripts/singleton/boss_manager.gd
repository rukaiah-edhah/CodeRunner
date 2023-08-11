extends Node

var bosses = []
var player = null

func set_player(player_node):
    player = player_node

func add_boss(boss):
    # IF YOU GOT THE FOLLOWING ERROR: Assertion failed. IGNORE IT FOR NOW TILL WE HAVE BOTH THE BOSS LEVEL AND THE PLAYER IN THE MAIN SCENE
    assert(player != null) # The purpose of this line is to check that the player is not null. If the game is running smoothly, we can remove it.
    bosses.append(boss)
    boss.wrong_answer.connect(player._on_mini_boss_level_wrong_answer)
    boss.all_correct.connect(player._on_mini_boss_level_all_correct)

func remove_boss(boss):
    bosses.erase(boss)
    boss.wrong_answer.disconnect(player._on_mini_boss_level_wrong_answer)
    boss.all_correct.disconnect(player._on_mini_boss_level_all_correct)
