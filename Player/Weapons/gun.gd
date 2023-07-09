extends Node3D

@onready var gun_sprite = $CanvasLayer/Control/GunSprite
@onready var gun_rays = $GunRays.get_children()
@onready var flash = preload("res://Player/Weapons/muzzle_flash.tscn")
@onready var blood = preload("res://Enemy/blood.tscn")
@onready var sound_shoot = $shooting
@onready var sound_no_ammo = $noammo
var can_shoot = true
# Called when the node enters the scene tree for the first time.
func _ready():
	gun_sprite.play("idle")

func check_hit(damage):
	for ray in gun_rays:
		if ray.is_colliding():
			if ray.get_collider().is_in_group("enemy"):
				ray.get_collider().take_damage(damage)
				var new_blood = blood.instantiate()
				ray.get_collider().add_child(new_blood)
				new_blood.global_transform.origin = ray.get_collision_point()
				new_blood.one_shot = true
			if ray.get_collider().is_in_group("env"):
				ray.get_collider().get_hit()
	
func make_flash():
	var f = flash.instantiate()
	add_child(f)

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
			sound_shoot.play()
			gun_sprite.play("shoot")
			make_flash()
			check_hit(damage)
			can_shoot=false
			PlayerStats.WEAPONS[str(PlayerStats.current_gun)]["ammo"] -= ammo_per_use
			await gun_sprite.animation_finished
			gun_sprite.play("idle")
			can_shoot = true
		if usedgun_ammo <= 0 and Input.is_action_just_pressed("shoot"):
			sound_no_ammo.play()
			await sound_no_ammo.finished
	elif PlayerStats.WEAPONS[str(PlayerStats.current_gun)]["type"] == "melee":
		gun_sprite.speed_scale = PlayerStats.WEAPONS[str(PlayerStats.current_gun)]["speed"]
		if Input.is_action_just_pressed("shoot") and can_shoot:
			sound_shoot.play()
			gun_sprite.play("shoot")
			check_hit(damage)
			can_shoot=false
			await gun_sprite.animation_finished
			gun_sprite.play("idle")
			can_shoot = true
