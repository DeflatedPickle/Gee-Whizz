extends Node

onready var util = preload("res://scripts/util.gd").new()

var bullet_scene = load("res://scenes/Bullet.tscn")

var bullet_cooldown = 0
# var bullet_cooldown_max = 30

var bullet_count = 0

var movement_position = Vector2(0, 0)

onready var window_size = get_viewport().get_visible_rect().size

onready var player = self.get_node("/root/World/Player")
onready var player_head = self.get_node("/root/World/Player/Body/Head")
onready var player_pack = self.get_node("/root/World/Player/Body/Space Pack")

func _ready():
	set_process_input(true)

func _process(delta):
	if self.get_node("/root/World/Player/Body/Right Arm/Position2D").has_node("Tool"):
		var tool_ = self.get_node("/root/World/Player/Body/Right Arm/Position2D/Tool")

		if tool_.tool_current_ammo > 0 or tool_.tool_max_ammo == -1:
			if bullet_cooldown <= 0:
				if self.get_node("../../../").name == "Right Arm":
					if Input.is_mouse_button_pressed(BUTTON_LEFT):
						create_bullet()

						player.apply_impulse(Vector2(0, 0), Vector2(-movement_position.x * tool_.push_force, -movement_position.y * tool_.push_force))
						util.rotation_impulse(player, self.get_node("/root/World/Player/Head Position"), self.get_node("/root/World/Player/Feet Position"), movement_position.x * tool_.push_force)

						util.rotation_spring(player_head, movement_position.x * tool_.head_kickback_force)
						util.rotation_spring(player_pack, movement_position.x * tool_.pack_kickback_force)

						bullet_cooldown = tool_.shoot_cooldown
						bullet_count += 1

						if tool_.tool_max_ammo != -1:
							tool_.tool_current_ammo -= 1

			else:
				bullet_cooldown -= 0.1

func create_bullet():
	var tool_ = self.get_node("/root/World/Player/Body/Right Arm/Position2D/Tool")

	var bullet_instance = bullet_scene.instance()
	bullet_instance.set_name("Bullet{count}".format({"count": bullet_count}))

	bullet_instance.parent_path = @"/root/World/Player/Body/Right Arm/Position2D/Tool"

	var right_arm = self.get_node("/root/World/Player/Body/Right Arm")
	var gun_point = self.get_node("/root/World/Player/Body/Right Arm/Position2D/Tool/Sprite/Position2D")
	var gun_point_position = gun_point.get_global_position()
	var gun_position_rotated = gun_point_position.rotated(gun_point.get_rotation())
	bullet_instance.set_position(gun_point_position)

	bullet_instance.set_rotation(tool_.get_global_rotation())

	movement_position = gun_point_position - right_arm.get_global_position()

	var mouse_position = get_global_mouse_position() - self.get_global_position()
	bullet_instance.apply_impulse(Vector2(), mouse_position * tool_.bullet_speed)

	self.get_node("/root/World").add_child(bullet_instance)
