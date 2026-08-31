extends Area2D
@export var traffic_light_controller: Node2D   # 对应的红绿灯控制器

var pedestrians_on_crossing: int = 0

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("pedestrians"):
		body.set_on_crosswalk(true)
		TrafficJudge.report_crosswalk_entry(body, traffic_light_controller.is_red())

	if body.is_in_group('cars'):
		pass
		#print('Cars in')

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("pedestrians"):
		body.set_on_crosswalk(false)

	if body.is_in_group('cars'):
		#print('Cars out')
		pass
