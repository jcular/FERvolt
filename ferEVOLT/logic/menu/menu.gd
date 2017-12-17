extends Control

const NEXT_SCENE_PATH = "Your target path here."

onready var tree = get_tree()
onready var options = get_parent().get_node("Options")
onready var start_game = get_parent().get_node("StartGame")

func _ready():
	get_node("Buttons/start_button").connect("pressed", self, "_on_btnStart_pressed")
	get_node("Buttons/options_button").connect("pressed", self, "_on_btnOption_pressed")
	get_node("Buttons/quit_button").connect("pressed", self, "_on_btnQuit_pressed")

func _on_btnStart_pressed():
	start_game.show()

func _on_btnOption_pressed():
	options.show()

func _on_btnQuit_pressed():
	tree.quit()

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