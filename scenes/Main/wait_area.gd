extends Area2D
var controller = null

@export var traffic_light_controller: Node2D   # 对应的红绿灯控制器
@export var intersection: Node2D        # 拖入 Intersection 根节点
@export var opposite_area: Area2D       # 拖入对面的 WaitArea



func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('pedestrians'):

		if body.has_method("set_current_intersection"):
			body.set_current_intersection(traffic_light_controller)

		if body.has_method("offer_crossing_decision"):
			body.offer_crossing_decision(self)


func _on_body_exited(body: Node2D) -> void:
	pass
