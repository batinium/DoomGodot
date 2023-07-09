extends Node3D
@onready var anim = $AnimationPlayer
@onready var timer =$Timer
# Called when the node enters the scene tree for the first time.



func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		anim.play("dooropen")
		timer.start()
			
		


func _on_timer_timeout():
	anim.play("doorclose")
