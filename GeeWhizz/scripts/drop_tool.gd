extends Node

onready var util = preload("res://scripts/util.gd").new()

var gun = ""

func _ready():
	set_process_input(true)

func _process(delta):
	if Input.is_key_pressed(KEY_D):
		var world = self.get_node("/root/World")
		var arm = self.get_node("/root/World/Player/Body/Right Arm/Position2D")

		if self.get_node("/root/World/Player/Body/Right Arm/Position2D").has_node("Tool"):
			var temp_gun = self.get_node("/root/World/Player/Body/Right Arm/Position2D/Tool")

			var position = temp_gun.get_global_position()
			var rotation = temp_gun.get_global_rotation()

			var gun_sprite = self.get_node("/root/World/Player/Body/Right Arm/Position2D/Tool/Sprite")

			gun = temp_gun

			var player = self.get_node("/root/World/Player")
			var right_arm = self.get_node("/root/World/Player/Body/Right Arm")
			var movement_position = self.get_node("/root/World/Player/Body/Right Arm/Position2D/Tool").get_global_position() - right_arm.get_global_position()

			gun.mode = 0
			gun.set_applied_torque(movement_position.x * 0.05)
			gun.apply_impulse(Vector2(0, 0), Vector2(movement_position.x * 0.5, movement_position.y * 0.5))

			player.apply_impulse(Vector2(0, 0), Vector2(-movement_position.x * 0.5, -movement_position.y * 0.5))
			util.rotation_impulse(player, self.get_node("/root/World/Player/Head Position"), self.get_node("/root/World/Player/Feet Position"), -movement_position.x * 0.5)

			arm.remove_child(gun)
			world.add_child(gun)

			gun.set_owner(world)

			gun.set_position(position)
			gun.set_rotation(rotation)

			gun_sprite.set_scale(Vector2(3.5, 3.5))
