extends CharacterBody2D

@export var speed: float = 50.0
@onready var car_sprite: Sprite2D = $Car
@onready var proximity_sensor: Area2D = $ProximitySensor

var is_at_stopline: bool = false
var is_crosswalk_occupied: bool = false
var is_illegal: bool = false

@export var min_follow_distance: float = 40.0   # 距离小于这个值，必须完全停下
@export var slow_down_distance: float = 150.0   # 距离小于这个值，开始减速

func _ready() -> void:
	add_to_group("cars")
	velocity = Vector2(0,-1) * speed


func _physics_process(_delta: float) -> void:
	var factor = _calculate_factor()
	if _should_stop():
		velocity = Vector2.ZERO
	else:
		velocity = Vector2(0,-1) * speed * factor
	move_and_slide()

func _calculate_factor() -> float:
	var distance = proximity_sensor.get_distance_to_front_car()

	if distance < 0:
		return 1.0   # 没有前车，全速前进

	if distance <= min_follow_distance:
		return 0.0   # 太近了，必须停下

	if distance >= slow_down_distance:
		return 1.0   # 距离足够远，全速

	# 距离在 min_follow_distance 和 slow_down_distance 之间，线性插值计算速度比例
	return (distance - min_follow_distance) / (slow_down_distance - min_follow_distance)
	


func _should_stop() -> bool:
	if is_at_stopline and  Eventbus.current_traffic_light_state == Eventbus.TrafficLightState.GREEN:
		return true
	return false

func _update(input_dir: Vector2):
	if input_dir.length() > 0:
		rotation = input_dir.angle() + PI / 2




func mark_as_illegal() -> void:
	if is_illegal:
		return   # 已经标记过了，不用重复处理
	is_illegal = true
	print(name, " 被标记为非法车辆")

func set_at_stopline(at_line: bool) -> void:
	is_at_stopline = at_line


func _on_crosswalk_occupancy_changed(is_occupied: bool) -> void:
	is_crosswalk_occupied = is_occupied

func stop_due_to_collision() -> void:
	speed = 0

func set_highlighted(value: bool) -> void:
	if value:
		car_sprite.modulate = Color(1.3, 1.3, 1.3)   # 变亮
	else:
		car_sprite.modulate = Color.WHITE             # 恢复正常
