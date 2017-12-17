extends Spatial

var number_of_laps = 0
var player_number = 0
var color = Color(0, 1, 0)

func _load_car_scene(car, color):
	var tt = load(car).instance()
	tt.set_name("car_scene")
	tt.get_node("BODY")._change_color(color)
	get_node("vehiecle_position").add_child(tt)

func _ready():
	set_process(true);
	_load_car_scene("res://scenes/car_scenes/lamba_purple.scn", color)

func _process(delta):
	get_node("Viewport/Camera").set_global_transform(get_node("Camera").get_global_transform());
