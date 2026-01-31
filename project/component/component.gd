class_name Component
extends Node


static func find(parent: Node, component_class: String) -> Node:
	if not component_class.ends_with("Component"):
		component_class += "Component"

	var components: Array[Node] = parent.find_children("*", component_class)

	assert(components.size() <= 1, "Can only have one component of each type!")

	if components.size() == 1:
		return components[0]

	return null
