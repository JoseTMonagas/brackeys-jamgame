extends KinematicBody

signal toggle_menu


const SPEED = 3.5

var direction = Vector3.ZERO
var velocity = Vector3.ZERO

#Change to lantern movement
#var is_lantern_pressed:bool = false


#owned orbs
var owned_orb_white = false
var owned_orb_blue = false
var owned_orb_green = false
var owned_orb_yellow = false
var owned_orb_pink = false


onready var camera = $Camera
onready var footstep_sfx = $Footsteps
onready var menu_cd = $MenuCD

var MOUSE_SENSITIVITY = 0.05 + Global.load_setting("MOUSE", "SENSITIVITY", 0) #Here's the bug that wouldn't allow you to change mosue sensitivity


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta):
	_handle_input()
	_resolve_movement(delta)
	if velocity.length() > 1:
		if !footstep_sfx.is_playing():
			footstep_sfx.play()
	else:
		footstep_sfx.stop()


func _handle_input():
	direction = Vector3.ZERO
	
	
	var y_input = int(Input.is_action_pressed("ui_up")) - int(Input.is_action_pressed("ui_down"))
	var x_input = int(Input.is_action_pressed("ui_left")) - int(Input.is_action_pressed("ui_right"))
	
	var is_lantern_pressed = Input.is_action_pressed("ui_focus_next")
	var cam_xform = camera.get_global_transform()
	
	
	direction += -cam_xform.basis.z * y_input
	direction += -cam_xform.basis.x * x_input
	direction = direction.normalized()
	
	if Input.is_action_pressed("ui_cancel") && menu_cd.is_stopped():
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		emit_signal("toggle_menu")
		menu_cd.start()


func _resolve_movement(_delta):
	velocity = Vector3(lerp(velocity.x, direction.x * SPEED, 0.2), -1, lerp(velocity.z, direction.z * SPEED, 0.2))
	velocity = move_and_slide_with_snap(velocity, Vector3.DOWN, Vector3.UP)


func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))


#check whether the player owns orbs to update monuments sprites and activate rewinds
func owns_orb(orb_number):
	match orb_number:
		"orb_white":
			owned_orb_white=true
		"orb_blue":
			owned_orb_blue=true
		"orb_green":
			owned_orb_green=true
		"orb_yellow":
			owned_orb_yellow=true
		"orb_pink":
			owned_orb_pink=true



