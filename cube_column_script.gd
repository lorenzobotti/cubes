@tool

class_name CubeColumn
extends Node3D

var rotating_cube_scene = preload('res://rotating_cube.tscn')
var ticker_scene = preload("res://random_ticker.tscn")

@export var cubes_num: int = 1
@export var distance: float = 0.9

@export var max_radius: float = 2.0
@export var min_radius: float = 0.8

@export var min_time: float = 0.6
@export var max_time: float = 1.2



var cubes: Array[MeshInstance3D] = []
var radiuses: Array[float] = []


var box_mesh = BoxMesh.new()

func prepare_cubes(position: Vector3):
	for i in range(cubes_num):
		var cube = MeshInstance3D.new()
		cube.mesh = box_mesh
		cube.position = position + (Vector3.UP * distance * (cubes_num / 2.0 - i))
		cube.name = rand_name()
		
		add_child(cube)
		cubes.push_back(cube)
		var radius = randfn(min_radius, max_radius)
		radiuses.push_back(radius)
		
		var timer: Timer = Timer.new()
		timer.name = rand_name()
		timer.wait_time = randf_range(min_time, max_time)

		# var handler = rotate_cube.bind(i)
		var handler = func rotate():
			rotate_cube(i)
		
		timer.timeout.connect(handler)
		
		add_child(timer)
		timer.start()
		
		if Engine.is_editor_hint():
			cube.owner = get_tree().edited_scene_root
			timer.owner = get_tree().edited_scene_root


func index_position(i: int) -> Vector3:
	return Vector3.UP * distance * (cubes_num / 2.0 - i)

func rotate_cube(index: int):
	var cube = cubes[index]
	var radius = radiuses[index]

	var start_pos = index_position(index)
	
	var rand_angle = randf_range(0, 2 * PI)
	var rotated = Vector3.BACK.rotated(Vector3.UP, rand_angle)
	var rotated_pos = start_pos + (rotated * radius)

	cube.position = rotated_pos
	
	
func rand_name() -> String:
	return 'DELETEME' + str(randi())

# Called when the node enters the scene tree for the first time.
func _ready():
	purge_auto_nodes()
	prepare_cubes(self.position)

func purge_auto_nodes():
	for child in get_children():
		if child.name.contains('DELETEME'):
			child.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
