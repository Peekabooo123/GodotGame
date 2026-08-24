extends RayCast2D

@export var perception_range: float = 200.0
@export var car: Node   # 拖入 Car 根节点（或者用 get_parent，但按原则用 @export 更明确）

func _physics_process(delta: float) -> void:
	var distance: float = _get_distance_to_front()

	if distance >= 0.0 and distance <= perception_range:
		car.brake()        # 感知到前车太近，通知父节点减速
	else:
		car.accelerate()   # 前方安全，通知父节点加速

func _get_distance_to_front() -> float:
	if not is_colliding():
		return -1.0
	var collision_point: Vector2 = get_collision_point()
	return global_position.distance_to(collision_point)
