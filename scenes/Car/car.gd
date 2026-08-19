extends CharacterBody2D

@export var speed: float = 80.0                 # 初速度，实例化时会被赋值，体现差异
@export var max_deceleration: float = 50.0      # 刹车能力，先写死在基类
@export var perception_range: float = 200.0      # 检测范围，先写死在基类

@onready var car_sprite: Sprite2D = $Car
@onready var front_ray: RayCast2D = $FrontRayCast

var direction: Vector2 = Vector2.UP
var is_at_stopline: bool = false
var is_illegal: bool = false
var current_intersection: Node2D = null



func _ready() -> void:
	add_to_group("cars")
	velocity = direction * speed

func _physics_process(delta: float) -> void:
	var distance_to_front: float = get_distance_to_front_car()

	var current_speed: float = velocity.length()
	#print(name,'此时与前车距离',distance_to_front)

	if _should_stop():
		velocity = Vector2.ZERO
	elif distance_to_front >= 0.0 and distance_to_front <= perception_range:
		var new_speed: float = max(0.0, current_speed - max_deceleration * delta)
		velocity = direction.normalized() * new_speed
		#print(name,'开始减速了，当前车速： ',velocity)
	else:
		velocity = direction.normalized() * speed
	#print(name,'当前车速： ',velocity)
	move_and_slide()

func _should_stop() -> bool:
	return is_at_stopline and Eventbus.current_traffic_light_state == Eventbus.TrafficLightState.GREEN






func set_current_intersection(controller: Node2D) -> void:
	current_intersection = controller

func get_distance_to_front_car() -> float:
	if not front_ray.is_colliding():
		return -1.0
	var collision_point: Vector2 = front_ray.get_collision_point()
	return global_position.distance_to(collision_point)


func set_at_stopline(at_line: bool) -> void:
	is_at_stopline = at_line

func mark_as_illegal() -> void:
	if is_illegal:
		return
	is_illegal = true
	print(name, " 被标记为非法车辆")

func stop_due_to_collision() -> void:
	speed = 0

func set_highlighted(value: bool) -> void:
	car_sprite.modulate = Color(1.3, 1.3, 1.3) if value else Color.WHITE
