extends Control

func _ready():
	pass
	
func _process(delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://tscnfiles/main_game.tscn")
