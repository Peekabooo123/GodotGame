extends Area2D

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area: Area2D) -> void:
	#print('到停止线了')
	var car = area.get_parent()
	if car.is_in_group("cars") and car.has_method("set_at_stopline"):
		car.set_at_stopline(true)

func _on_area_exited(area: Area2D) -> void:
	var car = area.get_parent()
	if car.is_in_group("cars") and car.has_method("set_at_stopline"):
		car.set_at_stopline(false)
