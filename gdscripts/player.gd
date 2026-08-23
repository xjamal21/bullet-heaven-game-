extends CharacterBody2D

@export var map_min: Vector2 = Vector2(0, 0)
@export var map_max: Vector2 = Vector2(1152, 648)

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	
	velocity = direction * 300
	move_and_slide()
	
	var viewport_rect = get_viewport_rect()
	var margin = 16.0
	global_position.x = clamp(global_position.x, viewport_rect.position.x + margin, viewport_rect.end.x - margin)
	global_position.y = clamp(global_position.y, viewport_rect.position.y + margin, viewport_rect.end.y - margin)
