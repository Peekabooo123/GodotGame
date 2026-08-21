extends Area2D
var controller = null


func setup(p_controller: Node2D) -> void:
	controller = p_controller

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('pedestrians'):
		if body.has_method("set_current_intersection"):
			body.set_current_intersection(controller)
		if body.has_method("offer_crossing_decision"):
			body.offer_crossing_decision(self)


func _on_body_exited(body: Node2D) -> void:
	pass
