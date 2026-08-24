extends RichTextLabel

@export var wave_count: int = 1
@export var enemies_killed: int = 0
var enemies_required: int = 2
var Pi_Values: String = str(PI)
var pi_num: int = 0
@onready var EnemySpawnDelay = get_node("/root/Game/Timer")

signal UpdateKills(killed: int)

func _ready() -> void:
	text = "Wave: " + str(wave_count)
	Pi_Values = Pi_Values.replace(".", "")
	print(Pi_Values)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func wave_clear_check() -> void:
	enemies_killed += 1
	UpdateKills.emit(enemies_killed)
	print("killed", enemies_killed)
	if enemies_killed == enemies_required:
		print("Wave", wave_count, "cleared")
		if pi_num > 15:
			pi_num = 0
		if int(Pi_Values[pi_num]) == 1:
			enemies_required += (int(Pi_Values[pi_num]) * 3)
		else:
			enemies_required += (int(Pi_Values[pi_num]) * 2)
		print(enemies_required, "for next wave")
		wave_count += 1
		pi_num += 1
		text = "Wave: " + str(wave_count)
		if EnemySpawnDelay.wait_time > 1.5:
			EnemySpawnDelay.start(EnemySpawnDelay.wait_time - 0.5)
		elif EnemySpawnDelay.wait_time > 1 and EnemySpawnDelay.wait_time != 0.6:
			EnemySpawnDelay.start(EnemySpawnDelay.wait_time - 0.05)
		
			
