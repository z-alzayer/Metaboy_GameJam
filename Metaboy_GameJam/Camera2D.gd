extends Camera2D



onready var player = $"../Player"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if player.position.x > self.position.x:

		self.position.x = lerp(self.position.x, player.position.x, .11)
