extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var label = $Score
onready var coin = $Coins
onready var health = $Health
onready var player = get_node("../../Player")




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.set_text("Score: " + str(round(player.position.x)))
	coin.set_text("Coins: " + str(round(player.coins)))
	health.set_text("Health: " + str(round(player.health)))
