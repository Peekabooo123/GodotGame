extends CharacterBody2D

@export var speed: float = 50.0
@onready var hit_detection_area: Area2D = $HitDetectionArea
@onready var car_sprite: Sprite2D = $Car

var is_at_stopline: bool = false
var is_crosswalk_occupied: bool = false
var is_illegal: bool = false


func _ready() -> void:
	add_to_group("cars")
	hit_detection_area.body_entered.connect(_on_hit_detection_area_body_entered)
	#Eventbus.crosswalk_occupancy_changed.connect(_on_crosswalk_occupancy_changed)
	velocity = Vector2(0,-1) * speed


func _physics_process(_delta: float) -> void:
	if _should_stop():
		velocity = Vector2.ZERO
	else:
		velocity = Vector2(0,-1) * speed
	move_and_slide()

func _on_hit_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("pedestrians"):
		body.speed = 0
		pass
	speed = 0
	print("检测到物体进入: ", body.name)

func set_at_stopline(at_line: bool) -> void:
	is_at_stopline = at_line

func _on_crosswalk_occupancy_changed(is_occupied: bool) -> void:
	is_crosswalk_occupied = is_occupied

func _should_stop() -> bool:
	if is_at_stopline and  Eventbus.current_traffic_light_state == Eventbus.TrafficLightState.GREEN:
		return true

	return false

func set_highlighted(value: bool) -> void:
	if value:
		car_sprite.modulate = Color(1.3, 1.3, 1.3)   # 变亮
	else:
		car_sprite.modulate = Color.WHITE             # 恢复正常
	

func _update(input_dir: Vector2):
	if input_dir.length() > 0:
		rotation = input_dir.angle() + PI / 2
