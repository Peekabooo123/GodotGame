extends Node

@export var pedestrian_scene: PackedScene         # 拖入 Pedestrian.tscn
@export var min_spawn_interval: float = 2.0
@export var max_spawn_interval: float = 2.0

@onready var spawn_timer: Timer = $SpawnTimer

var background: Node2D
var pedestrians_container: Node2D
#@onready var pedestrians_container: Node2D = $Node2D

# 由 Main 在 _ready 里调用，注入依赖
func setup(p_background: Node2D, p_container: Node2D) -> void:
	background = p_background
	pedestrians_container = p_container

func _ready() -> void:
	spawn_timer.one_shot = true
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	_start_next_timer()

func _start_next_timer() -> void:
	var wait_time := randf_range(min_spawn_interval, max_spawn_interval)
	spawn_timer.start(wait_time)

func _on_spawn_timer_timeout() -> void:
	print('time out')
	_spawn_pedestrian()
	_start_next_timer()

func _spawn_pedestrian() -> void:
	var spawn_info: Dictionary = background.get_random_spawn_info()
	#var spawn_info = {
		#'position': Vector2(100,100),
		#'direction': Vector2.DOWN
	#}
	var pedestrian := pedestrian_scene.instantiate()
	pedestrians_container.add_child(pedestrian)
	pedestrian.global_position = spawn_info["position"]
	pedestrian.initialize(spawn_info["direction"])
