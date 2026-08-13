extends Area2D
var pedestrians_on_road: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	#body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("pedestrians"):
			if body.has_method("mark_as_illegal"):
				body.mark_as_illegal()
			print('有人走在马路上了')

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("pedestrians"):
		body.name
