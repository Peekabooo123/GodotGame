class_name Pedestrians
extends CharacterBody2D

@export var speed = 200
@onready var sprite: Sprite2D = $Pedestrain

var current_state: Eventbus.PedestrainState = Eventbus.PedestrainState.WAITING
var traffic_light_state: Eventbus.TrafficLightState = Eventbus.TrafficLightState.RED

var path: Array[Vector2] = []
var current_target_index: int = 1

func _ready() -> void:
	add_to_group("pedestrians")
	add_to_group("selectable")
	Eventbus.traffic_light_state_changed.connect(_on_traffic_light_state_changed)

func _on_traffic_light_state_changed(state: Eventbus.TrafficLightState):
	print("Pedestrian 收到红绿灯状态变化: ", state)
	traffic_light_state = state
	if current_state == Eventbus.PedestrainState.WAITING:
		_check_if_can_proceed()

func set_path(new_path: Array[Vector2]) -> void:
	path = new_path
	if not path.is_empty():
		global_position = path[0]
		current_target_index = 1
		_check_if_can_proceed()

func _check_if_can_proceed() -> void:
	if traffic_light_state == Eventbus.TrafficLightState.RED:
		current_state = Eventbus.PedestrainState.WAITING
	else:
		current_state = Eventbus.PedestrainState.WALKING

func _physics_process(_delta: float) -> void:
	match current_state:
		Eventbus.PedestrainState.WALKING:
			_move_towards_current_target()
		Eventbus.PedestrainState.ARRIVED or Eventbus.PedestrainState.WAITING:
			velocity = Vector2.ZERO
			move_and_slide()

func _move_towards_current_target() -> void:
	if current_target_index >= path.size():
		current_state = Eventbus.PedestrainState.ARRIVED
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var target: Vector2 = path[current_target_index]
	var to_target: Vector2 = target - global_position

	if to_target.length() < 4.0:
		current_target_index += 1
		return

	velocity = to_target.normalized() * speed
	move_and_slide()
