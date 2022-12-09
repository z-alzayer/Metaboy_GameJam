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
var farthest_tile_pos
var tile_tracker = 1
onready var timer = $GenPlatforms
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
	rand_y = randi() % 3
	bounce_pos_gen = tile.to_global(tile.map_to_world(Vector2(x+counter - rand_y , y)))
	final_x_distance = x + counter
	return final_x_distance
	
func add_chunk(pos):
	var chunk = level_chunk.instance()
	chunk.position = pos
	farthest_tile_pos = (chunk.get_node("Position2D"))
	print(farthest_tile_pos.position)
	add_child(chunk)

func add_chunk_2(pos):
	var chunk = level_chunk2.instance()
	chunk.position = pos
	farthest_tile_pos = (chunk.get_node("Position2D"))
	add_child(chunk)	
	
func make_platform_bouncy(rand_y):
	rand_y = randi() % 4
	if rand_y < 2:
		var bouncer = bouncy.instance()
		add_child(bouncer)

		bouncer.position = bounce_pos_gen
		bouncer.position.y -= 20

# Called when the node enters the scene tree for the first time.
func _ready():
	#final_x_distance = make_platform(final_x_distance, 5, 	(randi() % 20))
	#final_x_distance = make_platform(final_x_distance , 9, 3)
	add_chunk_2(Vector2(-200,0))
	tile_pos = tile.world_to_map(player.position).x - 10
	y_pos = 9
	timer.start()
	for i in range(1, 300):
		final_x_distance = make_platform(i * 5 , 9, 	3)
		make_platform_bouncy(rand_y)
	#add_chunk(Vector2(0,0))
	#add_chunk_2(Vector2(700, 0))
func make_more_platforms(distance, length):
	if (player.position.x + distance) < final_x_distance:
		for i in range(1, 300):
			final_x_distance = make_platform(i * 5 , 9, 	length)
			make_platform_bouncy(rand_y)
			
func make_level_section():
	rand_y = randi() % 4
	if rand_y == 1:
		rand_y = randi() % 50
		add_chunk_2(Vector2(farthest_tile_pos.position.x * tile_tracker, 0 + rand_y))

	elif rand_y == 2:
		rand_y = randi() % 50
		add_chunk(Vector2(farthest_tile_pos.position.x * tile_tracker, 0 + rand_y))	
		#print(player.position.x)
	tile_tracker += 1
	made_tile = false


func _process(delta):
	time_sum += delta

	tile_pos = tile.world_to_map(player.position).x 
	if made_tile == true:
		make_level_section()
		timer.start()
	
	make_more_platforms(3000, 300)
	



func _on_GenPlatforms_timeout():
	made_tile = true
