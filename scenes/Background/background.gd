extends Node2D

@export var color: Color = Color.BLACK

@onready var wait_point: Marker2D = $WaitPoint
@onready var start_point: Marker2D = $StartPoint
@onready var end_point: Marker2D = $EndPoint

func _draw():
	draw_rect(
		Rect2(Vector2.ZERO, get_viewport_rect().size),
		color,
		true
	)

func get_pedestrian_path() -> Array[Vector2]:
	return [wait_point.global_position, start_point.global_position, end_point.global_position]
