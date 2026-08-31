extends Area2D

@export var spawn_direction: Vector2 = Vector2.DOWN   # 这个生成点对应的行走方向，编辑器里为每个实例单独设置

func _ready() -> void:
	add_to_group("spawn_areas")
