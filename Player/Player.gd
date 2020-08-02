extends KinematicBody


const SPEED = 10

var direction = Vector3.ZERO
var velocity = Vector3.ZERO

onready var camera = $Camera

var MOUSE_SENSITIVITY = 0.05

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	_handle_input()
	_resolve_movement(delta)


func _handle_input():
	direction = Vector3.ZERO
	var cam_xform = camera.get_global_transform()
	
	var y_input = int(Input.is_action_pressed("ui_up")) - int(Input.is_action_pressed("ui_down"))
	var x_input = int(Input.is_action_pressed("ui_left")) - int(Input.is_action_pressed("ui_right"))
	
	direction += -cam_xform.basis.z * y_input
	direction += -cam_xform.basis.x * x_input
	direction = direction.normalized()


func _resolve_movement(delta):
	velocity = Vector3(lerp(velocity.x, direction.x * SPEED, 0.2), -1, lerp(velocity.z, direction.z * SPEED, 0.2))
	velocity = move_and_slide_with_snap(velocity, Vector3.DOWN, Vector3.UP)


func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))
	
	if event is InputEvent and Input.is_action_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
