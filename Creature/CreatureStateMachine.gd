extends StateMachine



func _ready():
	add_state("chase")
	add_state("idle")
	call_deferred("set_state", states.idle)


func _state_logic(delta):
	parent._resolve_movement(delta)


func _get_transition(_delta):
	match current_state:
		states.idle:
			if parent.force_chase || parent.player_in_range || parent.rest_timer.is_stopped():
			  return states.chase
		states.chase:
			if parent.force_rest || !parent.player_in_range && parent.chase_timer.is_stopped():
				return states.idle
	return null


func _enter_state(new_state, _old_state):
	match new_state:
		states.idle:
			if parent.force_rest:
				parent.force_rest = false
			parent._start_rest()
		states.chase:
			if parent.force_chase:
				parent.force_chase = false
			parent._start_chase()
