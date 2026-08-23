extends CharacterBody2D

var health = 3

var player

func _ready() -> void:
	player = get_node("/root/Game/Player")

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 100.0
	move_and_slide()

func take_damage():
	
	health -= 1
	
	if health == 0:
		queue_free()
	else:
		$AnimatedSprite2D.play("hurt")
