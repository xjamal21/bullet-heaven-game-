extends Area2D

func _physics_process(delta):
	var enemies_range = get_overlapping_bodies()
	if enemies_range.size() > 0:
		var target = enemies_range.front()
		print("Targeting enemy at: ", target.global_position)
		look_at(target.global_position)
