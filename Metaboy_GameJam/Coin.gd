extends Node2D


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
	print("Coin_Collected")
	if body.is_in_group("Player"):
		if self.is_in_group("donut"):
			body.coins += 50
			if body.health < 100:
				body.health += 10
		else:
			body.coins += 1
		queue_free()
