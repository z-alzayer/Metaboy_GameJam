extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var timer = $Timer


# Called every frame. 'delta' is the elapsed time since the previous frame.

var thrust = Vector2(5000, -50)
var torque = 1

func _ready():
	self.position.x = self.position.x + 0.1
	timer.start()
func _physics_process(delta):
	applied_torque = 1 * torque
	self.applied_force = thrust


func _on_Timer_timeout():
	queue_free()
