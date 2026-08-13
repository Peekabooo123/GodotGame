extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("pedestrians"):
		return

	var car = get_parent()

	if body.has_method("stop_due_to_collision"):
		body.stop_due_to_collision()

	if car.has_method("stop_due_to_collision"):
		car.stop_due_to_collision()

	if car.has_method("mark_as_illegal"):
		car.mark_as_illegal()

	print("检测到物体进入: ", body.name)
