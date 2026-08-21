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

	var spawn_candidates: Array[Vector2] = [points["spawn_left_top"], points["spawn_right_top"]]
	var spawn_position: Vector2 = spawn_candidates[randi() % spawn_candidates.size()]

	pedestrian.position = spawn_position
	pedestrians_container.add_child(pedestrian)

	var behavior_type := _pick_random_behavior_type(spawn_position)
	pedestrian.initialize(behavior_type, points)


func _pick_random_behavior_type(spawn_position: Vector2) -> Pedestrian.BehaviorType:
	#0.00 ───────────── 0.45 ───────── 0.85 ──── 0.95 ──── 1.00
		  #遵守规则 (45%)      直走(40%)    闯红灯(10%) 横穿(5%)

	var roll := randf()   # 0.0 ~ 1.0 之间的随机数

	var is_left = spawn_position.x < background.get_centre_point().x

	if roll < 0.45:
		#print('遵守')
		return Pedestrian.BehaviorType.LAW_ABIDING_LEFT if is_left else Pedestrian.BehaviorType.LAW_ABIDING_RIGHT
	elif roll < 0.85:
		#print('直走')
		return Pedestrian.BehaviorType.STRAIGHT_WALKING_LEFT if is_left else Pedestrian.BehaviorType.STRAIGHT_WALKING_RIGHT
	elif roll < 0.95:
		#print('闯红灯')
		return Pedestrian.BehaviorType.JAYWALKING_LEFT if is_left else Pedestrian.BehaviorType.JAYWALKING_RIGHT
	else:
		#print('横穿马路')
		return Pedestrian.BehaviorType.STRAIGHT_WALKING_ACROSS_LEFT if is_left else Pedestrian.BehaviorType.STRAIGHT_WALKING_ACROSS_RIGHT
