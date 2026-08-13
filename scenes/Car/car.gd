extends CharacterBody2D

@export var speed: float = 50.0
@onready var car_sprite: Sprite2D = $Car

var is_at_stopline: bool = false
var is_crosswalk_occupied: bool = false
var is_illegal: bool = false


func _ready() -> void:
	add_to_group("cars")
	velocity = Vector2(0,-1) * speed


func _physics_process(_delta: float) -> void:
	if _should_stop():
		velocity = Vector2.ZERO
	else:
		velocity = Vector2(0,-1) * speed
	move_and_slide()


func mark_as_illegal() -> void:
	if is_illegal:
		return   # 已经标记过了，不用重复处理
	is_illegal = true
	print(name, " 被标记为非法车辆")

func set_at_stopline(at_line: bool) -> void:
	is_at_stopline = at_line

func _on_crosswalk_occupancy_changed(is_occupied: bool) -> void:
	is_crosswalk_occupied = is_occupied

func _should_stop() -> bool:
	if is_at_stopline and  Eventbus.current_traffic_light_state == Eventbus.TrafficLightState.GREEN:
		return true
	return false
func stop_due_to_collision() -> void:
	speed = 0

func set_highlighted(value: bool) -> void:
	if value:
		car_sprite.modulate = Color(1.3, 1.3, 1.3)   # 变亮
	else:
		car_sprite.modulate = Color.WHITE             # 恢复正常
	

func _update(input_dir: Vector2):
	if input_dir.length() > 0:
		rotation = input_dir.angle() + PI / 2
