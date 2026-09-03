extends CharacterBody2D

# ============ 参数 ============
@export var speed: float = 30.0   # 由 Spawner 生成时可覆盖

# ============ 状态标记 ============
var is_illegal: bool = false
var is_on_crosswalk: bool = false
var is_selected: bool = false
var is_stopped: bool = false
var can_be_offered: bool = true

# ============ 行为相关 ============
enum State { WALKING_STRAIGHT, CROSSING }
enum CrossPhase { TO_START, TO_END }
var current_state: State = State.WALKING_STRAIGHT
var cross_phase: CrossPhase = CrossPhase.TO_START

var direction: Vector2 = Vector2.DOWN   # 初始化时由外部设定
var cross_start_point: Vector2
var cross_end_point: Vector2

var current_intersection: Node2D = null

@onready var animated_sprite: AnimatedSprite2D = $Pedestrain


# ============ 1. 初始化 ============
func _ready() -> void:
	add_to_group("pedestrians")
	add_to_group("selectable")

func initialize(spawn_direction: Vector2) -> void:
	direction = spawn_direction

# ============ 2. 默认行为（自主运行）============
func _physics_process(delta: float) -> void:
	if is_stopped:
		velocity = Vector2.ZERO
		move_and_slide()
		_update_animation(false)
		return

	match current_state:
		State.WALKING_STRAIGHT:
			_walk_straight()
		State.CROSSING:
			_walk_crossing()

	_update_animation(velocity.length() > 0.1)

func _walk_straight() -> void:
	velocity = direction.normalized() * speed
	move_and_slide()

func _walk_crossing() -> void:
	var target: Vector2 = cross_start_point if cross_phase == CrossPhase.TO_START else cross_end_point
	var to_target: Vector2 = target - global_position

	if to_target.length() < 4.0:
		if cross_phase == CrossPhase.TO_START:
			cross_phase = CrossPhase.TO_END
		else:
			current_state = State.WALKING_STRAIGHT
		return

	velocity = to_target.normalized() * speed
	move_and_slide()

func _update_animation(is_moving: bool) -> void:
	if is_moving:
		if animated_sprite.animation != "walk" or not animated_sprite.is_playing():
			animated_sprite.play("walk")
	else:
		animated_sprite.stop()


# ============ 3. 对外公开方法 ============

# --- 行为控制 ---
func offer_crossing_decision(path: Dictionary) -> void:
	if current_state == State.CROSSING:
		return
	if not can_be_offered:
		return
	if randf() > 0.5:   # 过马路概率，可参数化
		return

	cross_start_point = path["start_point"]
	cross_end_point = path["end_point"]
	cross_phase = CrossPhase.TO_START
	current_state = State.CROSSING
	can_be_offered = false

func on_left_wait_area() -> void:
	if current_state == State.WALKING_STRAIGHT:
		can_be_offered = true

func stop_this_guy(value: bool) -> void:
	is_stopped = value
	if is_stopped:
		velocity = Vector2.ZERO

# --- 状态标记 ---
func mark_as_illegal() -> void:
	if is_illegal:
		return
	is_illegal = true

func set_on_crosswalk(value: bool) -> void:
	is_on_crosswalk = value

func select(value: bool) -> void:
	is_selected = value

func set_highlighted(value: bool) -> void:
	animated_sprite.modulate = Color(1.3, 1.3, 1.3) if value else Color.WHITE

# --- 依赖注入 ---
func set_current_intersection(controller: Node2D) -> void:
	current_intersection = controller
