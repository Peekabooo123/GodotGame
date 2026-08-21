class_name Pedestrian
extends CharacterBody2D

enum BehaviorType { LAW_ABIDING_LEFT, LAW_ABIDING_RIGHT, 
					JAYWALKING_LEFT,JAYWALKING_RIGHT,
					STRAIGHT_WALKING_ACROSS_LEFT, STRAIGHT_WALKING_ACROSS_RIGHT,
					STRAIGHT_WALKING_LEFT,STRAIGHT_WALKING_RIGHT }

var is_illegal: bool = false
var is_on_crosswalk: bool = false
var is_selected:bool = false

@export var speed: float = randf_range(5.0, 30.0)
@onready var animated_sprite: AnimatedSprite2D = $Pedestrain
var behavior_steps: Array[BehaviorStep] = []
var current_step_index: int = 0
var has_behavior_assigned: bool = false
var current_intersection: Node2D = null

func _ready() -> void:
	add_to_group("pedestrians")
	add_to_group("selectable")
	animated_sprite.play("walk")

func initialize(behavior_type: BehaviorType, points: Dictionary) -> void:
	match behavior_type:
		BehaviorType.LAW_ABIDING_LEFT:
			behavior_steps = PedestrianBehaviors.law_abiding_left(points)
		BehaviorType.JAYWALKING_LEFT:
			behavior_steps = PedestrianBehaviors.jaywalking_left(points)
		BehaviorType.STRAIGHT_WALKING_LEFT:
			behavior_steps = PedestrianBehaviors.straight_walking_left(points)
		BehaviorType.STRAIGHT_WALKING_ACROSS_LEFT:
			behavior_steps = PedestrianBehaviors.straight_walking_across_left(points)
			

		BehaviorType.LAW_ABIDING_RIGHT:
			behavior_steps = PedestrianBehaviors.law_abiding_right(points)
		BehaviorType.JAYWALKING_RIGHT:
			behavior_steps = PedestrianBehaviors.jaywalking_right(points)
		BehaviorType.STRAIGHT_WALKING_RIGHT:
			behavior_steps = PedestrianBehaviors.straight_walking_right(points)
		BehaviorType.STRAIGHT_WALKING_ACROSS_RIGHT:
			behavior_steps = PedestrianBehaviors.straight_walking_across_right(points)

	current_step_index = 0
	has_behavior_assigned = true

func _physics_process(delta: float) -> void:
	if not has_behavior_assigned:
		return
	if current_step_index >= behavior_steps.size():
		_update_animation(false)
		queue_free()
		return
	_update_animation(true)
	var current_step: BehaviorStep = behavior_steps[current_step_index]
	var finished: bool = current_step.process(self, delta)

	if finished:
		current_step_index += 1



func set_current_intersection(controller: Node2D) -> void:
	current_intersection = controller

func mark_as_illegal() -> void:
	if is_illegal:
		return   # 已经标记过了，不用重复处理
	is_illegal = true
	#print(name, " 被标记为闯红灯")
	# 这里以后可以加视觉提示，比如换个颜色/图标

func set_on_crosswalk(value: bool) -> void:
	is_on_crosswalk = value

func select(value: bool) -> void:
	is_selected = value

func set_highlighted(value: bool) -> void:
	if value:
		animated_sprite.modulate = Color(1.3, 1.3, 1.3)   # 变亮
	else:
		animated_sprite.modulate = Color.WHITE             # 恢复正常

func _update_animation(is_moving: bool) -> void:
	if is_moving:
		if animated_sprite.animation != "walk" or not animated_sprite.is_playing():
			animated_sprite.play("walk")
	else:
		#animated_sprite.play("walk")
		animated_sprite.stop()

func stop_due_to_collision()->void:
	has_behavior_assigned = false
