class_name WalkToPointStep
extends BehaviorStep

var target_position: Vector2
var wander_seed: float

func _init(p_target: Vector2 = Vector2.ZERO) -> void:
	target_position = p_target
	wander_seed = randf_range(0, 1000)

func process(pedestrian: CharacterBody2D, delta: float) -> bool:
	var to_target: Vector2 = target_position - pedestrian.global_position

	if to_target.length() < 4.0:
		pedestrian.velocity = Vector2.ZERO
		pedestrian.move_and_slide()
		return true
	
	var distance = to_target.length()
	var slow_down_radius = 40.0
	var speed_factor = clamp(distance / slow_down_radius, 0.2, 1.0)  # 接近终点时速度衰减
	
	var wander_amplitude = 5.0 * speed_factor
	var wander_offset = sin((Time.get_ticks_msec() + wander_seed * 100)/ 300.0) * wander_amplitude
	var perpendicular = to_target.normalized().rotated(PI / 2)

	pedestrian.velocity = (to_target.normalized() * pedestrian.speed * speed_factor) + (perpendicular * wander_offset)

	pedestrian.move_and_slide()
	return false
