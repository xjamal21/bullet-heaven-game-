extends RichTextLabel

@onready var kills_stored = get_node("/root/Game/CanvasLayer/Wave")

func _ready() -> void:
	kills_stored.UpdateKills.connect(_update_kills)

func _update_kills(kills: int):
	print("Label test: " + str(kills))
	text = "Kills: " + str(kills)
	
