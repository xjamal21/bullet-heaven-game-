extends CharacterBody2D
var player: Node2D
var health = 3
var strength: int = 10
var score: int = 0
var scoreforkill: int = randi_range(10, 100)

func _ready() -> void:
	player = get_tree().root.find_child("Player", true, false)
	
	
func _physics_process(delta: float) -> void:	
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 100.0
	move_and_slide()
	

func take_damage():
	
	health -= 1
	
	if health <= 0:
		print("Mob died")
		get_tree().call_group("score_label", "add_score", scoreforkill)
		queue_free()
	else:
		$AnimatedSprite2D.play("hurt")


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.take_damage(strength)
		print("Guy took damge")

func set_score(amount: int) -> void:
	score += amount
	pass
