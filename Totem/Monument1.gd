extends StaticBody

onready var Animation_Player = $AnimationPlayer


#this is to stop a crash at run time 
var player = null

#this allows the scene to get the player's node at run time
export (NodePath) var player_path

func _ready():
	player = get_node(player_path)
	Animation_Player.play("monument_empty")



func _on_Area_body_entered(body):
	if body.name=="Player":
		if player.owned_orb_1==true:
			Animation_Player.play("monument_placed_orb")
			pass
