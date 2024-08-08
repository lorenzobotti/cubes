extends Node3D

var rotating_cube_scene = preload('res://rotating_cube.tscn')

@export var cubes_num: int = 30
@export var distance: float = 0.3

@export var plane_dist: float = 4.0

func prepare_cubes(position: Vector3):
	for i in range(cubes_num):
		var cube = rotating_cube_scene.instantiate()
		cube.position = position + (Vector3.UP * distance * (cubes_num / 2.0 - i))
		add_child(cube)

# Called when the node enters the scene tree for the first time.
func _ready():	
	# prepare_cubes(Vector3.ZERO)
	prepare_cubes(Vector3.BACK * plane_dist + Vector3.LEFT * 8)
	prepare_cubes(Vector3.BACK * plane_dist + Vector3.RIGHT * 8)
	prepare_cubes(Vector3.BACK * plane_dist)

	prepare_cubes(Vector3.BACK * plane_dist / 2 + Vector3.LEFT * 3)
	prepare_cubes(Vector3.BACK * plane_dist / 2 + Vector3.RIGHT * 3)
	prepare_cubes(Vector3.BACK * plane_dist / 2)
	
	prepare_cubes(Vector3.ZERO)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
