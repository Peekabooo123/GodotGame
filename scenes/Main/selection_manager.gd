extends Node2D

@onready var click_sound: AudioStreamPlayer2D = $ClickSound
@export var camera_controller: Camera2D   # 在编辑器里把 Camera2D 拖进来赋值

## 可点击/可选中物体所在的碰撞层（第4层，即 Project Settings 里命名为 "selectable" 的那一层）
const SELECTABLE_LAYER_MASK: int = 1 << 3

var currently_hovered: Node2D = null


func _process(delta: float) -> void:
	_hover_process()

func _hover_process() -> void:
	var target := _find_object_at(get_global_mouse_position())
	if target == currently_hovered:
		return

	if currently_hovered != null and is_instance_valid(currently_hovered):
		currently_hovered.set_highlighted(false)

	currently_hovered = target

	if currently_hovered != null:
		currently_hovered.set_highlighted(true)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_click_process()

	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		camera_controller.set_default_target()


func _click_process() -> void:
	var target := _find_object_at(get_global_mouse_position())
	if not target:
		return

	target.select(true)

	_settle_score(target)

	click_sound.play()
	target.queue_free()

## 根据被点中物体的类型和违规状态，决定加分/扣分
func _settle_score(target: Node2D) -> void:
	if target.is_in_group("pedestrians"):
		if target.is_illegal:
			Eventbus.score_changed.emit(1)    # 抓到违规行人，加分
		else:
			Eventbus.score_changed.emit(-1)   # 点错了合法行人，扣分
	elif target.is_in_group("cars"):
		if target.is_illegal:
			Eventbus.score_changed.emit(1)    # 抓到违规车辆，加分
		else:
			Eventbus.score_changed.emit(-1)   # 点错了合法车辆，扣分

func _find_object_at(pos: Vector2) -> Node2D:
	var space_state := get_tree().root.get_world_2d().direct_space_state
	var query := PhysicsPointQueryParameters2D.new()
	query.position = pos
	query.collide_with_bodies = true
	query.collide_with_areas = true
	query.collision_mask = SELECTABLE_LAYER_MASK

	var results := space_state.intersect_point(query, 1)

	if results.is_empty():
		return null

	var clicked_object = results[0]["collider"]
	if clicked_object is Area2D:
		var parent = clicked_object.get_parent()
		if parent.is_in_group("pedestrians") or parent.is_in_group("cars"):
			return parent

	return null
