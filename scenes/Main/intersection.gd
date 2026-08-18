extends Node2D

@onready var TrafficLight_left = $TrafficLight_left
@onready var TrafficLight_right = $TrafficLight_right

@onready var controller = $TrafficLightController

func _ready() -> void:
	TrafficLight_left.setup(controller)
	TrafficLight_right.setup(controller)
