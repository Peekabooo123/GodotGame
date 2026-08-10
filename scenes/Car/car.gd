extends CharacterBody2D

@export var speed: float = 50.0
@onready var hit_detection_area: Area2D = $HitDetectionArea
@onready var car: Sprite2D = $Car


func _ready() -> void:
	add_to_group("cars")
	hit_detection_area.body_entered.connect(_on_hit_detection_area_body_entered)
	Eventbus.crosswalk_occupancy_changed.connect(_on_crosswalk_occupancy_changed)
	#Eventbus.car_get_stopline.connect(_on_crosswalk_occupancy_changed)
	velocity = Vector2(0,-1) * speed


func _physics_process(_delta: float) -> void:
	move_and_slide()

func _on_hit_detection_area_body_entered(body: Node2D) -> void:

	print("检测到物体进入: ", body.name)



func _on_crosswalk_occupancy_changed(is_occupied: bool) -> void:
	if is_occupied or Eventbus.current_traffic_light_state == Eventbus.TrafficLightState.GREEN:
		velocity = Vector2.ZERO
		move_and_slide()
	else:
		velocity = Vector2(0,-1) * speed
		move_and_slide()
	pass

func _update(input_dir: Vector2):
	if input_dir.length() > 0:
		rotation = input_dir.angle() + PI / 2
