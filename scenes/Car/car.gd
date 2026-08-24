extends CharacterBody2D

@export var speed: float = 80.0
@export var max_deceleration: float = 50.0
@export var max_acceleration: float = 30.0

@onready var car_sprite: Sprite2D = $Car

var direction: Vector2 = Vector2.UP
var is_illegal: bool = false
var is_selected: bool = false
var current_intersection: Node2D = null

enum DriveMode { ACCELERATING, BRAKING }
var drive_mode: DriveMode = DriveMode.ACCELERATING

func _ready() -> void:
	add_to_group("cars")
	add_to_group("selectable")

func _physics_process(delta: float) -> void:
	# 默认行为：根据当前驱动模式，持续加速或减速
	_apply_drive_mode(delta)
	move_and_slide()

func _apply_drive_mode(delta: float) -> void:
	var current_speed: float = velocity.length()
	match drive_mode:
		DriveMode.BRAKING:
			var new_speed: float = max(0.0, current_speed - max_deceleration * delta)
			velocity = direction.normalized() * new_speed
		DriveMode.ACCELERATING:
			var new_speed: float = min(speed, current_speed + max_acceleration * delta)
			velocity = direction.normalized() * new_speed

# ---- 对外公开方法：外部（包括 FrontRayCast 子节点）调用来控制加减速 ----
func brake() -> void:
	drive_mode = DriveMode.BRAKING

func accelerate() -> void:
	drive_mode = DriveMode.ACCELERATING

# ---- 其他对外方法（保持不变）----
func set_current_intersection(controller: Node2D) -> void:
	current_intersection = controller

func select(value: bool) -> void:
	is_selected = value

func mark_as_illegal() -> void:
	if is_illegal:
		return
	is_illegal = true

func set_highlighted(value: bool) -> void:
	car_sprite.modulate = Color(1.3, 1.3, 1.3) if value else Color.WHITE
