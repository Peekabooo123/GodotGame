extends Node2D

@onready var background: Node2D = $Background

@onready var pedestrian_spawner: Node = $PedestrianSpawner
@onready var pedestrians_container: Node2D = $PedestriansContainer   # 如果你还留着这个容器；不留的话可以直接用 Main 自己

@onready var car_spawner: Node = $CarSpawner
@onready var cars_container: Node2D = $CarsContainer   # 如果你还留着这个容器；不留的话可以直接用 Main 自己

@onready var BackgroundMusic: AudioStreamPlayer = $BackgroundMusic

func _ready() -> void:
	#BackgroundMusic.play()
	pedestrian_spawner.setup(background, pedestrians_container)
	car_spawner.setup(background, cars_container)
