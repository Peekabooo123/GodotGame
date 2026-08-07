extends Node

enum TrafficLightState { RED, YELLOW, GREEN }
enum PedestrainState { WAITING, WALKING, ARRIVED }

signal traffic_light_state_changed(state: TrafficLightState)
