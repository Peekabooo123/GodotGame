extends Node

enum TrafficLightState { RED, YELLOW, GREEN }
var current_traffic_light_state: TrafficLightState = TrafficLightState.RED
#signal traffic_light_state_changed(state: TrafficLightState)


signal crosswalk_occupancy_changed(is_occupied: bool)

signal car_get_stopline(should_stop: bool)

signal score_changed(amount: int)
