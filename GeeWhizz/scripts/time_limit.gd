extends Node

export(int) var time_limit = 30

var counter = 0
var counter_max = 60

func _process(delta):
	if time_limit != -1:
		if counter == 60:
			counter = 0

			time_limit -= 1

		else:
			counter += 1

		if time_limit == 0:
			# Some death animation
			pass
