extends Node

onready var player = self.get_node("/root/World/Player")

onready var ammo = self.get_node("/root/World/HUD/LabelAmmo")

var tool_ = null

func _process(delta):
	if self.get_node("/root/World/Player/Body/Right Arm/Position2D").has_node("Tool"):
		tool_ = self.get_node("/root/World/Player/Body/Right Arm/Position2D/Tool")

		if tool_.tool_current_ammo != -1:
			ammo.text = "{current}/{total}".format({"current": tool_.tool_current_ammo, "total": tool_.tool_max_ammo})

		else:
			ammo.text = "Infinite"

	else:
		ammo.text = ""
