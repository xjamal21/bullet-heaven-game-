extends Button

signal item_clicked(item_data: Dictionary)

@onready var icon_rect: TextureRect = $VBoxContainer/TextureRect
@onready var name_label: Label = $VBoxContainer/Label
@onready var desc_label: Label = $VBoxContainer/Label2

var card_data: Dictionary = {}

func setup(data: Dictionary) -> void:
	card_data = data
	name_label.text = data.get("name", "Item")
	desc_label.text = data.get("description", "")
	icon_rect.texture = data.get("icon", null)
	
	var loaded_icon = data.get("icon", null)
	print("--- CARD SETUP RUNNING ---")
	print("Loaded icon object is: ", loaded_icon)
	
	icon_rect.texture = loaded_icon
	print("TextureRect actual texture is now: ", icon_rect.texture)
	
	set_meta("category", data.get("category", "General"))
	
func _on_pressed() -> void:
	item_clicked.emit(card_data)
