extends Sprite

func _process(delta):
	# var pos = get_viewport().get_mouse_position()
	# var screen_size = get_viewport().get_visible_rect().size

	# self.look_at(Vector2(screen_size.x - pos.x, screen_size.y - pos.y))

	rotation += deg2rad(fmod(rad2deg(get_local_mouse_position().angle() * 0.8) - (140 * sign(get_local_mouse_position().angle())), 360))
