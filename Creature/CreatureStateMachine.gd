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
			if parent.player_in_range || parent.rest_timer.is_stopped():
			  return states.chase
		states.chase:
			if !parent.player_in_range && parent.chase_timer.is_stopped():
				return states.idle
	return null


func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			parent._start_rest()
		states.chase:
			parent._start_chase()
