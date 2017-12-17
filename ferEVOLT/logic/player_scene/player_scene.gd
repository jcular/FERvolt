extends Spatial

var current_player = 0

func _load_car_scene(car):
	var tt = load(car).instance()
	tt.set_name("car_scene")
	get_node("vehiecle_position").add_child(tt)

func _set_player(player):
	player = player

func _ready():
	set_process(true);
	_load_car_scene("res://scenes/car_scenes/lamba_purple.scn")

func _process(delta):
	get_node("Viewport/Camera").set_global_transform(get_node("Camera").get_global_transform());
