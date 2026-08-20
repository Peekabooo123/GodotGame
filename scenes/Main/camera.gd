extends Camera2D

@export var follow_speed: float = 5.0   # 数值越大跟得越紧，Inspector 里可调
@export var default_camera_position: Marker2D


var follow_target: Node2D = null

func set_follow_target(target: Node2D) -> void:
	follow_target = target

func _process(delta: float) -> void:
	if follow_target and is_instance_valid(follow_target):
		global_position = global_position.lerp(follow_target.global_position, follow_speed * delta)

func set_default_target()-> void:
	follow_target = default_camera_position
	print(default_camera_position.global_position)
