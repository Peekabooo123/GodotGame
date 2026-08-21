extends Area2D
var controller = null

@export var traffic_light_controller: Node2D   # 对应的红绿灯控制器
@export var intersection: Node2D        # 拖入 Intersection 根节点
@export var opposite_area: Area2D       # 拖入对面的 WaitArea



func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('pedestrians'):
		var start_point = _get_random_point_in_area(self)
		var end_point = _get_random_point_in_area(opposite_area)
		var path = {'start_point': start_point, 'end_point': end_point}

		if body.has_method("set_current_intersection"):
			body.set_current_intersection(traffic_light_controller)

		if body.has_method("offer_crossing_decision"):
			body.offer_crossing_decision(path)


func _on_body_exited(body: Node2D) -> void:
	pass




func _get_random_point_in_area(area: Area2D) -> Vector2:
	var collision_shape: CollisionShape2D = null
	for child in area.get_children():
		if child is CollisionShape2D:
			collision_shape = child
			break
	#var collision_shape = area.get_children()
	var shape: RectangleShape2D = collision_shape.shape
	var half: Vector2 = shape.size / 2.0
	var offset := Vector2(randf_range(-half.x, half.x), randf_range(-half.y, half.y))
	return collision_shape.global_position + offset
