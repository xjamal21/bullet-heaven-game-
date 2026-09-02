class_name Player
extends CharacterBody2D

@export var map_min: Vector2 = Vector2(0, 0)
@export var map_max: Vector2 = Vector2(1152, 648)
@export var max_health: int = 100
@export var current_health: int
@export var SPEED: float = 200.0
@export var armor: float = 10.0
const JUMP_VELOCITY = -400.0
var bananas: int = 100
var strength: int = 10

var inventory: Array[ItemData] = []
@export var max_slots: int = 6

signal inventory_changed
signal Change_Player_Health

func _ready() -> void:
	Global.active_player = self
	current_health = max_health
	
func take_damage(amount: int) -> void: 
	current_health -= amount
	Change_Player_Health.emit()
	print("Taken", amount, "damage.")
	
	if current_health <= 0:
		die()
		get_node("../GameOver").game_over()
	
func die() -> void:
	print("player died")
	queue_free()


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	
	velocity = direction * 300
	move_and_slide()
	
	var viewport_rect = get_viewport_rect()
	var margin = 16.0
	global_position.x = clamp(global_position.x, viewport_rect.position.x + margin, viewport_rect.end.x - margin)
	global_position.y = clamp(global_position.y, viewport_rect.position.y + margin, viewport_rect.end.y - margin)


func apply_item_stats(item) -> bool:
	if inventory.size() < max_slots:
		inventory.append(item)
		item_effects(item)
		inventory_changed.emit()
		return true
	
	else:
		return false
		
func item_effects(item) -> void:
	var stats = item.get("stat_boost", {}) if item is Dictionary else item.stat_boost
	
	if stats.has("speed"):
		SPEED += stats["speed"]
		
		
