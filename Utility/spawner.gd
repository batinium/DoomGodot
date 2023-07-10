extends Node3D

@onready var enemy = preload("res://Enemy/enemy_basic.tscn")
@onready var spawntimer = $Timer
@onready var spawn_location = $Marker3D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if self.get_child_count() < 4:
		var new_enemy = enemy.instantiate()
		self.add_child(new_enemy)
		new_enemy.global_transform = spawn_location.global_transform
		self.add_child(new_enemy)
		spawntimer.start()
