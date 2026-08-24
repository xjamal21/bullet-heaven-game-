extends Area2D

var player: Node2D
@export var magnet_speed: float = 300.0
@export var magnet_distance: float = 100.0

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
func _physics_process(delta: float) -> void:
	if is_instance_valid(player):
		var dist = global_position.distance_to(player.global_position)
		
		if dist <= magnet_distance:
			var direction = global_position.direction_to(player.global_position)
			global_position += direction * magnet_speed * delta
		
		if dist < 15.0:
			collect_banana(player)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") or body.name == "Player":
		collect_banana(body)

func collect_banana(body_node: Node2D) -> void:
	if "bananas" in body_node:
		body_node.bananas += 1
	queue_free()
