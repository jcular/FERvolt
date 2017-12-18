extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var main_menu_music = null

var loaded_scene = null

var player_color = {0:Color(0,1,0)}

func _set_color(color, player):
	player_color[player] = color

func _load_scene(scene):
	var tt = load(scene).instance()
	tt.color = player_color[0]
	tt.set_name("player_scene")
	loaded_scene = load("res://scenes/racing_scene.tscn").instance()
	loaded_scene.get_node("racing_scene/starting_positions/player_pos_1").add_child(tt)
	tt = load(scene).instance()
	tt.color = Color(1,1,0)
	tt.controls["action_accel"] = "ui_up2"
	tt.controls["action_brake"] = "space"
	tt.controls["action_reverse"] = "ui_down2"
	tt.controls["action_left"] = "ui_left2"
	tt.controls["action_right"] = "ui_right2"
	tt.set_name("player_scene")
	loaded_scene.get_node("racing_scene/starting_positions/player_pos_2").add_child(tt)
	get_parent().add_child(loaded_scene)
	hide()

func _ready():
	if not is_hidden():
		hide()
	get_node("PlayerContainer/HBoxContainer/ColorPickerButton").connect("color_changed", self, "_on_color_change")
	get_node("Buttons/start_game_button").connect("pressed", self, "_on_start_pressed")
	get_node("Buttons/back_button").connect("pressed", self, "_on_btnBack_pressed")

	main_menu_music = get_node("main_menu_music")
	main_menu_music.play("TryHard", true)
	
func _on_start_pressed():
	main_menu_music.stop_all()
	_load_scene("res://scenes/player_scene/player_scene.tscn")

func _on_color_change(color):
	_set_color(color, 0)

func _on_btnBack_pressed():
	hide()
