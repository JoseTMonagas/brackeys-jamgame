extends KinematicBody

export var SPEED = 3
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
var force_chase = false
var force_rest = false

onready var rest_timer = $RestTimer
onready var chase_timer = $ChaseTimer
onready var swarm_sfx = $Approaching


func _ready():
	player = get_node(player_path)


func _get_player_distance():
	var player_position = player.global_transform.origin
	var self_position = global_transform.origin
	return (self_position - player_position).normalized() * -1


func _resolve_movement(_delta):
	if is_chasing:
	  var distance = _get_player_distance()
	  velocity = Vector3(distance.x * SPEED, distance.y * SPEED, distance.z * SPEED)
	  velocity = move_and_slide(velocity, Vector3.UP)
	else:
		velocity = Vector3.ZERO


func _start_rest():
	if !chase_timer.is_stopped():
		chase_timer.stop()
	is_chasing = false
	visible = false
	if swarm_sfx.playing:
		swarm_sfx.play()
	var time = randi() % REST_TIME.MAX + REST_TIME.MIN
	rest_timer.start(time)


func _start_chase():
	if !rest_timer.is_stopped():
		rest_timer.stop()
	visible = true
	is_chasing = true
	if !swarm_sfx.playing:
		swarm_sfx.play()
	var time = randi() % CHASE_TIME.MAX + CHASE_TIME.MIN
	chase_timer.start(time)
	


func _on_DetectionArea_body_entered(body):
	if body.name == "Player":
		player_in_range = true


func _on_DetectionArea_body_exited(body):
	if body.name == "Player":
		player_in_range = false


func _on_AttackArea_body_entered(_body):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene(DEVOURED_SCENE)
