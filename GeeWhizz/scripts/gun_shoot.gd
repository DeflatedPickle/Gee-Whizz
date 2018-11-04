extends Node

var bullet_scene = load("res://scenes/Bullet.tscn")

var bullet_cooldown = 0
var bullet_cooldown_max = 30

var bullet_count = 0

var movement_position = Vector2(0, 0)

onready var window_size = get_viewport().get_visible_rect().size

onready var player = self.get_node("/root/World/Player")
onready var player_head = self.get_node("/root/World/Player/Body/Head")
onready var player_pack = self.get_node("/root/World/Player/Body/Space Pack")

var rotate_back = []

func _ready():
	set_process_input(true)

func _process(delta):
	if bullet_cooldown == 0:
		if self.get_node("../../").name == "Right Arm":
			if Input.is_mouse_button_pressed(BUTTON_LEFT):
				create_bullet()

				player.apply_impulse(Vector2(0, 0), Vector2(-movement_position.x * 0.8, -movement_position.y * 0.8))
				rotation_impulse(player, self.get_node("/root/World/Player/Head Position"), self.get_node("/root/World/Player/Feet Position"), movement_position.x * 0.6)

				rotation_spring(player_head, movement_position.x * 0.005)
				rotation_spring(player_pack, movement_position.x * 0.002)

				bullet_cooldown = bullet_cooldown_max
				bullet_count += 1

	else:
		bullet_cooldown -= 1

	for i in rotate_back:
		if i.rotation > 0:
			i.rotation -= 0.003

		else:
			rotate_back.remove(rotate_back.find(i))

func rotation_impulse(rigid, head, tail, force):
	player.apply_impulse(head.get_position(), Vector2(-force, -force))
	player.apply_impulse(tail.get_position(), Vector2(force, force))

func rotation_spring(node, force):
	node.rotation = abs(sin(force))
	rotate_back.append(node)

func create_bullet():
	var bullet_instance = bullet_scene.instance()
	bullet_instance.set_name("Bullet{count}".format({"count": bullet_count}))

	var right_arm = self.get_node("/root/World/Player/Body/Right Arm")
	var gun_point = self.get_node("/root/World/Player/Body/Right Arm/Tool/Position2D")
	var gun_point_position = gun_point.get_global_position()
	var gun_position_rotated = gun_point_position.rotated(gun_point.get_rotation())
	bullet_instance.set_position(gun_point_position)

	bullet_instance.set_rotation(right_arm.get_global_rotation())

	movement_position = gun_point_position - right_arm.get_global_position()
	bullet_instance.apply_impulse(Vector2(0, 0), Vector2(6 * movement_position.x, 6 * movement_position.y))

	self.get_node("/root/World").add_child(bullet_instance)