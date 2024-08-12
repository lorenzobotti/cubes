extends Node

func get_node3d_aab(n: Node3D):
	var aabb = AABB()
	
	for child in n.get_children():
		if child is MeshInstance3D:
			var child_aabb = child.get_aabb()
			aabb = aabb.merge(child_aabb)
			
	return aabb
