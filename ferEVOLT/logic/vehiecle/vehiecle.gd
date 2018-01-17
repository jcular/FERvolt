extends VehicleBody


# Member variables
const STEER_SPEED = 2
const STEER_LIMIT = 0.7

var steer_angle = 0
var steer_target = 0

const MAX_SPEED = 300

export var engine_force = 100

const player_controls = {
	"player_1":{"action_accel":"ui_up1", "action_brake":"space1", "action_reverse":"ui_down1", "action_left":"ui_left1", "action_right":"ui_right1"},
	"player_2":{"action_accel":"ui_up2", "action_brake":"space2", "action_reverse":"ui_down2", "action_left":"ui_left2", "action_right":"ui_right2"},
	"player_3":{"action_accel":"ui_up3", "action_brake":"space3", "action_reverse":"ui_down3", "action_left":"ui_left3", "action_right":"ui_right3"},
	"player_4":{"action_accel":"ui_up4", "action_brake":"space4", "action_reverse":"ui_down4", "action_left":"ui_left4", "action_right":"ui_right4"}
}

export var action_accel = "ui_up"
export var action_brake = "space"
export var action_reverse = "ui_down"
export var action_left = "ui_left"
export var action_right = "ui_right"

var forward = false
var pressed = false
var sample = null

func set_checkpoint(checkpoint_name):
	var player_scene = get_parent().get_parent().get_parent()
	player_scene.checkpoints[checkpoint_name] = true

func add_lap():
	var player_scene = get_parent().get_parent().get_parent()
	player_scene.check_lap()

func set_controls(player_name):
	if player_controls[player_name].size() == 5:
		action_accel = player_controls[player_name]["action_accel"]
		action_brake = player_controls[player_name]["action_brake"]
		action_reverse = player_controls[player_name]["action_reverse"]
		action_left = player_controls[player_name]["action_left"]
		action_right = player_controls[player_name]["action_right"]

func change_color(color):
	var mesh = get_node("real_curves")
	# Create a new FixedMaterial (for example)
	var new_material = FixedMaterial.new()
	
	# Assign it on the mesh as an override
	mesh.set_material_override(new_material)
	
	# Modify the material (it will be applied on all meshes you use it on, here only one)
	# Note: if you need a texture or other setup, you may want to set more params
	new_material.set_parameter(FixedMaterial.PARAM_DIFFUSE, color)
	

func _fixed_process(delta):
	if (Input.is_action_pressed(action_left)):
		steer_target = -STEER_LIMIT
	elif (Input.is_action_pressed(action_right)):
		steer_target = STEER_LIMIT
	else:
		steer_target = 0
	
	if (Input.is_action_pressed(action_accel)):
		if !pressed:
			get_node("music_node").stop_all()
			sample = get_node("music_node").get_sample_library().get_sample("sounds")
			sample.set_loop_format(sample.LOOP_FORWARD)
			sample.set_loop_begin(0)
			sample.set_loop_end(sample.get_length())
			get_node("music_node").play("sounds")
			pressed = true
		forward = false
			
		set_engine_force(min(engine_force + get_engine_force(), MAX_SPEED))
	else:
		set_engine_force(0)
	
	if (Input.is_action_pressed(action_reverse)):
		set_engine_force(-engine_force/2)
		if !forward:
			get_node("music_node").stop_all()
			sample = get_node("music_node").get_sample_library().get_sample("back")
			sample.set_loop_format(sample.LOOP_FORWARD)
			sample.set_loop_begin(0)
			sample.set_loop_end(sample.get_length())
			get_node("music_node").play("back")
			forward = true
		pressed = false	
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