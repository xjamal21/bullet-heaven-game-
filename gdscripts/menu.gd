extends CanvasLayer

func _ready() -> void:

	visible = false

func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("pause"):
		togglepause()

		get_viewport().set_input_as_handled()

func togglepause() -> void:
	visible = !visible
	get_tree().paused = visible 
	
	
func _on_resume_pressed() -> void:
	togglepause()
	

func _on_settings_logo_pressed() -> void:
	togglepause()

func _on_main_menu_pressed() -> void:
	togglepause()
	get_tree().change_scene_to_file("res://tscnfiles/main_menu.tscn")
