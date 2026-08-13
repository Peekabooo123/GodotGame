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

	var spawn_candidates: Array[Vector2] = [points["spawn_lefttop"], points["spawn_righttop"]]
	var spawn_position: Vector2 = spawn_candidates[randi() % spawn_candidates.size()]

	pedestrian.position = spawn_position
	pedestrians_container.add_child(pedestrian)

	var behavior_type := _pick_random_behavior_type(spawn_position)
	pedestrian.initialize(behavior_type, points)


func _pick_random_behavior_type(spawn_position: Vector2) -> Pedestrian.BehaviorType:
	if spawn_position.x < 600:
		var choice := randi() % 3
		match choice:
			0:
				print('遵守')
				return Pedestrian.BehaviorType.LAW_ABIDING_LEFT
			1:
				print('闯红灯')
				return Pedestrian.BehaviorType.JAYWALKING_LEFT
			_:
				print('直走')
				return Pedestrian.BehaviorType.STRAIGHT_WALKING_LEFT
	else:
		var choice := randi() % 3
		match choice:
			0:
				print('遵守')
				return Pedestrian.BehaviorType.LAW_ABIDING_RIGHT
			1:
				print('闯红灯')
				return Pedestrian.BehaviorType.JAYWALKING_RIGHT
			_:
				print('直走')
				return Pedestrian.BehaviorType.STRAIGHT_WALKING_RIGHT
