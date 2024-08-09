extends Node3D

var rotating_cube_scene = preload('res://rotating_cube.tscn')

@export var cubes_num: int = 30
@export var distance: float = 0.3

@export var plane_dist: float = 4.0
 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
