# The brick spawner script attaches to a generic Node2D
extends Node2D


# Export variables are editable for instances of the script in the tree

# The number of bricks to place horizontally
export var BRICKS_X = 5
# The number of bricks to place vertically
export var BRICKS_Y = 7
# The spacing between bricks horizontally
export var BRICK_SPACING_X = 35
# The spacing between bricks vertically
export var BRICK_SPACING_Y = 20

# Preload the brick scene to spawn
var brick_scene = preload("res://brick.tscn")


# Called when the node enters the tree at the start of the game
func _ready():
	# Calculate a horizontal offset to center the bricks
	var offset_x = -BRICKS_X / 2.0 * BRICK_SPACING_X + BRICK_SPACING_X / 2.0
	
	# For each column of bricks
	for x in range(0, BRICKS_X):
		# For each row of bricks
		for y in range(0, BRICKS_Y):
			# Instance the brick scene, and add it as a child
			var brick = brick_scene.instance()
			add_child(brick)
			
			# Set the position of the new brick
			brick.position.x = x * BRICK_SPACING_X + offset_x
			brick.position.y = y * BRICK_SPACING_Y
			
			# Set the frame on the new brick's sprite to change coloring
			brick.get_node("Sprite").frame = y
