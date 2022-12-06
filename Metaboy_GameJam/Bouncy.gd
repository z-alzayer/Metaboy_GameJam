extends StaticBody2D
onready var animation = get_node("AnimatedSprite")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.get_class() == "KinematicBody2D":
		body.jump_pad = true
		animation.play("default")


func _on_AnimatedSprite_animation_finished():
	animation.stop()
