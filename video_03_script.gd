@tool

extends Node3D

var glitchy_cube_scene = preload("res://glitchy_cube.tscn")

@export var linear_speed = 5.0
@export var spins_per_step = 0.2
@export var steps = 0.3
@export var radius = 2.0

@export var min_glitch_cube_radius = 0.1
@export var max_glitch_cube_radius = 0.5

@export var queue_capacity = 500

var current_step = 0
var nodes_queue: Array[Node] = []

@onready var camera = $Camera3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_camera(camera, linear_speed, delta)
	catch_up_step()


func move_camera(camera: Camera3D, speed: float, delta: float):
	camera.position += Vector3.BACK * speed * delta

func catch_up_step():
	var steps_remainder = camera.position.z - current_step
	# if camera.position.z % steps >= current_step:
	
	if steps_remainder >= steps:
		current_step += steps
		add_step()
		return true
	else:
		return false


func add_step():
	prune_queue()
	
	var node = glitchy_cube_scene.instantiate()
	node.radius = randf_range(min_glitch_cube_radius, max_glitch_cube_radius)
	node.position = camera.position + Vector3.UP.rotated(Vector3.BACK, 2 * PI * current_step * spins_per_step) * radius

	nodes_queue.push_back(node)
	ToolCleaner.prepare(node)
	add_child(node)

func prune_queue():
	while len(nodes_queue) >= queue_capacity:
		print('freeing' + str(randi()))
		var node = nodes_queue.pop_front()
		node.queue_free()
