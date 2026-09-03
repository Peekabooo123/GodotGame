extends Area2D


func _ready() -> void:
	body_exited.connect(_on_body_exited)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("pedestrians") or body.is_in_group("cars"):
		body.queue_free()
