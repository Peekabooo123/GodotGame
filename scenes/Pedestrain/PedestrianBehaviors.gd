class_name PedestrianBehaviors
extends RefCounted

static func law_abiding_left(points: Dictionary) -> Array[BehaviorStep]:
	var steps: Array[BehaviorStep] = [
		WalkToPointStep.new(points["wait_left"]),
		WaitForTrafficLightStep.new(),
		WalkToPointStep.new(points["wait_right"]),
		WalkToPointStep.new(points["right_exit_bottom"]),
	]
	return steps
	
static func law_abiding_right(points: Dictionary) -> Array[BehaviorStep]:
	var steps: Array[BehaviorStep] = [
		WalkToPointStep.new(points["wait_right"]),
		WaitForTrafficLightStep.new(),
		WalkToPointStep.new(points["wait_left"]),
		WalkToPointStep.new(points["left_exit_bottom"]),
	]
	return steps


static func jaywalking_left(points: Dictionary) -> Array[BehaviorStep]:
	var steps: Array[BehaviorStep] = [
		WalkToPointStep.new(points["wait_left"]),
		WalkToPointStep.new(points["wait_right"]),
		WalkToPointStep.new(points["right_exit_bottom"]),
	]
	return steps
	
static func jaywalking_right(points: Dictionary) -> Array[BehaviorStep]:
	var steps: Array[BehaviorStep] = [
		WalkToPointStep.new(points["wait_right"]),
		WalkToPointStep.new(points["wait_left"]),
		WalkToPointStep.new(points["left_exit_bottom"]),
	]
	return steps

static func straight_walking_across_left(points: Dictionary) -> Array[BehaviorStep]:
	var steps: Array[BehaviorStep] = [
		WalkToPointStep.new(points["decision_point_left"]),
		WalkToPointStep.new(points["decision_left_to_right"]),
		WalkToPointStep.new(points["right_exit_bottom"]),
	]
	return steps
	
static func straight_walking_across_right(points: Dictionary) -> Array[BehaviorStep]:
	var steps: Array[BehaviorStep] = [
		WalkToPointStep.new(points["decision_point_right"]),
		WalkToPointStep.new(points["decision_right_to_left"]),
		WalkToPointStep.new(points["left_exit_bottom"]),
	]
	return steps


static func straight_walking_left(points: Dictionary) -> Array[BehaviorStep]:
	var steps: Array[BehaviorStep] = [
		WalkToPointStep.new(points["left_exit_bottom"]),
	]
	return steps

static func straight_walking_right(points: Dictionary) -> Array[BehaviorStep]:
	var steps: Array[BehaviorStep] = [
		WalkToPointStep.new(points["right_exit_bottom"]),
	]
	return steps
