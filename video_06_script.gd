@tool

extends Node3D

var lines: int = 10
var fields: int = 10

var fields_dist: float = 0.1
var line_height: float = 0.1
var font_size: float = 40.0

var texts = []

func _ready():
	ViewporterScript.enabled = false
	ToolCleaner.purge_auto_nodes(self)
	
	testo()
	populate()
	
	var timer = get_tree().create_timer(0.5)
	timer.timeout.connect(testo)
	
func purge():
	for m in texts:
		for n in m:
			n.queue_free()
	
	texts = []

var m: TextMesh = null

func populate():
	var ma = StandardMaterial3D.new()
	ma.albedo_color = Color('FF0000')
	
	m.material = ma
	
	for field in range(fields):
		var l = []
		
		for line in range(lines):
			var mi = MeshInstance3D.new()
			

			
			mi.mesh = m
			mi.position = Vector3(0, line * line_height, field * fields_dist)
			
			add_child(mi)
			l.push_back(mi)
			# ToolCleaner.prepare(mi)
		
		texts.push_back(l)

func _process(delta):
	fields_dist = sin(Engine.get_frames_drawn() * 0.05) + 0.5
	line_height += cos(Engine.get_frames_drawn() * 0.05) * 0.01 + 0.001
	
	if Engine.get_frames_drawn() % 50 == 0:
		testo()

	purge()
	populate()

func testo():
	var choices = [
		'ciao ciao ciao ciao',
		'Lelo che bella che sei',
		'Pipo! Pipo! Piiiiiipo!',
		'ciaopipo',
		'<3 <3 <3 <3 <3 <3',
		':3 :3 :3 :3 :3 :3',
	]
	
	m = TextMesh.new()
	m.text = 'ciao ciao ciao ciao ciao'
	m.font_size = font_size
	m.text = choices.pick_random()
	
