class_name RandomTicker
extends Node

signal timeout

@export var min_time: float = 0.2
@export var max_time: float = 1.0

@onready var timer_node: Timer = $Timer
@onready var time: float = pick_time()

# Called when the node enters the scene tree for the first time.
func _ready():
	start_timer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func pick_time() -> float:
	return randf_range(min_time, max_time)
 

func start_timer():
	time = pick_time()
	timer_node.wait_time = time
	timer_node.start()

func _on_timer_timeout():
	timeout.emit()
	start_timer()
