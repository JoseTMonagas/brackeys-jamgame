extends StaticBody

var player_owned = false

#this is to stop a crash at run time 
var player = null

#this allows the scene to get the player's node at run time
export (NodePath) var player_path



func _ready():
	#sets player as the "player" node
	player = get_node(player_path)
	$AnimationPlayer.play("OrbIdle")


#sends the player the orb's number
func player_owns(var orb_number):
	player.owns_orb(orb_number)



#check whether the player is whithin the effect radius
func _on_Area_body_entered(body):
	if body.name=="Player":
		player_owned = true
		player_owns("orb_yellow")
		get_tree().queue_delete(self)
