extends RichTextLabel

var player: Node2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	if not is_instance_valid(player):
		player = get_tree().get_first_node_in_group("player")
		return
	
	if "bananas" in player:
		text = "Bananas: " + str(player.bananas)
