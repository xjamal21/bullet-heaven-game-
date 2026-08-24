extends RichTextLabel

var score: int = 0

func add_score(amount: int) -> void:
	score += amount
	text = "Score: " + str(score)
	
