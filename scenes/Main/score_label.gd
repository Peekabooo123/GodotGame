extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
var score: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_score()
	Eventbus.score_changed.connect(add_score)

func add_score(amount: int):
	score += amount
	_update_score()

func minus_score(amount: int):
	score -= amount
	_update_score()

func _update_score():
	score_label.text = "Score: %d" % score
	
