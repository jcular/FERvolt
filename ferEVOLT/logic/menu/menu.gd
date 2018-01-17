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