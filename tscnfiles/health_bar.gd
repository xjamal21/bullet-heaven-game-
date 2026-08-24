extends TextureProgressBar 

@onready var player = get_node("/root/Game/Player")

func _ready() -> void:
	player.Change_Player_Health.connect(_update_healthbar)
	max_value = player.max_health
	print(max_value)

func _update_healthbar():
	print("Receive update")
	value = player.current_health
