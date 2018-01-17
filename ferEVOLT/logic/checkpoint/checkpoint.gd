extends Area

func _ready():
	self.connect("body_enter", self, "_checkpoint_entered")

func _checkpoint_entered(car):
	if (car extends VehicleBody):
		car.set_checkpoint(get_name())
		if get_name()=="cp1":
			car.add_lap()
	