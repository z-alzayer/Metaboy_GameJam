extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var tile = $TileMap
var counter
var final_x_distance = 0
onready var player = $Player
var made_tile = true
var tile_pos
var rand_y
var y_pos
var level_chunk = load("res://Level_Chunks/Level_Chunk_1.tscn")
var level_chunk2 = load("res://Level_Chunks/Level_Chunk_2.tscn")
var random = RandomNumberGenerator.new()
var time_sum = 0
var bouncy = load("res://Bouncy.tscn")
var bounce_pos_gen

#random.randomize()

func make_platform(x, y, length):
	tile.set_cell(x, y, 24)
	counter = 1
	while counter < length:
		tile.set_cell(x + counter, y, 25)
		counter += 1
	tile.set_cell(x + counter, y, 27)

	bounce_pos_gen = tile.to_global(tile.map_to_world(Vector2(x+counter , y)))
	final_x_distance = x + counter
	return final_x_distance
	
func add_chunk(pos):
	var chunk = level_chunk.instance()
	chunk.position = pos
	add_child(chunk)

func add_chunk_2(pos):
	var chunk = level_chunk2.instance()
	chunk.position = pos
	add_child(chunk)	
	
func make_platform_bouncy(rand_y):
	var bouncer = bouncy.instance()
	add_child(bouncer)
	print(bounce_pos_gen)
	bouncer.position = bounce_pos_gen
	bouncer.position.y -= 20
	print(bouncer.position)
# Called when the node enters the scene tree for the first time.
func _ready():
	#final_x_distance = make_platform(final_x_distance, 5, 	(randi() % 20))
	final_x_distance = make_platform(final_x_distance , 9, 3)
	tile_pos = tile.world_to_map(player.position).x - 10
	y_pos = 9
	add_chunk(Vector2(0,0))
	add_chunk_2(Vector2(700, 0))
	
func _process(delta):

	if player.position.x > tile_pos and made_tile:
		rand_y = randi() % 3
		final_x_distance = make_platform(final_x_distance + tile_pos , y_pos - rand_y, 	3)
		#if rand_y >= 0:
		make_platform_bouncy(rand_y)
		made_tile = false
	if int(player.position.x) % int(500) == 0:
		add_chunk_2(Vector2(player.position.x + 500, 0))
	if int(player.position.x) % int(300) == 0:
		add_chunk(Vector2(player.position.x + 500, 0))	
		#print(player.position.x)
		made_tile = false
	time_sum += delta
	if int(time_sum) % 50 == 0:
		made_tile = true
		tile_pos = tile.world_to_map(player.position).x 

		#print(tile_pos)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
