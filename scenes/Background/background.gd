extends Node2D

@export var color: Color = Color.BLACK

@onready var wait_point: Marker2D = $Points/WaitPoint
@onready var start_point: Marker2D = $Points/StartPoint
@onready var end_point: Marker2D = $Points/EndPoint
@onready var spawn_point: Marker2D = $Points/SpawnPoint
@onready var left_exit_point: Marker2D = $Points/LeftExitPoint
@onready var right_exit_point: Marker2D = $Points/RightExitPoint

@onready var zebra_crossing_area: Area2D = $ZebraCrossingArea
var pedestrians_on_crossing: int = 0

@onready var car_stop_line: Area2D = $CarStopLine


func _ready() -> void:
	zebra_crossing_area.body_entered.connect(_on_body_entered)
	zebra_crossing_area.body_exited.connect(_on_body_exited)
	
	car_stop_line.body_entered.connect(_on_car_entered)
	car_stop_line.body_entered.connect(_on_car_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("pedestrians"):
		pedestrians_on_crossing += 1
		if pedestrians_on_crossing == 1:
			Eventbus.crosswalk_occupancy_changed.emit(true)
			print('you ren')
	if body.is_in_group('cars'):
		print('Cars in')

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("pedestrians"):
		pedestrians_on_crossing -= 1
		if pedestrians_on_crossing == 0:
			Eventbus.crosswalk_occupancy_changed.emit(false)
	if body.is_in_group('cars'):
		print('Cars out')


func _on_car_entered(body: Node2D) -> void:
	if body.is_in_group('cars'):
		Eventbus.car_get_stopline.emit(true)

func _on_car_exited(body: Node2D) -> void:
	if body.is_in_group('cars'):
		Eventbus.car_get_stopline.emit(false)


func _draw():
	draw_rect(
		Rect2(Vector2.ZERO, get_viewport_rect().size),
		color,
		true
	)


func get_pedestrian_points() -> Dictionary:
	return {
		"spawn": spawn_point.global_position,
		"wait": wait_point.global_position,
		"start": start_point.global_position,
		"end": end_point.global_position,
		"left_exit": left_exit_point.global_position,
		"right_exit": right_exit_point.global_position,
	}
func _zebra_crossing_aera_entered(body: Node2D):
	
	pass
