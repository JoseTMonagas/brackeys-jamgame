extends KinematicBody

const SPEED = 9.8
const REST_TIME = {
	"MIN": 30,
	"MAX": 60
}

const CHASE_TIME = {
	"MIN": 30,
	"MAX": 60
}
const DEVOURED_SCENE = "res://Animations/Devoured.tscn"

export (NodePath) var player_path

var direction = Vector3.ZERO
var velocity = Vector3.ZERO
var player = null
var player_in_range = false
var is_chasing = false

onready var rest_timer = $RestTimer
onready var chase_timer = $ChaseTimer


func _ready():
	player = get_node(player_path)


func _get_player_distance():
	var player_position = player.global_transform.origin
	var self_position = global_transform.origin
	return (self_position - player_position).normalized() * -1


func _resolve_movement(delta):
	if is_chasing:
	  var distance = _get_player_distance()
	  velocity = Vector3(distance.x * SPEED, distance.y * SPEED, distance.z * SPEED)
	  velocity = move_and_slide(velocity, Vector3.UP)
	else:
		velocity = Vector3.ZERO


func _start_rest():
	is_chasing = false
	var time = randi() % REST_TIME.MAX + REST_TIME.MIN
	rest_timer.start(time)


func _start_chase():
	is_chasing = true
	var time = randi() % CHASE_TIME.MAX + CHASE_TIME.MIN
	chase_timer.start(time)
	


func _on_DetectionArea_body_entered(body):
	player_in_range = true


func _on_DetectionArea_body_exited(body):
	player_in_range = false


func _on_AttackArea_body_entered(body):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene(DEVOURED_SCENE)
