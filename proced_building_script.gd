@tool

extends Node3D
class_name ProcedBuilding

@export var block_size: Vector3 = Vector3(1, 0.62, 1)
@export var floor_size: Vector3 = Vector3(1, 0.75, 1)

@export var entrances: Array[PackedScene] = []
@export var middles: Array[PackedScene] = []
@export var roofs: Array[PackedScene] = []

@export var height: int = 3

var nodes: Array[Node] = []
var debug = false

func generate_floors() -> Array[PackedScene]:
	dbg('generate')
	
	if height < 2:
		height = 2
	
	var how_many_middles = height - 2
	
	# TODO: seed
	var floors: Array[PackedScene] = []
	
	var ground_floor = entrances.pick_random()
	floors.push_back(ground_floor)
	dbg('ground')
	
	for i in range(how_many_middles):
		var floor = middles.pick_random()
		floors.push_back(floor)
		
		dbg('middle')
	
	var roof_floor = roofs.pick_random()
	floors.push_back(roof_floor)
	dbg('roof')
	
	return floors

func materialize_floors(floors: Array[PackedScene]):
	dbg('materialize')
	
	var block_height = block_size.z
	var height_reached = 0
	
	for i in range(floors.size()):
		var floor = floors[i]
		var size_vec = floor_size if i == 0 else block_size
		
		var scene: Node3D = floor.instantiate()
		dbg('instantiate ' + str(i))
		
		scene.position.y += height_reached
		height_reached += size_vec.y
		
		# var building_aabb = Utils.get_node3d_aab()
		ToolCleaner.prepare(scene)
		add_child(scene)
		nodes.push_back(scene)

func dbg(s):
	if not debug:
		return
	
	print(self.name + " -> " + s)
	
func dbg_name():
	## print(self.name)
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	ToolCleaner.purge_auto_nodes(self)
	# new_floors()

func new_floors():
	dbg_name()
	dbg('new floors')
	
	clean()
	
	var floors = generate_floors()
	materialize_floors(floors)
	
func clean():
	ToolCleaner.purge_auto_nodes(self)
	
	for n in nodes:
		n.queue_free()
	
	nodes = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
