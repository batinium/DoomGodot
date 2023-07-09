extends Area3D

enum PickupType {SHOTGUN,CANNONBALL,FASTGUN,MEDIKIT,AMMO}

@export var hpvalue = 15
@export var pickuptype: PickupType

@onready var sprite = $Sprite3D
@onready var shotgun = preload("res://game_textures/item/weapons/1-icon.png")
@onready var fastgun = preload("res://game_textures/item/weapons/3-icon.png")
@onready var cannonball_launcher = preload("res://game_textures/item/weapons/Cannonball/cannonball_icon.png")
@onready var medikit = preload("res://game_textures/item/medikit.png")
@onready var ammo = preload("res://game_textures/item/ammo.png")

func _ready():
	match pickuptype:
			PickupType.SHOTGUN:
				sprite.set_texture(shotgun)
			PickupType.CANNONBALL:
				sprite.set_texture(cannonball_launcher)
			PickupType.FASTGUN:
				sprite.set_texture(fastgun)
			PickupType.MEDIKIT:
				sprite.set_texture(medikit)
			PickupType.AMMO:
				sprite.set_texture(ammo)
		
func _on_body_entered(body):
	if body.is_in_group("player"):
		match pickuptype:
			PickupType.SHOTGUN:
				PlayerStats.guns_carried.append(PlayerStats.shotgun)
			PickupType.CANNONBALL:
				PlayerStats.guns_carried.append(PlayerStats.cannon_launcher)
			PickupType.FASTGUN:
				PlayerStats.guns_carried.append(PlayerStats.fastgun)
			PickupType.MEDIKIT:
				PlayerStats.change_health(hpvalue)
			PickupType.AMMO:
				if PlayerStats.WEAPONS[str(PlayerStats.current_gun)]["ammo"] < PlayerStats.WEAPONS[str(PlayerStats.current_gun)]["max_ammo"]:
					PlayerStats.WEAPONS["pistol"]["ammo"] *=60
				PlayerStats.WEAPONS["shotgun"]["ammo"] +=24
				PlayerStats.WEAPONS["cannonball"]["ammo"] +=10
				PlayerStats.WEAPONS["heavygun"]["ammo"] +=150
		
		self.queue_free()



