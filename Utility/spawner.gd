extends Node3D

enum SpawnType {ENEMY,BARREL}

@export var spawntype: SpawnType
@export var manytospawn = 0
@onready var enemy = preload("res://Enemy/enemy_basic.tscn")
@onready var barrel = preload("res://Utility/props/explosive_barrel.tscn")

@onready var itemtospawn
@onready var spawntimer = $Timer
@onready var spawn_location = $Marker3D
# Called when the node enters the scene tree for the first time.

func _ready():
	match spawntype:
		SpawnType.ENEMY:
			itemtospawn = enemy
		SpawnType.BARREL:
			itemtospawn = barrel


func _on_timer_timeout():
	if self.get_child_count() < manytospawn + 2:
		var new_item = itemtospawn.instantiate()
		self.add_child(new_item)
		new_item.global_transform = spawn_location.global_transform
		self.add_child(new_item)
		spawntimer.start()
