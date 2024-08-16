@tool

extends Node3D

@export var noise: FastNoiseLite = null
var backup_noise: FastNoiseLite = null

@export var map_to: NodePath
@export var map_property: EditorProperty

func get_noise():
	if noise:
		return noise
	
	if backup_noise:
		return backup_noise
		
	backup_noise = FastNoiseLite.new()
	backup_noise.type = FastNoiseLite.TYPE_SIMPLEX
	
	return backup_noise

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
