extends Node

var rotate_back = []

func _process(delta):
	for i in rotate_back:
		if i.rotation > 0:
			i.rotation -= 0.003

		else:
			rotate_back.remove(rotate_back.find(i))

func reparent_node(node, new_parent):
	node.get_owner().remove_child(node)
	new_parent.add_child(node)

	node.set_owner(new_parent)

func get_child_of_class(node, class_):
	for n in node.get_children():
		if n.is_class(class_):
			return n

	return null

func rotation_impulse(rigid, head, tail, force):
	rigid.apply_impulse(head.get_position(), Vector2(-force, -force))
	rigid.apply_impulse(tail.get_position(), Vector2(force, force))

func rotation_spring(node, force):
	node.rotation = abs(sin(force))
	rotate_back.append(node)
