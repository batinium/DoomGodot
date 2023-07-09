extends Area3D
@onready var anim = $AnimatedSprite3D
var state = 0
var give_damage = false
var damage = 50
# Called when the node enters the scene tree for the first time.

func _ready():
	anim.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_hit():
	state +=1
	match state:
		1:
			anim.play("1")
		2:
			anim.play("2")
		3:
			anim.play("3")
			if give_damage == true:
				PlayerStats.take_damage(damage)
			await anim.animation_finished
			queue_free()
	

func _on_damage_body_entered(body):
		if body.is_in_group("player"):
			give_damage = true
