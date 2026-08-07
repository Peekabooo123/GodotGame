class_name TrafficLights
extends Node2D

#enum State { RED, YELLOW, GREEN }

@export var red_duration: float = 3.0
@export var yellow_duration: float = 3.0
@export var green_duration: float = 10.0

var current_state: Eventbus.TrafficLightState = Eventbus.TrafficLightState.RED

@onready var red_light: ColorRect = $RedLight
@onready var yellow_light: ColorRect = $YellowLight
@onready var green_light: ColorRect = $GreenLight
@onready var timer: Timer = $StateTimer
@onready var label: Label = $Label

func _ready() -> void:
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	_enter_state(Eventbus.TrafficLightState.RED)

func _process(delta: float) -> void:
	_update_countdown_label()

func _update_countdown_label():
	var seconds_left = ceil(timer.time_left)
	label.text = str(int(seconds_left))


func _enter_state(new_state: Eventbus.TrafficLightState) -> void:
	current_state = new_state
	_update_visuals()
	Eventbus.traffic_light_state_changed.emit(current_state)

	match current_state:
		Eventbus.TrafficLightState.RED:
			timer.start(red_duration)
			label.modulate = Color.RED
		Eventbus.TrafficLightState.YELLOW:
			timer.start(yellow_duration)
			label.modulate = Color.YELLOW
		Eventbus.TrafficLightState.GREEN:
			timer.start(green_duration)
			label.modulate = Color.GREEN

func _on_timer_timeout() -> void:
	match current_state:
		Eventbus.TrafficLightState.RED:
			_enter_state(Eventbus.TrafficLightState.GREEN)
		Eventbus.TrafficLightState.GREEN:
			_enter_state(Eventbus.TrafficLightState.YELLOW)
		Eventbus.TrafficLightState.YELLOW:
			_enter_state(Eventbus.TrafficLightState.RED)

func _update_visuals() -> void:
	var dim := Color(0.3, 0.3, 0.3)
	red_light.modulate = Color.WHITE if current_state == Eventbus.TrafficLightState.RED else dim
	yellow_light.modulate = Color.WHITE if current_state == Eventbus.TrafficLightState.YELLOW else dim
	green_light.modulate = Color.WHITE if current_state == Eventbus.TrafficLightState.GREEN else dim
