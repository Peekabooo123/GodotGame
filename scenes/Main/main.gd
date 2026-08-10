extends Node2D

@onready var background: Node2D = $Background

@onready var pedestrian_spawner: Node = $PedestrianSpawner
@onready var pedestrians_container: Node2D = $PedestriansContainer   # 如果你还留着这个容器；不留的话可以直接用 Main 自己


func _ready() -> void:
	pedestrian_spawner.setup(background, pedestrians_container)
	var points = background.get_pedestrian_points()

	var pedestrians := get_tree().get_nodes_in_group("pedestrians")
	if pedestrians.size() >= 3:
		pedestrians[0].global_position = points["spawn"]
		pedestrians[0].set_behavior(PedestrianBehaviors.law_abiding(points))

		pedestrians[1].global_position = points["spawn"]
		pedestrians[1].set_behavior(PedestrianBehaviors.jaywalking(points))

		pedestrians[2].global_position = points["spawn"]
		pedestrians[2].set_behavior(PedestrianBehaviors.straight_walking(points))
