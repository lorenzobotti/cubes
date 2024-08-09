@tool

extends Node

func prepare(node: Node):
	node.name = rand_name()
	
	if Engine.is_editor_hint():
		node.owner = get_tree().edited_scene_root

func rand_name() -> String:
	return 'DELETEME' + str(randi())

func purge_auto_nodes(node: Node):
	for child in node.get_children():
		if child.name.contains('DELETEME'):
			child.queue_free()
