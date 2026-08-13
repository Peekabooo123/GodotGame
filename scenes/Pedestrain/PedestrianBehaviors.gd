class_name PedestrianBehaviors
extends RefCounted

static func law_abiding_left(points: Dictionary) -> Array[BehaviorStep]:
	var steps: Array[BehaviorStep] = [
		WalkToPointStep.new(points["left"]),
		WaitForTrafficLightStep.new(),
		WalkToPointStep.new(points["right"]),
		WalkToPointStep.new(points["right_exit"]),
	]
	return steps
	
static func law_abiding_right(points: Dictionary) -> Array[BehaviorStep]:
	var steps: Array[BehaviorStep] = [
		WalkToPointStep.new(points["right"]),
		WaitForTrafficLightStep.new(),
		WalkToPointStep.new(points["left"]),
		WalkToPointStep.new(points["left_exit"]),
	]
	return steps

static func jaywalking_left(points: Dictionary) -> Array[BehaviorStep]:
	var steps: Array[BehaviorStep] = [
		WalkToPointStep.new(points["left"]),
		WalkToPointStep.new(points["right"]),
		WalkToPointStep.new(points["right_exit"]),
	]
	return steps
	
static func jaywalking_right(points: Dictionary) -> Array[BehaviorStep]:
	var steps: Array[BehaviorStep] = [
		WalkToPointStep.new(points["right"]),
		WalkToPointStep.new(points["left"]),
		WalkToPointStep.new(points["left_exit"]),
	]
	return steps

static func straight_walking_left(points: Dictionary) -> Array[BehaviorStep]:
	var steps: Array[BehaviorStep] = [
		WalkToPointStep.new(points["left_exit"]),
	]
	return steps

static func straight_walking_right(points: Dictionary) -> Array[BehaviorStep]:
	var steps: Array[BehaviorStep] = [
		WalkToPointStep.new(points["right_exit"]),
	]
	return steps
