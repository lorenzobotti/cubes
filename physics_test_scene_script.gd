@tool

extends Node3D

@onready var area_node = $Boost1
@onready var camera = $Camera3D
@onready var ball_node = $Ball1

var camera_vs_ball = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	ViewporterScript.enabled = false
	ToolCleaner.purge_auto_nodes(self)
	create_collider()
	area_node.body_entered.connect(_on_body_entered)
	
	area_node = $Boost1
	camera = $Camera3D
	ball_node = $Ball1
	
	camera_vs_ball = ball_node.position - camera.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera.position = ball_node.position - camera_vs_ball

func _on_body_entered(body: Node3D):
	if not body.name.begins_with("Ball"):
		return
	
	if not (body is RigidBody3D):
		return
	
	var ball: RigidBody3D = body
	ball.apply_central_force(Vector3.BACK * 5.0)
	
func create_collider():
	var stat = StaticBody3D.new()
	add_child(stat)
	ToolCleaner.prepare(stat)
	
	for child in get_children():
		for grandchild in child.get_children():
			if grandchild.name == 'notmelol':
				continue
			
			if not (grandchild is MeshInstance3D):
				continue
			
			var shape = turn_to_collision(grandchild)
			
			shape.position += child.position
			shape.rotation += child.rotation
			
			stat.add_child(shape)
			ToolCleaner.prepare(shape)
			
			print_debug(stat)

func turn_to_collision(mesh: MeshInstance3D) -> CollisionShape3D:
	var collision_shape = CollisionShape3D.new()
	
	collision_shape.shape = mesh.mesh.create_trimesh_shape()
	
	collision_shape.position = mesh.position
	collision_shape.rotation = mesh.rotation
	
	print_debug(collision_shape)
	
	return collision_shape
