extends Node

func report_crosswalk_entry(pedestrian: Node2D, is_red: bool) -> void:
	print("斑马线上报: ", pedestrian.name)
	if is_red:
		pedestrian.mark_as_illegal()

func report_illegal_road_entry(pedestrian: Node2D) -> void:
	print("道路违规区域上报: ", pedestrian.name)
	pedestrian.mark_as_illegal()

func report_collision(car: Node2D, pedestrian: Node2D) -> void:
	print("碰撞上报: 车=", car.name, " 人=", pedestrian.name)
	print('此时车速：')

	if not pedestrian.is_on_crosswalk:
		pedestrian.mark_as_illegal()
	elif pedestrian.current_intersection.is_red():
		pedestrian.mark_as_illegal()
	else:
		car.mark_as_illegal()
