extends Node

export(NodePath) var parent_path
onready var parent = self.get_node(parent_path)
