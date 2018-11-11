extends Node

# enum Direction {
# 	UP = 1
# 	DOWN = -1
# }

# export(Direction) var direction
export(int, -1, 1) var direction
onready var direction_wrapper = direction

var collided = false

var slow_step = 0.6
var fast_step = 1.2
var current_step = slow_step

var move_timer = 0
var move_timer_max = 12

var cooldown = 0
var cooldown_max = 80

onready var util = preload("res://scripts/util.gd").new()

onready var sprite = util.get_child_of_class(self, "Sprite")


func _process(delta):
	if cooldown == 0:
		if direction_wrapper == 1:
			if move_timer > 0:
				set_position(get_position() + Vector2(0, current_step))

				move_timer -= 1

			else:
				direction_wrapper = -1
				# move_timer = move_timer_max
				cooldown = cooldown_max

				if direction == 1:
					move_timer = move_timer_max
					current_step = slow_step

				elif direction == -1:
					move_timer = move_timer_max / 2
					current_step = fast_step

		elif direction_wrapper == -1:
			if move_timer > 0:
				set_position(get_position() + Vector2(0, -current_step))

				move_timer -= 1

			else:
				direction_wrapper = 1
				# move_timer = move_timer_max
				cooldown = cooldown_max

				if direction == 1:
					move_timer = move_timer_max / 2
					current_step = fast_step

				elif direction == -1:
					move_timer = move_timer_max
					current_step = slow_step

	else:
		cooldown -= 1

#	if cooldown == 0:
#		if not collided:
#			set_position(get_position() + Vector2(0, 5 * direction))
#
#		else:
#			set_position(get_position() + Vector2(0, -5 * direction))
#
#	else:
#		cooldown -= 1


func _on_Bottom_area_entered(area):
	collided = true

	if direction == 1 and direction_wrapper == -1:
		move_timer = move_timer_max

	elif direction == -1 and direction_wrapper == 1:
		move_timer = move_timer_max / 2
	#move_timer = move_timer_max


func _on_Bottom_area_exited(area):
	collided = false


func _on_Top_area_entered(area):
	collided = true

	if direction == 1 and direction_wrapper == -1:
		move_timer = move_timer_max / 2

	elif direction == -1 and direction_wrapper == 1:
		move_timer = move_timer_max
	#move_timer = move_timer_max


func _on_Top_area_exited(area):
	collided = false
