extends CharacterBody2D

var speed: float
#@onready var speed: float = 100
@export var cross_probability: float = 0.5
@onready var animated_sprite: AnimatedSprite2D = $Pedestrain

enum State { WALKING_STRAIGHT, CROSSING }
enum CrossPhase { TO_START, TO_END }   # 过马路的两个子阶段
var current_state: State = State.WALKING_STRAIGHT
var cross_phase: CrossPhase = CrossPhase.TO_START

var direction: Vector2 = Vector2.DOWN   # 直行方向，由生成时决定
var cross_start_point: Vector2            # 过马路的入口点
var cross_end_point: Vector2              # 过马路的出口点

var is_on_crosswalk: bool = false
var is_illegal: bool = false
var is_selected: bool = false

var can_be_offered: bool = true


var current_intersection: Node2D = null

func _ready() -> void:
	add_to_group("pedestrians")
	add_to_group("selectable")
	speed = randf_range(10, 40)

func set_current_intersection(controller: Node2D) -> void:
	current_intersection = controller

func _physics_process(delta: float) -> void:
	_update_animation(true)
	match current_state:
		State.WALKING_STRAIGHT:
			_walk_straight()
		State.CROSSING:
			_walk_crossing()

# ---- 直行分支 ----
func _walk_straight() -> void:
	velocity = direction.normalized() * speed
	move_and_slide()

# ---- 过马路分支 ----
func _walk_crossing() -> void:
	var target: Vector2
	if cross_phase == CrossPhase.TO_START:
		target = cross_start_point
	else:
		target = cross_end_point

	var to_target: Vector2 = target - global_position

	if to_target.length() < 4.0:
		if cross_phase == CrossPhase.TO_START:
			cross_phase = CrossPhase.TO_END   # 到了入口点，进入第二段
		else:
			current_state = State.WALKING_STRAIGHT   # 到了出口点，过马路结束
		return

	velocity = to_target.normalized() * speed
	move_and_slide()

# ---- 由 WaitArea 调用 ----
func offer_crossing_decision(path: Dictionary) -> void:
	# 已经在过马路，忽略
	if current_state == State.CROSSING:
		return
	# 概率决定不过，保持直行
	if randf() > cross_probability:
		return
	if not can_be_offered:
		return

	# 决定过马路
	cross_start_point = path["start_point"]
	cross_end_point = path["end_point"]
	current_state = State.CROSSING
	
	can_be_offered = false  


func on_left_wait_area() -> void:
	if current_state == State.WALKING_STRAIGHT:
		can_be_offered = true           # 彻底离开等待区后，才恢复接受邀请

func set_on_crosswalk(value: bool) -> void:
	is_on_crosswalk = value

func mark_as_illegal() -> void:
	if is_illegal:
		return
	is_illegal = true


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
	pass
	return
