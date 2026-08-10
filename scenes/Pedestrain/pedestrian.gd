extends CharacterBody2D

@export var speed: float = randf_range(50.0, 150.0)

@onready var sprite: Sprite2D = $Pedestrain

var behavior_steps: Array[BehaviorStep] = []
var current_step_index: int = 0

func _ready() -> void:
	add_to_group("pedestrians")

func _physics_process(delta: float) -> void:
	if current_step_index >= behavior_steps.size():
		queue_free()
		return

	var current_step: BehaviorStep = behavior_steps[current_step_index]
	var finished: bool = current_step.process(self, delta)

	if finished:
		#print("完成了第 ", current_step_index, " 个行为片段")
		current_step_index += 1

func set_behavior(steps: Array[BehaviorStep]) -> void:
	behavior_steps = steps
	current_step_index = 0
