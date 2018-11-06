extends Node

export(int) var shoot_cooldown = 30

export(int) var push_force = 0.8
export(int) var rotation_force = 0.6
export(int) var drop_force = 0.4

# -1 = Infinite
export(int) var tool_current_ammo = 10
export(int) var tool_max_ammo = 10

export(int) var bullet_speed = 480

export(int) var bullet_damage = 0