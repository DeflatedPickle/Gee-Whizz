extends Node

func reparent_node(node, new_parent):
	node.get_owner().remove_child(node)
	new_parent.add_child(node)

	node.set_owner(new_parent)

func get_child_of_class(node, class_):
	for n in node.get_children():
		if n.is_class(class_):
			return n

	return null
