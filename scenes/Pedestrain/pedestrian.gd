class_name Pedestrian
extends CharacterBody2D

enum BehaviorType { LAW_ABIDING, JAYWALKING, STRAIGHT_WALKING }

@export var speed: float = randf_range(50.0, 150.0)
@onready var animated_sprite: AnimatedSprite2D = $Pedestrain
var behavior_steps: Array[BehaviorStep] = []
var current_step_index: int = 0
var has_behavior_assigned: bool = false

func _ready() -> void:
	add_to_group("pedestrians")
	add_to_group("selectable")
	animated_sprite.play("walk")

func initialize(behavior_type: BehaviorType, points: Dictionary) -> void:
	match behavior_type:
		BehaviorType.LAW_ABIDING:
			behavior_steps = PedestrianBehaviors.law_abiding(points)
		BehaviorType.JAYWALKING:
			behavior_steps = PedestrianBehaviors.jaywalking(points)
		BehaviorType.STRAIGHT_WALKING:
			behavior_steps = PedestrianBehaviors.straight_walking(points)

	current_step_index = 0
	has_behavior_assigned = true

func _physics_process(delta: float) -> void:
	if current_step_index >= behavior_steps.size():
		_update_animation(false)
		queue_free()
		return
	_update_animation(true)
	var current_step: BehaviorStep = behavior_steps[current_step_index]
	var finished: bool = current_step.process(self, delta)

	if finished:
		current_step_index += 1
	
func _update_animation(is_moving: bool) -> void:
	if is_moving:
		if animated_sprite.animation != "walk" or not animated_sprite.is_playing():
			animated_sprite.play("walk")
	else:
		#animated_sprite.play("walk")
		animated_sprite.stop()
