extends Area2D
var pedestrians_on_crossing: int = 0
var controller: Node2D = null

func setup(p_controller: Node2D) -> void:
	controller = p_controller

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("pedestrians"):
		pedestrians_on_crossing += 1
		body.set_on_crosswalk(true)
		TrafficJudge.report_crosswalk_entry(body, controller.is_red())
		if pedestrians_on_crossing == 1:
			#Eventbus.crosswalk_occupancy_changed.emit(true)
			print('you ren')
	if body.is_in_group('cars'):
		print('Cars in')

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("pedestrians"):
		pedestrians_on_crossing -= 1
		body.set_on_crosswalk(false)
		if pedestrians_on_crossing == 0:
			#Eventbus.crosswalk_occupancy_changed.emit(false)
			pass
	if body.is_in_group('cars'):
		print('Cars out')
