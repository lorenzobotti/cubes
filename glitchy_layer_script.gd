@tool

extends CanvasLayer

var lines: Array[Node2D] = []
var squarey = preload("res://squarey.tscn")

@export var how_many_lines: int = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	create()
	recalc()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.get_frames_drawn() % 10 == 0:
		every_few_frames()
	
func every_few_frames():
	recalc_one(randi_range(0, lines.size() - 1))

func create():
	for i in range(how_many_lines):
		var sq = squarey.instantiate()
		
		lines.push_back(sq)
		add_child(sq)
	
func recalc():
	for i in range(lines.size()):
		recalc_one(i)

func recalc_one(i: int):
	var size = random_cosino()
	var sq = lines[i]
	
	sq.position = size[0]
	sq.width = size[1].x
	sq.height = size[1].y
	

func random_cosino() -> Array[Vector2]:
	var pt = random_screen_point()
	var w = randi_range(0, get_viewport().get_visible_rect().size.x - pt.x)
	var h = randi_range(0, get_viewport().get_visible_rect().size.y - pt.y)
	
	return [pt, Vector2(w, h)]

func random_screen_point() -> Vector2:
	var x = randi_range(0, get_viewport().get_visible_rect().size.x)
	var y = randi_range(0, get_viewport().get_visible_rect().size.y)
	
	
	return Vector2(x, y)
