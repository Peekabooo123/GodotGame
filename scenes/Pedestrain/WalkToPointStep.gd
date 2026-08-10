class_name WalkToPointStep
extends BehaviorStep

var target_position: Vector2

func _init(p_target: Vector2 = Vector2.ZERO) -> void:
	target_position = p_target

func process(pedestrian: CharacterBody2D, delta: float) -> bool:
	var to_target: Vector2 = target_position - pedestrian.global_position

	if to_target.length() < 4.0:
		pedestrian.velocity = Vector2.ZERO
		pedestrian.move_and_slide()
		return true

	pedestrian.velocity = to_target.normalized() * pedestrian.speed
	pedestrian.move_and_slide()
	return false
