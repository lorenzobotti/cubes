@tool

extends Node3D

var rotating_cube_scene = preload('res://rotating_cube.tscn')
var ticker_scene = preload("res://random_ticker.tscn")

@export var cubes_num: int = 30
@export var distance: float = 0.3

var cubes: Array[MultiMeshInstance3D] = []
var box_mesh = BoxMesh.new()

func prepare_cubes(position: Vector3):
	for i in range(cubes_num):
		var cube = MeshInstance3D.new()
		cube.mesh = box_mesh
		cube.position = position + (Vector3.UP * distance * (cubes_num / 2.0 - i))
		cube.name = rand_name()
		
		add_child(cube)
		cubes.append(cube)
		
		var timer: RandomTicker = ticker_scene.instantiate()
		timer.name = rand_name()
		var handler = func h():
			rotate_cube(i)
		timer.timeout.connect(handler)
		
		add_child(timer)
		
		if Engine.is_editor_hint():
			cube.owner = get_tree().edited_scene_root
			timer.owner = get_tree().edited_scene_root

func rotate_cube(index: int):
	pass
	
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
