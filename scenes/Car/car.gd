extends CharacterBody2D

@export var speed: float = 200.0
@onready var hit_detection_area: Area2D = $HitDetectionArea
@onready var car: Sprite2D = $Car


func _ready() -> void:
	add_to_group("cars")
	add_to_group("selectable")
	hit_detection_area.body_entered.connect(_on_hit_detection_area_body_entered)

func _physics_process(_delta: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_dir * speed
	_update(input_dir)


	move_and_slide()

func _on_hit_detection_area_body_entered(body: Node2D) -> void:
	print("检测到物体进入: ", body.name)

func _update(input_dir: Vector2):
	if input_dir.length() > 0:
		rotation = input_dir.angle() + PI / 2
