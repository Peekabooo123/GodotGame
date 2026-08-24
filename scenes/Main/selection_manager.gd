extends Node2D

@onready var click_sound: AudioStreamPlayer2D = $ClickSound
@export var camera_controller: Camera2D   # 在编辑器里把 Camera2D 拖进来赋值  # 在编辑器里把 Camera2D 拖进来赋值

var currently_hovered: Node2D = null


func _process(delta: float) -> void:
	_hover_process()

func _hover_process() -> void:
	var pedestrian = _find_object_at(get_global_mouse_position())
	if pedestrian == currently_hovered:
		return

	if currently_hovered != null and is_instance_valid(currently_hovered):
		currently_hovered.set_highlighted(false)

	currently_hovered = pedestrian

	if currently_hovered != null:
		currently_hovered.set_highlighted(true)



func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_click_process()

	# 新增：键盘空格键按下处理
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		camera_controller.set_default_target()





func _click_process() -> void:
	var pedestrian := _find_object_at(get_global_mouse_position())
	if not pedestrian:
		return
	#camera_controller.set_follow_target(pedestrian)
	
	pedestrian.select(true)
	

	if pedestrian == null:
		print("没有点中任何东西")
		return

	#print("点中了行人: ", pedestrian.name)
	if pedestrian.is_illegal:
		#print("抓到一个闯红灯的！加分")
		#score_label.add_score(1)
		Eventbus.score_changed.emit(1)
	else:
		#print("这个人是合法过马路的，点错了")
		Eventbus.score_changed.emit(-1)

	click_sound.play()
	pedestrian.queue_free()

func _find_object_at(pos: Vector2) -> Node2D:
	var space_state := get_tree().root.get_world_2d().direct_space_state
	var query := PhysicsPointQueryParameters2D.new()
	query.position = pos
	query.collide_with_bodies = true
	query.collide_with_areas = true
	query.collision_mask = 1 << 3

	var results := space_state.intersect_point(query, 1)

	if results.is_empty():
		return null

	var clicked_object = results[0]["collider"]
	if clicked_object is Area2D:
		var parent = clicked_object.get_parent()
		if parent.is_in_group("pedestrians") or parent.is_in_group("cars"):
			return parent

	return null
