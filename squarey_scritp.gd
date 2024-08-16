@tool

extends Node2D

var lines: Array[Line2D] = []

enum {
	TOP,
	BOTTOM,
	LEFT,
	RIGHT,
	DIAG_TL,
	DIAG_BL,
}

var w = 100
var h = 100

@export var thickness: float = 1.0
@export var width: int:
	set(v):
		w = v
		recalc()
	get:
		return w

@export var height: int:
	set(v):
		h = v
		recalc()
	get:
		return h

# Called when the node enters the scene tree for the first time.
func _ready():
	create_lines()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func line_points(w, h):
	return [
		[Vector2(0, 0), Vector2(w, 0)],
		[Vector2(0, h), Vector2(w, h)],
		[Vector2(0, 0), Vector2(0, h)],
		[Vector2(w, 0), Vector2(w, h)],
		[Vector2(w, 0), Vector2(0, h)],
		[Vector2(0, h), Vector2(w, 0)],
	]
	
func create_lines():
	var line_pts = line_points(w, h)
	
	for points in line_pts:
		var line = Line2D.new()
		line.points = points
		lines.push_back(line)
		add_child(line)
		

func recalc():
	if lines.size() == 0:
		return
		
	var line_pts = line_points(w, h)
	
	for i in line_pts.size():
		var points = line_pts[i]
		lines[i].points = points
		lines[i].width = thickness
