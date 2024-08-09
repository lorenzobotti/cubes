@tool

extends Node3D

@export var speed: float = 1.0
@export var radius: float = 4.0

var elapsed: float = 0
var cube: MeshInstance3D = null

func _ready():
	ToolCleaner.purge_auto_nodes(self)
	
	var mesh = BoxMesh.new()
	cube = MeshInstance3D.new()
	
	cube.mesh = mesh
	add_child(cube)
	
	ToolCleaner.prepare(cube)

var noise: FastNoiseLite = null
func get_texture():
	if noise:
		return noise
	
	noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_CELLULAR
	
	return noise

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	elapsed += delta
	
	cube.position = Vector3.UP.rotated(Vector3.RIGHT, 4 * PI * get_texture().get_noise_1d(elapsed * speed)) * radius
