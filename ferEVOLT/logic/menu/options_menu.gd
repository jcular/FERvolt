extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
func _ready():
	if not is_hidden():
		hide()
	get_node("Buttons/back_button").connect("pressed", self, "_on_btnBack_pressed")
	get_node("OptionContainter/SoundSlder").connect("value_changed", self, "_on_sound_slider_moved")

func _on_btnBack_pressed():
	hide()

func _on_sound_slider_moved(value):
	AudioServer.set_stream_global_volume_scale(value/100.0)
	AudioServer.set_fx_global_volume_scale(value/100.0)