extends Node2D

@onready var WaveTracker: int = $CanvasLayer/Wave.wave_count
@onready var EnemySpawnDelay: int = $Timer.wait_time

func _ready() -> void:
	print(EnemySpawnDelay)

func spawn_mob():
	var new_mob = preload("res://tscnfiles/enemies.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	new_mob.add_to_group("enemy_tracker")
	
func kill_all_mob():
	var node_array = get_tree().get_nodes_in_group("enemy_tracker")
	for node in node_array:
		if is_instance_valid(node):
			node.insta_kill()

func _on_timer_timeout() -> void:
	spawn_mob()
