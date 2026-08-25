extends CanvasLayer

func _ready() -> void:
	self.hide()

func game_over():
	get_tree().paused = true
	self.show()
	
func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://tscnfiles/main_game.tscn")
