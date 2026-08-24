extends RichTextLabel

var score: int = 0

func _ready() -> void:
	text = "Score: " + str(score)

func add_score(amount: int) -> void:
	score += amount
	text = "Score: " + str(score)
