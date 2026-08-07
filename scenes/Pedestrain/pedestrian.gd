class_name Pedestrians
extends CharacterBody2D

@export var speed = 200
@export var crossing_rule_script: Script

@onready var sprite: Sprite2D = $Pedestrain
@onready var crossing_rule: Node = $CrossingRule

var current_state: Eventbus.PedestrainState = Eventbus.PedestrainState.WAITING

var path: Array[Vector2] = []
var current_target_index: int = 1

func _ready() -> void:
	add_to_group("pedestrians")
	add_to_group("selectable")
	crossing_rule.set_script(crossing_rule_script)

func set_path(new_path: Array[Vector2]) -> void:
	path = new_path
	if not path.is_empty():
		#global_position = path[0]
		current_target_index = 0
		_check_if_can_proceed()

func _check_if_can_proceed() -> void:
	if crossing_rule.should_wait():
		current_state = Eventbus.PedestrainState.WAITING
	else:
		current_state = Eventbus.PedestrainState.WALKING

func _physics_process(_delta: float) -> void:
	match current_state:
		Eventbus.PedestrainState.WALKING:
			#_check_if_can_proceed()
			_move_towards_current_target()
		Eventbus.PedestrainState.WAITING:
			velocity = Vector2.ZERO
			move_and_slide()
			_check_if_can_proceed()
		Eventbus.PedestrainState.ARRIVED:
			velocity = Vector2.ZERO
			move_and_slide()

func _move_towards_current_target() -> void:
	if current_target_index >= path.size():
		current_state = Eventbus.PedestrainState.ARRIVED
		return

	var target: Vector2 = path[current_target_index]
	var to_target: Vector2 = target - global_position

	if to_target.length() < 4.0:
		current_target_index += 1
		return

	velocity = to_target.normalized() * speed
	move_and_slide()
