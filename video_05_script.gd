@tool

extends Node3D

var buildings = []
var last_pressed_frame = 0
var noise: FastNoiseLite = null

@export var rows: int = 30
@export var lanes: int = 30

@export var rows_distance: float = 2.2
@export var lanes_distance: float = 2.2
@export var diagonal_rows_height: float = 0.3
@export var diagonal_lanes_height: float = 0.3

@export var scene: PackedScene = preload("res://proced_building.tscn")

@export var max_height: int = 6
@export var min_height: int = 2
@export var noise_scale: float = 1.0

@export var light_rotation_speed: float = 0.02
@onready var light: DirectionalLight3D = $DirectionalLight3D

func _ready():
	$AnimationPlayer.play("camera_pan")
	
	ToolCleaner.purge_auto_nodes(self)
	
	noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.seed = 30
	
	spawn_buildings()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not Engine.is_editor_hint():
		light.rotation.y = light.rotation.y + delta * light_rotation_speed * 2 * PI
	
	var frame = Engine.get_frames_drawn()
	var how_many_since_last = frame - last_pressed_frame
	
	if Input.is_action_just_pressed("ui_accept", true) and how_many_since_last > 10:
		print("regen " + str(randi()))
		n_floors()


func n_floors():
	noise.seed = randi()
	
	for row_i in range(buildings.size()):
		var row = buildings[row_i]
		
		for lane_i in range(row.size()):
			var build = row[lane_i]
			
			var height = get_height(row_i, lane_i)
			build.height = height
			
			build.position = Vector3((rows - row_i - 1) * rows_distance * -1, 0, (lanes - lane_i - 1) * lanes_distance * -1)
			
			build.new_floors()

func get_height(row: int, lane: int) -> float:
	var height = noise.get_noise_2d(row * noise_scale, lane * noise_scale)
	print(height)
	
	height = int(remap(height, -1, 1, min_height, max_height))
	print(height)
	
	return height
	

func spawn_buildings():
	for row in range(rows):
		var row_scenes = []
		
		for lane in range(lanes):
			var build = scene.instantiate()
			
			build.position.y += (row * diagonal_rows_height) + (lane * diagonal_lanes_height)
			build.height = get_height(row, lane)
			
			ToolCleaner.prepare(build)
			row_scenes.push_back(build)
			add_child(build)
		
		buildings.push_back(row_scenes)
