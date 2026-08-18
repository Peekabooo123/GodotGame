@tool
class_name Background

extends Node2D
@onready var spawn_area_shape_left: CollisionShape2D = $SpawnArea/Left
@onready var spawn_area_shape_right: CollisionShape2D = $SpawnArea/Right

@onready var exit_area_shape_left: CollisionShape2D = $ExitArea/Left
@onready var exit_area_shape_right: CollisionShape2D = $ExitArea/Right

@onready var wait_area_shape_left: CollisionShape2D = $WaitArea/Left
@onready var wait_area_shape_right: CollisionShape2D = $WaitArea/Right

@onready var zebra_crossing_area: CollisionShape2D = $ZebraCrossingArea/ZebraCrossing
@onready var road_top_area: CollisionShape2D = $RoadArea/CollisionShape2D

@onready var car_stop_line: Area2D = $CarStopLine

@onready var left_marker: Marker2D = $Markers/Left
@onready var right_marker: Marker2D = $Markers/Right

var strip_width = 20
var strip_height = 130
var gap = 10
var road_width = (strip_width + gap) * 20 + strip_width

var screen_size: Vector2
var road_position = Vector2(300, 0)
var zebra_crossing_postion = Vector2(road_position.x , 300)

func _ready() -> void:
	#screen_size = get_viewport_rect().size
	screen_size = Vector2(1200,800)





func get_pedestrian_points():
	var walk_data = get_pedestrian_walk_data()
	var decision_point_left = Vector2(walk_data['left_sidewalk_x'] + randf_range(-20, 20), randf_range(10,790))
	var decision_point_right = Vector2(walk_data['right_sidewalk_x'] + randf_range(-20, 20), randf_range(10,790))

	return {
		"spawn_left_top": get_random_position(spawn_area_shape_left),
		"spawn_right_top": get_random_position(spawn_area_shape_right),
		"decision_point_left":decision_point_left,
		"wait_left": get_random_position(wait_area_shape_left),
		"decision_left_to_right": Vector2(decision_point_right.x, decision_point_left.y+randf_range(0, 80)),
		"decision_point_right":decision_point_right,
		"wait_right": get_random_position(wait_area_shape_right),
		"decision_right_to_left": Vector2(decision_point_left.x, decision_point_right.y+randf_range(0, 80)),
		"left_exit_bottom": get_random_position(exit_area_shape_left),
		"right_exit_bottom": get_random_position(exit_area_shape_right),
	}












func get_pedestrian_walk_data() -> Dictionary:
	
	return {
		"zebra_y_range": _get_area_y_range(zebra_crossing_area),
		"road_y_range": _get_road_y_range(),
		"left_sidewalk_x": left_marker.global_position.x,
		"right_sidewalk_x": right_marker.global_position.x,
	}

func _get_area_y_range(area_shape: CollisionShape2D) -> Vector2:
	var shape: RectangleShape2D = area_shape.shape
	var center_y = area_shape.global_position.y
	var half_height = shape.size.y / 2.0
	return Vector2(center_y - half_height, center_y + half_height)

func _get_road_y_range() -> Vector2:
	var road_range = _get_area_y_range(road_top_area)
	#print(road_range)
	return Vector2(0,800)

func get_random_position(area_shape:CollisionShape2D) -> Vector2:
	var shape: RectangleShape2D = area_shape.shape
	var area_size: Vector2 = shape.size
	var area_center: Vector2 = area_shape.global_position

	var half_size := area_size / 2.0
	var random_x := randf_range(-half_size.x, half_size.x)
	var random_y := randf_range(-half_size.y, half_size.y)

	return area_center + Vector2(random_x, random_y)


func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, screen_size),Color.BLACK)
	draw_rect(Rect2(road_position, Vector2(road_width, screen_size.y)), Color(0, 0.302, 0.302, 1.0)) #Color.GRAY
	#_draw_lane_divider()
	#_zebra_crossing_drawing(road_width)


func _zebra_crossing_drawing(road_width: int) -> void:

	var strip_total_width = strip_width + gap
	var strip_count = int(road_width / strip_total_width)

	for i in range(strip_count+1):
		var x = zebra_crossing_postion.x +  i * strip_total_width
		draw_rect(Rect2(Vector2(x, zebra_crossing_postion.y), Vector2(strip_width, strip_height)), Color.WHITE)

func _draw_lane_divider():
	var strip_width = 15
	var strip_height = 80
	var gap = 20
	#var count:int = screen_size / (strip_height + gap)
	var count = 8
	var x = road_position.x + (road_width/2 - strip_width/2)
	for i in range(count):
		var y = i * (strip_height + gap)
		draw_rect(Rect2(Vector2(x, y), Vector2(strip_width, strip_height)), Color.YELLOW)
		
