extends Node2D

@onready var background: Node2D = $Background
@onready var pedestrian: Pedestrians = $Node/Pedestrain
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var path = background.get_pedestrian_path()
	pedestrian.set_path(path)
	for pedestrian in get_tree().get_nodes_in_group("pedestrians"):
		pedestrian.set_path(path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
