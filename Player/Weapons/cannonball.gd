extends Area3D
var cannon_speed = 30
var cannon_damage = PlayerStats.WEAPONS["cannonball"]["damage"]
var cannon_splash = 10
@onready var anim = $AnimatedSprite3D

func deal_damage():
	var enemies = $".".get_overlapping_bodies()
	for body in enemies:
		if body.is_in_group("enemy"):
			body.take_damage(cannon_damage)
	enemies = $splashdamage.get_overlapping_bodies()
	for body in enemies:
		if body.is_in_group("enemy"):
			body.take_damage(cannon_splash)

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(Vector3(0,0.02,-1) * cannon_speed * delta)


func _on_body_entered(body):
	explode()


func _on_splashdamage_body_entered(body):
	pass # Replace with function body.

func explode():
	set_process(false)
	anim.play("explode")
	deal_damage()
	$explosion.play()
	await anim.animation_finished
	queue_free()

func _on_timer_timeout():
	explode()
