extends Node

func should_wait() -> bool:
	return Eventbus.current_traffic_light_state == Eventbus.TrafficLightState.RED
