extends CanvasLayer

@onready var shop_background: TextureRect = $ShopBackground
@onready var item_grid: GridContainer = $ShopBackground/MainLayout/RightSidebar/ScrollContainer/GridContainer
@onready var category_button: Control = $ShopBackground/MainLayout/LeftSidebar/ItemCategory
@onready var shop_ui: CanvasLayer = $ShopUI

var category_background: Dictionary = {
	"Health": preload("res://assets/ui/healthcategory.png"),
	"Attack": preload("res://assets/ui/TESTING.png")
}

func _ready() -> void:
	hide()
	
	for button in category_button.get_children():
		if button is Button or button is TextureButton:
			button.pressed.connect(func(): _on_category_button_pressed(button))	

func _on_category_button_pressed(clicked_button: Control) -> void:
	var category: String = clicked_button.get_meta("category", clicked_button.name)
	
	if category_background.has(category):
		shop_background.texture = category_background[category]
		
	filter_items_by_category(category)

func filter_items_by_category(category_name: String) -> void:
	for item_card in item_grid.get_children():
		if item_card.has_meta("category"):
			var item_category: String = item_card.get_meta("category")
			item_card.visible = (item_category == category_name)
		else:
			item_card.visible = true

func _on_texture_button_pressed() -> void:
	if visible:
		hide()
		get_tree().paused = false
	else:
		show()
		get_tree().paused = true
