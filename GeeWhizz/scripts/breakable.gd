extends Node

export(float) var health = 6

func _process(delta):
	for b in self.get_colliding_bodies():
		if "Bullet" in b.name:
			if self.health - b.parent.bullet_damage > 0:
				self.health -= b.parent.bullet_damage

			else:
				self.queue_free()

			b.queue_free()
