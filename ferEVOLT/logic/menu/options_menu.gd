extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
func _ready():
	if not is_hidden():
		hide()
	get_node("Buttons/back_button").connect("pressed", self, "_on_btnBack_pressed")

func _on_btnBack_pressed():
	hide()
