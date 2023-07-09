extends Node3D

@onready var gun_sprite = $CanvasLayer/Control/GunSprite
@onready var spawn_location = $Marker3D
@onready var cannonball =preload("res://Player/Weapons/cannonball.tscn")

var damage = PlayerStats.WEAPONS[str(PlayerStats.current_gun)]["damage"]
var ammo_per_use = PlayerStats.WEAPONS[str(PlayerStats.current_gun)]["ammo_use"]

var can_shoot = true

func launch_projectile():
	var new_cannonball = cannonball.instantiate()
	get_node("/root/World").add_child(new_cannonball)
	new_cannonball.global_transform = spawn_location.global_transform
	$Marker3D/shoot.play()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var damage = PlayerStats.WEAPONS[str(PlayerStats.current_gun)]["damage"]
	var ammo_per_use = PlayerStats.WEAPONS[str(PlayerStats.current_gun)]["ammo_use"]
	var usedgun_ammo = PlayerStats.WEAPONS[str(PlayerStats.current_gun)]["ammo"]
	var max_ammo = PlayerStats.WEAPONS[str(PlayerStats.current_gun)]["max_ammo"]
	if usedgun_ammo > max_ammo:
		PlayerStats.WEAPONS[str(PlayerStats.current_gun)]["ammo"] = PlayerStats.WEAPONS[str(PlayerStats.current_gun)]["max_ammo"]
	if PlayerStats.WEAPONS[str(PlayerStats.current_gun)]["type"] == "gun":
		gun_sprite.speed_scale = PlayerStats.WEAPONS[str(PlayerStats.current_gun)]["speed"]
		if Input.is_action_pressed("shoot") and can_shoot and usedgun_ammo> 0:
			gun_sprite.play("shoot")
			launch_projectile()
			can_shoot = false
			PlayerStats.WEAPONS[str(PlayerStats.current_gun)]["ammo"] -= ammo_per_use
			await gun_sprite.animation_finished
			can_shoot=true
			gun_sprite.play("idle")
