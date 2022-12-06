extends KinematicBody2D

# Adjustable variables of the player
# export is used to allow to edit the values outside the script
export var speed = 300 # The speed of the character
export var gravity = 40 # The gravity of the character
export var jumpforce = 700 # The jump force of the character
onready var player_vars = get_node("../Variables")
onready var animation = $AnimatedSprite
onready var atk_timer = $AttackTimer
onready var win_pos = get_node("../Position2D")
onready var attack_pos = get_node("Position2D")
const arrow = preload("res://Arrow.tscn")

var attack_possible = true
var coins = 0
var inc_speed = 1
var jump_pad = false
var motion = Vector2.ZERO 
var attack = false
var health = 100

func makeArrow():
	if attack_possible:
		var arrow_inst = arrow.instance()
		arrow_inst.position = attack_pos.position
#		arrow_inst.position.x = self.position.x + 0.01 
		self.add_child(arrow_inst)
		attack_possible = false

func gameOver():
	if health <= 0 or position.y > 1000:
		get_tree().change_scene("res://GameOver.tscn")

		
func _ready():
	animation.play("run")

func _physics_process(delta): 



	if (player_vars == null):
		if position.x > 980:
			position.x = 70 
	inc_speed += delta
	# Player movement functions:
	motion.x = speed + (inc_speed * 3)
#	print(motion.x) # then the x coordinates of the vector be positive
	if Input.is_action_pressed("ui_left") and attack_possible: # If the player enters the left arrow
		motion.x = -10 # then the x coordinates of the vector be negative
		animation.play("attack_no_arrow")
		makeArrow()
		attack = true
	elif Input.is_action_pressed("ui_right"):
		motion.x += 150
		motion.x = lerp(motion.x, 0, 0.25)
		print("dashing")
	else: # If none of these are pressed
		if player_vars != null:
			motion.x = lerp(motion.x, 0, 0.25) # set the x to 0 by smoothly transitioning by 0.25
		elif player_vars == null and Input.is_action_pressed("ui_left"):
			motion.x -= 100
			motion.x = lerp(motion.x, 0, 0.25)	
	
	if is_on_floor(): # If the ground checker is colliding with the ground
		if Input.is_action_pressed("ui_up"): # And the player hits the up arrow key

			motion.y = -jumpforce # then jump by jumpforce
	
	motion.y += gravity + delta # Always make the player fall down
	
	if jump_pad == true:
		motion.y = -jumpforce * 1.5
		jump_pad = false
	motion = move_and_slide(motion, Vector2.UP)
	# Move and slide is a function which allows the kinematic body to detect
	# collisions and move accordingly
	
	gameOver()
func on_change():
	if coins > 0:
		pass



func _on_AnimatedSprite_animation_finished():
	if attack == true:
		animation.play('run')
		attack = false


func _on_AttackTimer_timeout():
	attack_possible = true



func _on_Win_body_entered(body):
	if body.is_in_group("Player"):
		speed = 0
		animation.stop()
		get_tree().change_scene("res://Win.tscn")
