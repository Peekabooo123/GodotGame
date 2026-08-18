class_name Judger
extends Node

func judge_pedestrian_crossing(body: Node2D, was_red_light: bool) -> void:
	if was_red_light:
		body.mark_as_illegal()
		print(body.name, " 因闯红灯被判定违规")
	else:
		print(body.name, " 合法通过")

func judge_illegal_road_crossing(body: Node2D) -> void:
	body.mark_as_illegal()
	print(body.name, " 因未走斑马线被判定违规")
