extends Area2D
var pedestrians_on_crossing: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("pedestrians"):
		pedestrians_on_crossing += 1
		if pedestrians_on_crossing == 1:
			Eventbus.crosswalk_occupancy_changed.emit(true)
			print('you ren')
	if body.is_in_group('cars'):
		print('Cars in')

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("pedestrians"):
		pedestrians_on_crossing -= 1
		if pedestrians_on_crossing == 0:
			Eventbus.crosswalk_occupancy_changed.emit(false)
	if body.is_in_group('cars'):
		print('Cars out')
