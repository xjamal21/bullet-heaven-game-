extends CharacterBody2D
var player: Node2D
var health = 3
var strength: int = 10
var points_forkill: int = randi_range(10, 50)

var banana_scene = preload("res://tscnfiles/bananas.tscn")

func _ready() -> void:
	player = get_tree().root.find_child("Player", true, false)
	
func _physics_process(delta: float) -> void:	
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 100.0
	move_and_slide()
	

func take_damage():
	health -= 1
	
	if health == 0:
		spawn_banana()
		get_tree().call_group("score_label", "add_score", points_forkill)
		queue_free()
	else:
		$AnimatedSprite2D.play("hurt")
		
func spawn_banana():
	if banana_scene:
		var banana = banana_scene.instantiate()
		banana.global_position = global_position
		get_tree().root.get_child(0).add_child(banana)


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.take_damage(strength)
		print("Guy took damge")
