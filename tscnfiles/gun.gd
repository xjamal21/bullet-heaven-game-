extends Area2D

func _physics_process(delta):
	var enemies_range = get_overlapping_bodies()
	if enemies_range.size() > 0:
		var target = enemies_range.front()
		look_at(target.global_position)
		
func shoot():
	const bullets = preload("res://tscnfiles/bullets.tscn")
	var new_bullet = bullets.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	get_tree().root.add_child(new_bullet)

func _on_timer_timeout() -> void:
	shoot()
