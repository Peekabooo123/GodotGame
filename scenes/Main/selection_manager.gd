extends Node2D

@onready var click_sound: AudioStreamPlayer2D = $ClickSound
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var world_pos := get_global_mouse_position()
		print("点击坐标: ", world_pos)
		_check_what_is_at(world_pos)

func _check_what_is_at(pos: Vector2) -> void:
	var space_state := get_tree().root.get_world_2d().direct_space_state
	var query := PhysicsPointQueryParameters2D.new()
	query.position = pos
	query.collide_with_bodies = true
	query.collide_with_areas = true   
	query.collision_mask = 0x7FFFFFFF

	var results := space_state.intersect_point(query, 1)

	if results.is_empty():
		print("没有点中任何东西")
		return

	var clicked_object = results[0]["collider"]
	if clicked_object is Area2D and clicked_object.get_parent().is_in_group("pedestrians"):
		var pedestrian = clicked_object.get_parent()
		print("点中了行人: ", pedestrian.name)
		if pedestrian.is_illegal:
			print("抓到一个闯红灯的！加分")
		else:
			print("这个人是合法过马路的，点错了")

		click_sound.play()
		pedestrian.queue_free()
