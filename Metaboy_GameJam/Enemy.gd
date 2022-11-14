extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("ready")
	timer.start()
	timer.set_paused(false)




export var speed = 250 # The speed of the character
export var gravity = 40 # The gravity of the character
export var jumpforce = 700 # The jump force of the character
onready var timer = $Timer
onready var jump_timer = $Timer2
var inc_speed = 1
var jump_pad = false
var motion = Vector2.ZERO 
var direction = 1
var random = RandomNumberGenerator.new()
func _physics_process(delta): 


	# Player movement functions:
	motion.x = direction * speed 
	
#	print(motion.x) # then the x coordinates of the vector be positive
	motion.y += gravity + delta
	
	motion = move_and_slide(motion, Vector2.UP)

func _on_Area2D_body_entered(body):
	if body.is_in_group("weapon"):
		queue_free()
	else:
		if body.is_in_group("Player"):
			body.health -= 10


func _on_Timer_timeout():

	direction *= -1


func _on_Timer2_timeout():

	motion.y = -((randi() % 15 + 3) * jumpforce) / 10  
