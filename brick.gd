# The brick script defines a specific class name
class_name Brick
# And attaches to a KinematicBody2D
extends StaticBody2D


# Define a custom function to destroy the brick
func destroy():
	# Soft delete - remove from the collision layers, make the sprite invisible
	# The brick remains in the tree so the particles stay visible
	collision_layer = 0
	collision_mask = 0
	$Sprite.visible = false
	
	# Emit the explosion particles
	$Explosion.emitting = true
