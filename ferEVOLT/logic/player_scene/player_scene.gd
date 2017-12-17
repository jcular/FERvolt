extends Spatial

func _load_car_scene(car):
	var tt = load(car).instance()
	tt.set_name("car_scene")
	get_node("vehiecle_position").add_child(tt)

func _ready():
	_load_car_scene("res://scenes/car_scenes/fast_car_scene.scn")
