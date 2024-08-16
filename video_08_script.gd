extends Node3D

@onready var donut: MeshInstance3D = $Donut
@onready var plane: MeshInstance3D = $Plane

var donuts: Array[MeshInstance3D] = []

const how_many_donuts = 10
const donuts_distance = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	donut = $Donut
	
	for i in how_many_donuts:
		var don = donut.duplicate()
		don.position.y += i * donuts_distance
		add_child(don)
		donuts.push_back(don)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
