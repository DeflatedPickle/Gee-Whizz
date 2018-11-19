extends Node

export(Array) var activationNodes = []

onready var sprite = get_node("Handle")

var upRotation = 60
var downRotation = -60

var state = false

func _process(delta):
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

	if state == false:
		if sprite.rotation == downRotation:
			for i in activationNodes:
				i.deactivate()
