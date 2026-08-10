extends Node

@export var pedestrian_scene: PackedScene
@export var min_spawn_interval: float = 2.0
@export var max_spawn_interval: float = 4.0

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
	var pedestrian = pedestrian_scene.instantiate()

	pedestrian.global_position = points["spawn"]
	pedestrians_container.add_child(pedestrian)
	#pedestrian.global_position = points["spawn"]
	#print('name:', pedestrian.name)

	var behavior_steps := _pick_random_behavior(points)
	pedestrian.set_behavior(behavior_steps)

func _pick_random_behavior(points: Dictionary) -> Array[BehaviorStep]:
	var choice := randi() % 3
	#choice = 1
	match choice:
		0:
			print('遵守规则')
			return PedestrianBehaviors.law_abiding(points)
		1:
			print('会闯红灯')
			return PedestrianBehaviors.jaywalking(points)
		_:
			print('直走，不过马路')
			return PedestrianBehaviors.straight_walking(points)
