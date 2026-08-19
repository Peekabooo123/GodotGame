extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("pedestrians"):
		return

	var car = get_parent()
	if car.is_selected:
		print('发生碰撞了，此时车速: ', car.velocity)
#
	#if body.has_method("stop_due_to_collision"):
		#body.stop_due_to_collision()
#
	#if car.has_method("stop_due_to_collision"):
		#car.stop_due_to_collision()

	TrafficJudge.report_collision(car,body)

	#print("检测到物体进入: ", body.name)

func _on_body_exited(body: Node2D) -> void:
	if not body.is_in_group("pedestrians"):
		return
