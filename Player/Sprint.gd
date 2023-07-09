extends Node


@export_node_path("MovementController") var controller_path := NodePath("../")
@onready var controller: MovementController = get_node(controller_path)

@export_node_path("Node3D") var head_path := NodePath("../Head")
@onready var cam: Camera3D = get_node(head_path).cam

@export var sprint_speed := 16
@export var fov_multiplier := 1.05
@onready var normal_speed: int = controller.speed
@onready var normal_fov: float = cam.fov
@onready var sprint_timeout = $"../sprint_reload"
var can_sprint = true

# Called every physics tick. 'delta' is constant
func _physics_process(delta: float) -> void:
	
	if controller.is_on_floor() and Input.is_action_pressed(&"sprint") and controller.input_axis.x >= 0.5 and PlayerStats.stamina > 0 and can_sprint:
		controller.speed = sprint_speed
		cam.set_fov(lerp(cam.fov, normal_fov * fov_multiplier, delta * 8))
		PlayerStats.stamina -= 0.3
		
	else:
		controller.speed = normal_speed
		cam.set_fov(lerp(cam.fov, normal_fov, delta * 8))
		if PlayerStats.stamina < 100:
			PlayerStats.stamina +=0.02
	if PlayerStats.stamina < 0:
		can_sprint = false
		sprint_timeout.start()


func _on_sprint_reload_timeout():
	can_sprint = true
