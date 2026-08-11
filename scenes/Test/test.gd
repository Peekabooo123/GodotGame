extends Node

var astar := AStar2D.new()

func _ready() -> void:
	# 第一步：注册点。add_point(id, 坐标)
	astar.add_point(0, Vector2(0, 0))
	astar.add_point(1, Vector2(100, 0))
	astar.add_point(2, Vector2(200, 0))

	# 第二步：声明连接。connect_points(id1, id2)
	astar.connect_points(0, 1)
	astar.connect_points(1, 2)

	# 第三步：查询路径
	var path: PackedVector2Array = astar.get_point_path(0, 2)
	print("从点0到点2的路径: ", path)
