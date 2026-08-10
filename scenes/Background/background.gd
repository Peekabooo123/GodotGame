extends Node2D

@export var color: Color = Color.BLACK

@onready var wait_point: Marker2D = $WaitPoint
@onready var start_point: Marker2D = $StartPoint
@onready var end_point: Marker2D = $EndPoint
@onready var spawn_point: Marker2D = $SpawnPoint
@onready var left_exit_point: Marker2D = $LeftExitPoint
@onready var right_exit_point: Marker2D = $RightExitPoint

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
