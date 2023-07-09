extends CanvasLayer

@onready var armor = $MarginContainer/HBoxContainer/Values/armorvalue
@onready var health = $MarginContainer/HBoxContainer/Values/healthvalue
@onready var ammo = $MarginContainer/HBoxContainer/Ammo/ammovalue
@onready var healthbar = $MarginContainer/HBoxContainer/Ammo/HealthBar
@onready var staminabar =$MarginContainer/HBoxContainer/Ammo/StaminaBar
func _process(delta):
	armor.text = str(PlayerStats.get_armor())
	health.text = str(PlayerStats.get_health())
	ammo.text = str(PlayerStats.WEAPONS[str(PlayerStats.current_gun)]["ammo"])
	healthbar.value = PlayerStats.health
	staminabar.value = PlayerStats.stamina


func _on_shoot_button_down():
	Input.action_press("shoot")


func _on_changegun_button_down():
	Input.action_press("next_gun")


func _on_run_button_down():
	Input.action_press("sprint")


func _on_jump_button_down():
	Input.action_press("jump")
