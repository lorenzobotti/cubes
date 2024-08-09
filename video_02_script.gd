extends Node3D

var column_scene = preload("res://cube_column.tscn")

@export var linear_speed = 16.0
@export var rotation_speed = 0
@export var steps = 2.0
@export var side_dist = 5.0

@export var queue_capacity = 500

var current_step = 0
var nodes_queue: Array[CubeColumn] = []

@onready var camera = $Camera3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera.position += Vector3.BACK * linear_speed * delta
	# camera.rotation += Vector3.BACK.rotated(Vector3.RIGHT, PI * rotation_speed) * delta

	while catch_up_step():
		pass

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
	nodes_queue.push_back(new_cube_column(Vector3.BACK * current_step + Vector3.LEFT * side_dist))
	nodes_queue.push_back(new_cube_column(Vector3.BACK * current_step + Vector3.RIGHT * side_dist))


func prune_queue():
	while len(nodes_queue) >= queue_capacity:
		print('freeing' + str(randi()))
		var node = nodes_queue.pop_front()
		node.queue_free()

func new_cube_column(pos: Vector3) -> CubeColumn:
	var col = column_scene.instantiate()
	col.position = pos
	
	col.min_radius = 0.3
	col.max_radius = 1.0

	col.cubes_num = 10


	add_child(col)
	
	return col
