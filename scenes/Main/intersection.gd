@tool
extends Node2D

@onready var TrafficLight_left = $TrafficLight_left
@onready var TrafficLight_right = $TrafficLight_right
@onready var Zebra_crossing_area = $ZebraCrossingArea
#@onready var zebra_crossing_area: CollisionShape2D = $ZebraCrossingArea/ZebraCrossing

@onready var wait_area_shape_left: CollisionShape2D = $WaitArea/Left
@onready var wait_area_shape_right: CollisionShape2D = $WaitArea/Right

@onready var controller = $TrafficLightController

func _ready() -> void:
	TrafficLight_left.setup(controller)
	TrafficLight_right.setup(controller)
	Zebra_crossing_area.setup(controller)








func get_zebra_crossing_y_range() -> Vector2:
	var Zebra_crossing_shape: CollisionShape2D = Zebra_crossing_area.get_node("ZebraCrossing")

	var shape: RectangleShape2D = Zebra_crossing_shape.shape
	var center_y = Zebra_crossing_shape.global_position.y
	var half_height = shape.size.y / 2.0
	return Vector2(center_y - half_height, center_y + half_height)



func get_points() -> Dictionary:
	return {
		'wait_points_left': _get_random_position(wait_area_shape_left),
		'wait_points_right': _get_random_position(wait_area_shape_right),
	}







func _get_random_position(area_shape:CollisionShape2D) -> Vector2:
	var shape: RectangleShape2D = area_shape.shape
	var area_size: Vector2 = shape.size
	var area_center: Vector2 = area_shape.global_position

	var half_size := area_size / 2.0
	var random_x := randf_range(-half_size.x, half_size.x)
	var random_y := randf_range(-half_size.y, half_size.y)

	return area_center + Vector2(random_x, random_y)







func _draw() -> void:
	_zebra_crossing_drawing()
	pass

func _zebra_crossing_drawing() -> void:
	var strip_width = 20
	var strip_height = 130
	var gap = 10
	var position = Vector2(300,300)


	var strip_total_width = strip_width + gap
	var strip_count = 20

	for i in range(strip_count+1):
		var x = position.x +  i * strip_total_width
		draw_rect(Rect2(Vector2(x, position.y), Vector2(strip_width, strip_height)), Color.WHITE)
