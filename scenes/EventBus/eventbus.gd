extends Node

enum TrafficLightState { RED, YELLOW, GREEN }
enum PedestrainState { WAITING, WALKING, ARRIVED }
var current_traffic_light_state: TrafficLightState = TrafficLightState.RED

signal traffic_light_state_changed(state: TrafficLightState)
