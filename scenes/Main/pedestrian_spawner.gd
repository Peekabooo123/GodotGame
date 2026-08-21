extends Node

@export var pedestrian_scene: PackedScene
@export var min_spawn_interval: float = 2.0
@export var max_spawn_interval: float = 2.0

@onready var spawn_timer: Timer = $SpawnTimer

var background: Node2D
var pedestrians_container: Node2D

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
	_spawn_pedestrian()
	_start_next_timer()

func _spawn_pedestrian() -> void:
	var points = background.get_pedestrian_points()
	var pedestrian := pedestrian_scene.instantiate()

	# 随机选一个出生点，并绑定对应的直行方向
	var spawn_options := [
		{"position": points["spawn_left_top"], "direction": Vector2.DOWN},
		{"position": points["spawn_right_top"], "direction": Vector2.DOWN},
	]
	var choice: Dictionary = spawn_options[randi() % spawn_options.size()]

	pedestrian.position = choice["position"]
	pedestrian.direction = choice["direction"]
	pedestrians_container.add_child(pedestrian)
