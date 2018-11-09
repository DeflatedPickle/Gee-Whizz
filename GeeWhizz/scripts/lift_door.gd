extends Node

# enum Direction {
# 	UP = 1
# 	DOWN = -1
# }

# export(Direction) var direction
export(int, -1, 1) var direction
onready var direction_wrapper = direction

var collided = false

var step = 2
var fast_step = 4

var move_timer = 0
var move_timer_max = 5

var cooldown = 0
var cooldown_max = 30

onready var util = preload("res://scripts/util.gd").new()

onready var sprite = util.get_child_of_class(self, "Sprite")


func _process(delta):
	if cooldown == 0:
		if direction_wrapper == 1:
			if move_timer > 0:
				set_position(get_position() + Vector2(0, step))

				move_timer -= 1

			else:
				direction_wrapper = -1
				move_timer = move_timer_max
				cooldown = cooldown_max

		elif direction_wrapper == -1:
			if move_timer > 0:
				set_position(get_position() + Vector2(0, -step))

				move_timer -= 1

			else:
				direction_wrapper = 1
				move_timer = move_timer_max
				cooldown = cooldown_max

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
	cooldown = cooldown_max
	#move_timer = move_timer_max


func _on_Bottom_area_exited(area):
	collided = false


func _on_Top_area_entered(area):
	collided = true
	cooldown = cooldown_max
	#move_timer = move_timer_max


func _on_Top_area_exited(area):
	collided = false
