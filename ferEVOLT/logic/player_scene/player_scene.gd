extends Spatial

var number_of_laps = 3
var player_number = 0
var color = Color(0, 1, 0)
var controls = {}
var checkpoints = {}
var number_of_checkpoints = 4
var lap = 0

func check_lap():
	var counter = 0
	for k in checkpoints:
		if checkpoints[k]:
			counter += 1
	if counter == number_of_checkpoints:
		lap += 1
		for k in checkpoints.keys():
			checkpoints[k] = false
		
func _load_car_scene(car, color, controls):
	var tt = load(car).instance()
	tt.set_name("car_scene")
	var car = tt.get_node("BODY")
	car.change_color(color)
	car.set_controls(controls)
	get_node("vehiecle_position").add_child(tt)

func _ready():
	set_process(true);
	_load_car_scene("res://scenes/car_scenes/lamba_purple.scn", color, controls)

func _process(delta):
	get_node("Viewport/Camera").set_global_transform(get_node("Camera").get_global_transform());
