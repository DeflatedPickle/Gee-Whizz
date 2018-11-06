extends Node

onready var util = preload("res://scripts/util.gd").new()

onready var the_tool = self.get_owner()

onready var player_hand = self.get_node("/root/World/Player/Body/Right Arm/Position2D")

func _ready():
	set_process_input(true)

func _process(delta):
	if not self.get_node("/root/World/Player/Body/Right Arm/Position2D/Tool"):
		var pos = self.get_global_position()
		var hand_pos = player_hand.get_global_position()

		var extents = self.shape.extents * 3

		var points = [Vector2(pos.x + extents.x, pos.y + extents.y), Vector2(pos.x - extents.x, pos.y - extents.y)]

		if hand_pos.x < points[0].x and hand_pos.x > points[1].x and hand_pos.y < points[0].y and hand_pos.y > points[1].y:
			if Input.is_mouse_button_pressed(BUTTON_RIGHT):
				util.reparent_node(the_tool, player_hand)

				the_tool.mode = 3
				the_tool.set_position(Vector2(0, 0))
				the_tool.set_rotation(0)

				util.get_child_of_class(the_tool, "Sprite").set_scale(Vector2(0.6, 0.6))

				the_tool.name = "Tool"

# func _draw():
# 	var pos = self.get_position()
#	var hand_pos = player_hand.get_position()

#	var extents = self.shape.extents * 3
#	draw_rect(Rect2(Vector2(pos.x + extents.x, pos.y + extents.y), Vector2(pos.x - extents.x, pos.y - extents.y)), Color(1.0,0.0,0.0))