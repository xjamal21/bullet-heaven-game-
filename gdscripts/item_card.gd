extends TextureButton

signal item_clicked(item_data: Dictionary)

@onready var icon_rect: TextureRect = $TextureRect
@onready var name_label: Label = $VBoxContainer/Label

var card_data: Dictionary = {}

func setup(data: Dictionary) -> void:
	card_data = data
	name_label.text = data.get("name", "Item")
	icon_rect.texture = data.get("icon", null)
	
	var loaded_icon = data.get("icon", null)
	print("--- CARD SETUP RUNNING ---")
	print("Loaded icon object is: ", loaded_icon)
	
	icon_rect.texture = loaded_icon
	print("TextureRect actual texture is now: ", icon_rect.texture)
	
	set_meta("category", data.get("category", "General"))
	
func _on_pressed() -> void:
	item_clicked.emit(card_data)


func _on_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.05, 1.05), 0.1)


func _on_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)
