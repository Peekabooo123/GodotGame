class_name TrafficLights
extends Node2D

@onready var red_light: ColorRect = $RedLight
@onready var yellow_light: ColorRect = $YellowLight
@onready var green_light: ColorRect = $GreenLight
@onready var label: Label = $Label

var controller: Node2D = null



func setup(p_controller: Node2D) -> void:
	controller = p_controller
	controller.state_changed.connect(_update_visuals)
	_update_visuals(controller.current_state)



func _process(delta: float) -> void:
	if controller == null:
		return
	_update_countdown_label()


func _update_countdown_label():

	label.text = str(int(controller.get_time_left()))


func _update_visuals(state: int) -> void:
	var dim := Color(0.3, 0.3, 0.3)
	red_light.modulate = Color.WHITE if state == Eventbus.TrafficLightState.RED else dim
	yellow_light.modulate = Color.WHITE if state == Eventbus.TrafficLightState.YELLOW else dim
	green_light.modulate = Color.WHITE if state == Eventbus.TrafficLightState.GREEN else dim
	
	if state == Eventbus.TrafficLightState.RED:
		label.modulate = Color.RED
	elif state == Eventbus.TrafficLightState.YELLOW:
		label.modulate = Color.YELLOW
	else:
		label.modulate = Color.GREEN
