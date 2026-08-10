class_name BehaviorStep
extends Resource

## 返回 true 表示这个片段已完成，可以进入下一个片段
func process(pedestrian: CharacterBody2D, delta: float) -> bool:
	return true
