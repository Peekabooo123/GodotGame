@tool
extends Node2D

@onready var TrafficLight_left = $TrafficLight_left
@onready var TrafficLight_right = $TrafficLight_right

@onready var controller = $TrafficLightController

func _ready() -> void:
	TrafficLight_left.setup(controller)
	TrafficLight_right.setup(controller)
	
	
func _draw() -> void:
	_zebra_crossing_drawing()
	pass

func _zebra_crossing_drawing() -> void:
	var strip_width = 20
	var strip_height = 130
	var gap = 10
	var position = Vector2(300,300)


	var strip_total_width = strip_width + gap
	var strip_count = 12

	for i in range(strip_count+1):
		var x = position.x +  i * strip_total_width
		draw_rect(Rect2(Vector2(x, position.y), Vector2(strip_width, strip_height)), Color.WHITE)
