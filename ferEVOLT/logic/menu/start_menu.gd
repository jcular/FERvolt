extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var main_menu_music = null

var loaded_scene = null

var player_color = {0:Color(0,1,0)}

func _set_color(color, player):
	player_color[player] = color

func _load_scene(scene, player):
	var tt = load(scene).instance()
	tt.color = player_color[player]
	tt.set_name("player_scene")
	loaded_scene.get_node("racing_scene/starting_positions/"+player).add_child(tt)
	

func _ready():
	if not is_hidden():
		hide()
		
	get_node("PlayerContainer/player_1/Label").set_text("Player 1:")
	get_node("PlayerContainer/player_2/Label").set_text("Player 2:")
	get_node("PlayerContainer/player_3/Label").set_text("Player 3:")
	get_node("PlayerContainer/player_4/Label").set_text("Player 4:")
	
	get_node("PlayerContainer/player_1/ColorPickerButton").connect("color_changed", self, "_on_color_change1")
	get_node("PlayerContainer/player_2/ColorPickerButton").connect("color_changed", self, "_on_color_change2")
	get_node("PlayerContainer/player_3/ColorPickerButton").connect("color_changed", self, "_on_color_change3")
	get_node("PlayerContainer/player_4/ColorPickerButton").connect("color_changed", self, "_on_color_change4")
	get_node("Buttons/start_game_button").connect("pressed", self, "_on_start_pressed")
	get_node("Buttons/back_button").connect("pressed", self, "_on_btnBack_pressed")

	main_menu_music = get_node("main_menu_music")
	main_menu_music.play("TryHard", true)
	
func _on_start_pressed():
	main_menu_music.stop_all()
	loaded_scene = load("res://scenes/racing_scene.tscn").instance()
	for player in get_node("PlayerContainer").get_children():
		if player.get_node("checkbox").is_pressed():
			_load_scene("res://scenes/player_scene/player_scene.tscn", player.get_name())
	get_parent().add_child(loaded_scene)
	hide()

func _on_color_change1(color):
	_set_color(color, "player_1")
	
func _on_color_change2(color):
	_set_color(color, "player_2")
	
func _on_color_change3(color):
	_set_color(color, "player_3")

func _on_color_change4(color):
	_set_color(color, "player_4")

func _on_btnBack_pressed():
	hide()
