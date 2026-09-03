extends Node2D

@onready var TrafficLight_left = $TrafficLight_left
@onready var TrafficLight_right = $TrafficLight_right
@onready var Zebra_crossing_area = $ZebraCrossingArea
#@onready var zebra_crossing_area: CollisionShape2D = $ZebraCrossingArea/ZebraCrossing

@onready var Wait_area_left: Area2D = $WaitAreaLeft
@onready var Wait_area_right: Area2D = $WaitAreaRight

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
		'wait_points_left': _get_random_point_in_area(Wait_area_left),
		'wait_points_right': _get_random_point_in_area(Wait_area_right),
	}







func _get_random_point_in_area(area: Area2D) -> Vector2:
	#var collision_shape: CollisionShape2D = null
	#for child in area.get_children():
		#if child is CollisionShape2D:
			#collision_shape = child
			#break
	var collision_shape = area.get_children()[0]
	var shape: RectangleShape2D = collision_shape.shape
	var half: Vector2 = shape.size / 2.0
	var offset := Vector2(randf_range(-half.x, half.x), randf_range(-half.y, half.y))
	return collision_shape.global_position + offset




func _get_random_position(area_shape:CollisionShape2D) -> Vector2:
	var shape: RectangleShape2D = area_shape.shape
	var area_size: Vector2 = shape.size
	var area_center: Vector2 = area_shape.global_position

	var half_size := area_size / 2.0
	var random_x := randf_range(-half_size.x, half_size.x)
	var random_y := randf_range(-half_size.y, half_size.y)

	return area_center + Vector2(random_x, random_y)
