extends Node2D

@onready var click_sound: AudioStreamPlayer2D = $ClickSound

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

func _click_process() -> void:
	var pedestrian := _find_object_at(get_global_mouse_position())

	if pedestrian == null:
		print("没有点中任何东西")
		return

	print("点中了行人: ", pedestrian.name)
	if pedestrian.is_illegal:
		print("抓到一个闯红灯的！加分")
		#score_label.add_score(1)
		Eventbus.score_changed.emit(1)
	else:
		print("这个人是合法过马路的，点错了")
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
	if clicked_object is Area2D and clicked_object.get_parent().is_in_group("pedestrians"):
		return clicked_object.get_parent()

	return null
