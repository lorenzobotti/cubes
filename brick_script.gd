@tool

extends Node3D

var b_x: int = 2
var b_y: int = 2

@export var x_bricks: int = 2:
	get:
		return b_x
	set(v):
		b_x = v
		find_mesh()

@export var y_bricks: int = 2:
	get:
		return b_y
	set(v):
		b_y = v
		find_mesh()


# Called when the node enters the scene tree for the first time.
func _ready():
	find_mesh()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func find_mesh():
	var name = 'bevel-hq-brick-' + str(b_x) + 'x' + str(b_y)
	print(name)
	
	for child: Node in get_children():
		if child.name.contains('bevel-hq'):
			child.visible = false
		
		if child.name.contains(name):
			child.visible = false
