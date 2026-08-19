extends Node

@export var car_scene: PackedScene
@export var min_spawn_interval: float = 2.0
@export var max_spawn_interval: float = 2.0

@onready var spawn_timer: Timer = $SpawnTimer

var background: Node2D
var cars_container: Node2D

func setup(p_background: Node2D, p_container: Node2D) -> void:
	background = p_background
	cars_container = p_container

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
	var points = background.get_car_points()
	var car := car_scene.instantiate()

	var spawn_candidates: Array[Vector2] = [points["car_spawn_area_top"], points["car_spawn_area_bot"]]
	var spawn_position: Vector2 = spawn_candidates[randi() % spawn_candidates.size()]

	car.position = spawn_position
	cars_container.add_child(car)

	#pedestrian.initialize(behavior_type, points)
