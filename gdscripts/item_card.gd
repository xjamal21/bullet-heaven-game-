extends TextureButton

signal item_clicked(item_data: Dictionary)

@onready var icon_rect: TextureRect = $TextureRect
@onready var name_label: Label = $VBoxContainer/Label

@export var warning_label_path: NodePath
@onready var warning_label: Label = get_node_or_null(warning_label_path)

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
	if not Global.active_player:
		return
		
	var player = Global.active_player
	var item_name = card_data.get("name", "")
	var item_cost = card_data.get("cost", 0)
	
	print("Clicked: ", item_name, " | Cost: ", item_cost, " | Player Bananas: ", player.bananas)
	
	var already_owned = false
	for item in player.inventory:
		var existing_name = item.get("name") if item is Dictionary else item.name
		if existing_name == item_name:
			already_owned = true
			break
			
	if already_owned:
		show_warning("Already Owned")
		return
		
	if player.bananas >= item_cost:
		player.bananas -= item_cost
		
		item_clicked.emit(card_data)
	else:
		show_warning("Not enough bananas!")
		
func show_warning(msg: String) -> void:
	if not warning_label:
		# Search the active scene root directly
		var root = get_tree().current_scene
		warning_label = root.find_child("WarningLabel", true, false)
		
	if warning_label:
		warning_label.text = msg
		warning_label.modulate = Color.RED
		warning_label.visible = true
		
		# Reset timer on repeat clicks
		var tween = create_tween()
		tween.tween_interval(1.5)
		tween.tween_callback(func(): warning_label.visible = false)
	else:
		print("ERROR: Could not find a node named 'WarningLabel' in scene tree")
				
func _on_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.05, 1.05), 0.1)


func _on_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)
