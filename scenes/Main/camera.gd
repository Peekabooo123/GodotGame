extends Camera2D

@export var follow_speed: float = 5.0   # 数值越大跟得越紧，Inspector 里可调
@export var zoom_step: float = 0.1
@export var min_zoom: float = 0.1
@export var max_zoom: float = 10.0

var default_zoom: float = 3


@export var default_camera_position: Marker2D

var follow_target: Node2D

func _ready() -> void:
	follow_target = default_camera_position
	zoom = Vector2(default_zoom, default_zoom)
	

func set_follow_target(target: Node2D) -> void:
	follow_target = target
func set_default_target()-> void:
	follow_target = default_camera_position



func _process(delta: float) -> void:
	if follow_target and is_instance_valid(follow_target):
		global_position = global_position.lerp(follow_target.global_position, follow_speed * delta)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_zoom_camera(zoom_step)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_zoom_camera(-zoom_step)

func _zoom_camera(step: float) -> void:
	var new_zoom: float = clamp(zoom.x + step, min_zoom, max_zoom)
	zoom = Vector2(new_zoom, new_zoom)
