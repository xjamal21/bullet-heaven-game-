extends CanvasLayer

@onready var shop_background: TextureRect = $ShopBackground
@onready var item_grid: GridContainer = $RightSidebar/ScrollContainer/GridContainer
@onready var category_button: Control = $ShopBackground/MainLayout/LeftSidebar/ItemCategory
@onready var shop_ui: CanvasLayer = $ShopUI

@export var item_card_scene: PackedScene = preload("res://tscnfiles/ItemCard.tscn")

var category_background: Dictionary = {
	"Health": preload("res://assets/ui/healthcategory.png"),
	"Attack": preload("res://assets/ui/TESTING.png")
}

var shop_database: Array[Dictionary] = [
	{
		"name": "Health Potion",
		"cost": 50,
		"category": "Health",
		"icon": preload("res://assets/items/gun.png")
	}
]

func _ready() -> void:
	hide()
	populate_shop()
	#filter_items_by_category("Health")
	
	for button in category_button.get_children():
		if button is Button or button is TextureButton:
			button.pressed.connect(func(): _on_category_button_pressed(button))	

func _on_category_button_pressed(clicked_button: Control) -> void:
	var category: String = clicked_button.get_meta("category", clicked_button.name)
	
	if category_background.has(category):
		shop_background.texture = category_background[category]
		
	filter_items_by_category(category)
	
func populate_shop() -> void:
	for child in item_grid.get_children():
		child.queue_free()
	
	for item in shop_database:
		var card = item_card_scene.instantiate()
		item_grid.add_child(card) 
		card.setup(item)
		
		if card.has_signal("item_clicked"):
			card.item_clicked.connect(_on_item_clicked)
			
func filter_items_by_category(category_name: String) -> void:
	for item_card in item_grid.get_children():
		if item_card.has_meta("category"):
			var item_category: String = item_card.get_meta("category")
			item_card.visible = (item_category == category_name)
		else:
			item_card.visible = true
			
func _on_item_clicked(item_data: Dictionary) -> void:
	print("Player clicked on: ", item_data["name"])

func _on_texture_button_pressed() -> void:
	if visible:
		hide()
		get_tree().paused = false
	else:
		show()
		get_tree().paused = true
