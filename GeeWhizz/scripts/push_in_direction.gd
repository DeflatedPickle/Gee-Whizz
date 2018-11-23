tool
extends Node

export(Vector2) var direction = Vector2(0, 0) setget set_direction
export(float) var speed = 0.5 setget set_speed
export(float) var sprite_rotation = 0.1 setget set_sprite_rotation

func _ready():
	self.apply_impulse(Vector2(0, 0), Vector2(direction.x * speed, direction.y * speed))

func _draw():
	if Engine.is_editor_hint():
		if direction != Vector2():
			draw_line(Vector2(), direction * Vector2(speed, speed), Color(255, 0, 0), 4.0)
			draw_circle(direction * Vector2(speed, speed), 10, Color(255, 0, 0))

			var sprite = self.get_node("Sprite")
			var size = sprite.texture.get_size()
			var scale = sprite.scale
			draw_set_transform((direction) * Vector2(speed, speed), sprite_rotation, scale)
			draw_texture(sprite.texture, Vector2(-(size.x) / 2, -(size.y) / 2), Color(1, 1, 1, 0.5))

func set_direction(value):
	direction = value

	update()

func set_speed(value):
	speed = value

	update()

func set_sprite_rotation(value):
	sprite_rotation = value

	if self.has_node("Sprite"):
		self.get_node("Sprite").rotation = sprite_rotation
		self.get_node("CollisionShape2D").rotation = sprite_rotation

	update()
