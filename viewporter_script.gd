extends Node

var random_ticker_scn = preload('res://random_ticker.tscn')

@export var enabled: bool = false

func _ready():
	RenderingServer.set_debug_generate_wireframes(true)
	
	var random_ticker: RandomTicker = random_ticker_scn.instantiate()
	self.add_child(random_ticker)
	
	random_ticker.timeout.connect(_on_random_ticker_timeout)
	random_ticker.start_timer()

func next_viewp():
	return 
	var vp = get_viewport()
	
	if not enabled:
		vp.debug_draw = 0
	
	vp.debug_draw = (vp.debug_draw + 1 ) % 4

func _on_random_ticker_timeout():
	self.next_viewp()
