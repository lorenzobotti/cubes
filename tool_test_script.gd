@tool

extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var child = MeshInstance3D.new()
	var box = BoxMesh.new()
	
	child.mesh = box
	self.add_child(child)
	
	if Engine.is_editor_hint():
		child.owner = get_tree().edited_scene_root

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
