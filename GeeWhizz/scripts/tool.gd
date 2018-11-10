extends Node

export(float) var shoot_cooldown = 3

export(float) var push_force = 0.8
export(float) var rotation_force = 0.6
export(float) var drop_force = 0.4

export(float) var head_kickback_force = 0.005
export(float) var pack_kickback_force = 0.002

# -1 = Infinite
export(int) var tool_current_ammo = 10
export(int) var tool_max_ammo = 10

export(float) var bullet_speed = 0.48

export(int) var bullet_damage = 0
