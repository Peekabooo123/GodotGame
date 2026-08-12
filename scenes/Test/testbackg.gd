@tool
class_name Background

extends Node2D
@onready var spawn_area_shape_left: CollisionShape2D = $SpawnArea/Left
@onready var spawn_area_shape_right: CollisionShape2D = $SpawnArea/right

@onready var exit_area_shape_left: CollisionShape2D = $ExitArea/Lfet
@onready var exit_area_shape_right: CollisionShape2D = $ExitArea/Right

@onready var wait_area_shape_left: CollisionShape2D = $ZebraCrossingArea/Left
@onready var wait_area_shape_right: CollisionShape2D = $ZebraCrossingArea/Right
@onready var zebra_crossing_area: CollisionShape2D = $ZebraCrossingArea/ZebraCrossing


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


func get_random_spawn_position(area_shape:CollisionShape2D) -> Vector2:
	var shape: RectangleShape2D = area_shape.shape
	var area_size: Vector2 = shape.size
	var area_center: Vector2 = area_shape.global_position

	var half_size := area_size / 2.0
	var random_x := randf_range(-half_size.x, half_size.x)
	var random_y := randf_range(-half_size.y, half_size.y)

	return area_center + Vector2(random_x, random_y)


func get_pedestrian_points() -> Dictionary:
	return {
		"spawn": get_random_spawn_position(spawn_area_shape_left),
		"left": get_random_spawn_position(spawn_area_shape_left),
		"right": get_random_spawn_position(wait_area_shape_right),
		"left_exit": get_random_spawn_position(exit_area_shape_left),
		"right_exit": get_random_spawn_position(exit_area_shape_right),
	}


func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, screen_size),Color.BLACK)
	draw_rect(Rect2(road_position, Vector2(road_width, screen_size.y)), Color(0, 0.302, 0.302, 1.0)) #Color.GRAY
	_zebra_crossing_drawing(road_width)

func _zebra_crossing_drawing(road_width: int) -> void:

	var strip_total_width = strip_width + gap
	var strip_count = int(road_width / strip_total_width)

	for i in range(strip_count+1):
		var x = zebra_crossing_postion.x +  i * strip_total_width
		draw_rect(Rect2(Vector2(x, zebra_crossing_postion.y), Vector2(strip_width, strip_height)), Color.WHITE)

	
