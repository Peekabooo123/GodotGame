class_name PedestrianBehaviors
extends RefCounted

static func law_abiding(points: Dictionary) -> Array[BehaviorStep]:
	var steps: Array[BehaviorStep] = [
		WalkToPointStep.new(points["left"]),
		WaitForTrafficLightStep.new(),
		WalkToPointStep.new(points["right"]),
		WalkToPointStep.new(points["right_exit"]),
	]
	return steps

static func jaywalking(points: Dictionary) -> Array[BehaviorStep]:
	var steps: Array[BehaviorStep] = [
		WalkToPointStep.new(points["left"]),
		WalkToPointStep.new(points["right"]),
		WalkToPointStep.new(points["right_exit"]),
	]
	return steps

static func straight_walking(points: Dictionary) -> Array[BehaviorStep]:
	var steps: Array[BehaviorStep] = [
		WalkToPointStep.new(points["left_exit"]),
	]
	return steps
