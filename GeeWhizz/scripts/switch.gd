tool
extends Node

export(Array) var activationNodes = []

onready var sprite = get_node("Handle")

var upRotation = 60
var downRotation = -60

var switch_it = false
var state = false

func _process(delta):
	if not Engine.is_editor_hint():
		if switch_it:
			if state == true:
				if sprite.rotation < upRotation:
					sprite.rotation += 1

			if state == false:
				if sprite.rotation > downRotation:
					sprite.rotation -= 1

		if state == true:
			if sprite.rotation == upRotation:
				for i in activationNodes:
					i.activate()
					switch_it = false

		if state == false:
			if sprite.rotation == downRotation:
				for i in activationNodes:
					i.deactivate()
					switch_it = false

func _draw():
	if Engine.is_editor_hint():
		for i in activationNodes:
			draw_line(Vector2(), self.get_node(i).get_position(), Color(0, 255, 0), 4.0)


func _on_Switch_area_entered(area):
	pass # replace with function body


func _on_Switch_area_exited(area):
	pass # replace with function body
