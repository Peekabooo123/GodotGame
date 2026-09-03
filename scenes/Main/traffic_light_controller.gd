extends Node2D

signal state_changed(state: TrafficLightState)

enum TrafficLightState { RED, YELLOW, GREEN }

@export var red_duration: float = 60.0
@export var yellow_duration: float = 10.0
@export var green_duration: float = 30.0
@onready var timer: Timer = $StateTimer

var current_state: int = TrafficLightState.RED

func _ready() -> void:
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	_enter_state(current_state)

func _enter_state(new_state: TrafficLightState) -> void:
	current_state = new_state
	state_changed.emit(current_state)
	match current_state:
		TrafficLightState.RED:
			timer.start(red_duration)
		TrafficLightState.YELLOW:
			timer.start(yellow_duration)
		TrafficLightState.GREEN:
			timer.start(green_duration)


func _on_timer_timeout() -> void:
	match current_state:
		TrafficLightState.RED:
			_enter_state(TrafficLightState.GREEN)
		TrafficLightState.YELLOW:
			_enter_state(TrafficLightState.RED)
		TrafficLightState.GREEN:
			_enter_state(TrafficLightState.YELLOW)


func get_time_left() -> float:
	return timer.time_left

func is_red() -> bool:
	#print('现在灯状态是： ', current_state)
	return current_state == TrafficLightState.RED
