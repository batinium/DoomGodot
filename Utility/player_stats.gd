extends Node

@onready var pistol = preload("res://Player/Weapons/pistol.tscn")
@onready var shotgun = preload("res://Player/Weapons/shotgun.tscn")
@onready var fastgun = preload("res://Player/Weapons/heavygun.tscn")
@onready var cannon_launcher = preload("res://Player/Weapons/cannon_launcher.tscn")
@onready var melee = preload("res://Player/Weapons/melee.tscn")
@onready var firewand = preload("res://Player/Weapons/firecrystal/fire_wand.tscn")
@onready var carriedguns = []
var pistol_speed = 2

var health = 100
var max_health = 200
var armor = 0
var max_armor = 100
var stamina = 100
var guns_carried = []

var red_key = false
var blue_key =false
var yellow_key = false
var current_gun = null
var coins = 0

var WEAPONS = {
	"pistol":{
		"ammo" : 50,
		"max_ammo": 200,
		"damage":5,
		"ammo_use":1,
		"speed": 2,
		"type":"gun",
	},
	"shotgun":{
		"ammo":16,
		"max_ammo":100,
		"damage":10,
		"ammo_use":2,
		"speed":1,
		"type":"gun",
	},
	"cannonball":{
		"ammo":10,
		"max_ammo":50,
		"damage":50,
		"ammo_use":1,
		"speed":2,
		"type":"gun",
	},
	"heavygun":{
		"ammo":200,
		"max_ammo":800,
		"damage": 8,
		"ammo_use":1,
		"speed":0.5,
		"type":"gun",
	},
	"melee":{
		"ammo":0,
		"max_ammo":0,
		"damage": 25,
		"ammo_use":1,
		"speed":1,
		"type":"melee",
	},
	"firewand":{
		"ammo":15,
		"max_ammo":23,
		"damage": 5,
		"ammo_use":1,
		"speed":1,
		"type":"gun",
	}
}

func reset():
	var health = 100
	var max_health = 200
	var armor = 0
	var max_armor = 100
	var guns_carried = []

	var red_key = false
	var blue_key =false
	var yellow_key = false
	var current_gun ="pistol"
	var coins = 0
	
func _ready():
	pass

func take_damage(amount):
	if amount > armor:
		var dmg = amount - armor
		amount -=armor
		armor = 0
		health -= dmg
		
	else:
		change_armor(-amount)
		return

func change_health(amount):
	health +=amount
	health = clamp(health,0,max_health)
	
func change_armor(amount):
	armor +=amount
	armor = clamp(armor,0,max_armor)

func get_health():
	return str(health)
func get_armor():
	return str(armor)

