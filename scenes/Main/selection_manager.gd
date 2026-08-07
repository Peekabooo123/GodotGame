extends Node2D
#
#var currently_selected: Node2D = null
#func _ready() -> void:
	#print("SelectionManager 已经启动")
#
#func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#var world_pos := get_global_mouse_position()
		##print("左键点击的世界坐标: ", world_pos)
		#_check_what_is_at(world_pos)
#
#
#func _check_what_is_at(pos: Vector2) -> void:
	#var space_state := get_tree().root.get_world_2d().direct_space_state
	#var query := PhysicsPointQueryParameters2D.new()
	#query.position = pos
	#query.collide_with_bodies = true
	#query.collide_with_areas = false
	#query.collision_mask = 0x7FFFFFFF
#
	#var results := space_state.intersect_point(query, 1)
	#if results.is_empty(): return
	#var clicked_object = results[0]["collider"] # 得到点击的对象的 实例对象
	##print(results[0]["collider"].name)
	#if not clicked_object.is_in_group("selectable"):
		#print(clicked_object.name, " 不能被选中")
		#return
#
	## 先把上一个选中的对象取消选中
	#if currently_selected != null:
		#currently_selected.deselect()
		#print(currently_selected.name, " 被取消选中")
#
	## 再选中这次新点到的对象
	#currently_selected = clicked_object
	#currently_selected.select()
	#print(currently_selected.name, " 被选中了")
