extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var loaded_scene = null

func _load_scene(scene):
	var tt = load(scene).instance()
	tt.set_name("player_scene")
	loaded_scene = load("res://scenes/racing_scene.tscn").instance()
	loaded_scene.get_node("racing_scene/starting_positions/player_pos_1").add_child(tt)
	tt = load(scene).instance()
	tt.set_name("player_scene")
	loaded_scene.get_node("racing_scene/starting_positions/player_pos_2").add_child(tt)
	tt = load(scene).instance()
	tt.set_name("player_scene")
	loaded_scene.get_node("racing_scene/starting_positions/player_pos_3").add_child(tt)
	get_parent().add_child(loaded_scene)
	hide()

func _on_start_pressed():
	_load_scene("res://scenes/player_scene/player_scene.tscn")