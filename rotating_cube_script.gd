@tool

extends Node3D

@onready var mesh_node: MeshInstance3D = $MeshInstance3D
@onready var ticker_node: RandomTicker = $RandomTicker

@export var distance: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	ticker_node.start_timer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func rearrange():
	var random_angle = randi_range(0, 360)
	var angle = Vector3.LEFT.rotated(Vector3.UP, random_angle)
	
	mesh_node.position = self.position + angle * self.distance

func _on_random_ticker_timeout():
	rearrange()
