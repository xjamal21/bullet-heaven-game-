extends GridContainer

func toggle_inventory() -> void:
	visible = !visible


func _on_button_pressed() -> void:
	toggle_inventory()
