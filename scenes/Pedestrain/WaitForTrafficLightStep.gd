class_name WaitForTrafficLightStep
extends BehaviorStep

func process(pedestrian: CharacterBody2D, delta: float) -> bool:
	if pedestrian.current_intersection == null:
		return true

	return not pedestrian.current_intersection.is_red()
