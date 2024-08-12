extends Node3D

var buildings = []

var last_pressed_frame = 0

func _ready():
	for child in get_children():
		if child is ProcedBuilding:
			buildings.push_back(child)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var frame = Engine.get_frames_drawn()
	var how_many_since_last = frame - last_pressed_frame
	
	if Input.is_action_just_pressed("ui_accept", true) and how_many_since_last > 10:
		print("regen " + str(randi()))
		n_floors()


func n_floors():
	for building in buildings:
		building.height = randi_range(2, 6)
		building.new_floors()
