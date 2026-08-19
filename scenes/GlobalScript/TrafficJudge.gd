extends Node

func report_crosswalk_entry(pedestrian: Node2D) -> void:
	print("斑马线上报: ", pedestrian.name)
	pedestrian.mark_as_illegal()

func report_illegal_road_entry(pedestrian: Node2D) -> void:
	print("道路违规区域上报: ", pedestrian.name)
	pedestrian.mark_as_illegal()

func report_collision(car: Node2D, pedestrian: Node2D) -> void:
	print("碰撞上报: 车=", car.name, " 人=", pedestrian.name)
	car.mark_as_illegal()
