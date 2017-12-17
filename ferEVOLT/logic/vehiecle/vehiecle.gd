extends VehicleBody


# Member variables
const STEER_SPEED = 0.5
const STEER_LIMIT = 0.4

var steer_angle = 0
var steer_target = 0

export var engine_force = 100

export var action_accel = "ui_up"
export var action_brake = "space"
export var action_reverse = "ui_down"
export var action_left = "ui_left"
export var action_right = "ui_right"

func _fixed_process(delta):
	if (Input.is_action_pressed(action_left)):
		steer_target = -STEER_LIMIT
	elif (Input.is_action_pressed(action_right)):
		steer_target = STEER_LIMIT
	else:
		steer_target = 0
	
	if (Input.is_action_pressed(action_accel)):
		set_engine_force(engine_force)
	else:
		set_engine_force(0)
	
	if (Input.is_action_pressed(action_reverse)):
		set_engine_force(-engine_force/2)
		
	if (Input.is_action_pressed(action_brake)):
		set_brake(1.0)
	else:
		set_brake(0.0)
	
	if (steer_target < steer_angle):
		steer_angle -= STEER_SPEED*delta
		if (steer_target > steer_angle):
			steer_angle = steer_target
	elif (steer_target > steer_angle):
		steer_angle += STEER_SPEED*delta
		if (steer_target < steer_angle):
			steer_angle = steer_target
	
	set_steering(steer_angle)


func _ready():
	set_fixed_process(true)