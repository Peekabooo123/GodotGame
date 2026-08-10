extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("cars") and body.has_method("set_at_stopline"):
		body.set_at_stopline(true)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("cars") and body.has_method("set_at_stopline"):
		body.set_at_stopline(false)
