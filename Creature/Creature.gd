extends KinematicBody

const SPEED = 9.8

var direction = Vector3.ZERO
var velocity = Vector3.ZERO
var player = null

export (NodePath) var player_path


func _ready():
	player = get_node(player_path)


func _physics_process(delta):
	var player_position = player.global_transform.origin
	var self_position = global_transform.origin
	var distance = (self_position - player_position).normalized() * -1
	
	velocity = Vector3(distance.x * SPEED, distance.y * SPEED, distance.z * SPEED)
	
	velocity = move_and_slide(velocity, Vector3.UP)
