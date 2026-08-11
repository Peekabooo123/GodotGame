extends Node2D

@export var color: Color = Color.BLACK

@onready var wait_point: Marker2D = $Points/WaitPoint
@onready var start_point: Marker2D = $Points/StartPoint
@onready var end_point: Marker2D = $Points/EndPoint
@onready var spawn_point: Marker2D = $Points/SpawnPoint
@onready var left_exit_point: Marker2D = $Points/LeftExitPoint
@onready var right_exit_point: Marker2D = $Points/RightExitPoint

@onready var zebra_crossing_area: Area2D = $ZebraCrossingArea

@onready var car_stop_line: Area2D = $CarStopLine

@onready var spawn_area: Area2D = $SpawnArea
@onready var spawn_area_shape: CollisionShape2D = $SpawnArea/CollisionShape2D
func _draw():
	draw_rect(
		Rect2(Vector2.ZERO, get_viewport_rect().size),
		color,
		true
	)

func get_random_spawn_position() -> Vector2:
	var shape: RectangleShape2D = spawn_area_shape.shape
	var area_size: Vector2 = shape.size
	var area_center: Vector2 = spawn_area_shape.global_position

	var half_size := area_size / 2.0
	var random_x := randf_range(-half_size.x, half_size.x)
	var random_y := randf_range(-half_size.y, half_size.y)

	return area_center + Vector2(random_x, random_y)


func get_pedestrian_points() -> Dictionary:
	return {
		"spawn": get_random_spawn_position(),
		"wait": wait_point.global_position,
		"start": start_point.global_position,
		"end": end_point.global_position,
		"left_exit": left_exit_point.global_position,
		"right_exit": right_exit_point.global_position,
	}
