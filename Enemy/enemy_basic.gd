extends CharacterBody3D

@onready var nav= $NavigationAgent3D
@onready var anim = $AnimatedSprite3D
@onready var ray = $Visual
@onready var sound_shoot = $sound_shoot
@onready var player = get_tree().get_first_node_in_group("player")


var speed = EnemyStats.ENEMYSTATS["weak"]["speed"]
var health = EnemyStats.ENEMYSTATS["weak"]["health"]
var damage = EnemyStats.ENEMYSTATS["weak"]["damage"]

var move = true
var searching = false
var shooting = false
var dead = false
var new_velocity
var p_visible

func _ready():
	anim.play("walk")

func _physics_process(delta):
	if dead:
		$CollisionShape3D.disabled = true
		return
	if searching and not shooting:
		look_at_player()
		var current_location = global_transform.origin
		var next_location = nav.get_next_path_position()
		new_velocity = (next_location - current_location).normalized() * speed
		nav.set_velocity(new_velocity)
		
func update_target_location(target_location) -> void:
	nav.set_target_position(target_location)
	if ray.is_colliding():
		if ray.get_collider().is_in_group("player"):
			searching = true
			p_visible = true
			
		else:
			searching = false
			p_visible = false
			var check_near = $Aural.get_overlapping_bodies()
			for body in check_near:
				if body.is_in_group("player"):
					searching = true

func look_at_player():
	ray.look_at(player.global_transform.origin)

func take_damage(damage):
	health -=damage
	move = false
	if health <=0:
		death()
	else:
		anim.play("damaged") 
		await anim.animation_finished
		move = true
		_move()
		
func shoot():
	if searching and not dead and not shooting and p_visible:
		move = false
		anim.play("shoot")
		shooting = true
		await anim.frame_changed
		sound_shoot.play()
		if ray.is_colliding() and not dead:
			if ray.get_collider().is_in_group("player"):
				PlayerStats.take_damage(damage)
				await anim.animation_finished
		move = true
		shooting = false
		$shoot_time.start()
	
func death():
	dead = true
	anim.play("death")
	await anim.animation_finished
	call_deferred("queue_free")
	
func _on_navigation_agent_3d_target_reached():
	pass


func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity,0.25)
	_move()

func _move():
	if move:
		anim.play("walk")
		move_and_slide()

func _on_aural_body_entered(body):
	if body.is_in_group("player"):
		searching = true


func _on_shoot_time_timeout():
	shoot()
	
