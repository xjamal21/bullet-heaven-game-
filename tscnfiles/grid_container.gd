extends GridContainer

@onready var health_label: Label = $Health
@onready var magicpower: Label = $MP
@onready var attackdmg_label: Label = $Attack
@onready var currency: Label = $Currency
@onready var ms_label: Label = $Speed

func _ready() -> void:
	call_deferred("setup_stats")
	
func setup_stats() -> void:
	if Global.active_player:
		Global.active_player.inventory_changed.connect(update_stat_labels)
		
		if Global.active_player.has_signal("Change_Player_Health"):
			Global.active_player.Change_Player_Health.connect(update_stat_labels)
			
		update_stat_labels()
		
func update_stat_labels() -> void: 
	if not Global.active_player: 
		return 
		
	var p = Global.active_player
	
	health_label.text = "Health : " + str(p.current_health) + "/" + str(p.max_health)
	magicpower.text = "Magic Power : " + str(p.get("magic_power") if "magic_power" in p else 0)
	attackdmg_label.text = "Attack Damage : " + str(p.strength)
	currency.text = "Bananas : " + str(p.bananas)
	ms_label.text = "Speed : " + str(p.SPEED)
