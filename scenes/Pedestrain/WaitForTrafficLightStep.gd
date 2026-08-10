class_name WaitForTrafficLightStep
extends BehaviorStep

func process(pedestrian: CharacterBody2D, delta: float) -> bool:
	if Eventbus.current_traffic_light_state == Eventbus.TrafficLightState.RED:
		pedestrian.velocity = Vector2.ZERO
		pedestrian.move_and_slide()
		return false
	return true
	
