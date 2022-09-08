# The paddle script is attached to a KinematicBody2D
extends KinematicBody2D


# The speed at which the paddle moves
const SPEED = 5.0


# Called each physics frame (exactly 60 FPS)
func _physics_process(delta):
	# Get the direction the player is inputting
	# Action Strength = 1.0 for a pressed key, 0.0 for a unpressed key
	var dir = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	# Move in the requested direction, stopping on physics objects
	move_and_collide(dir * SPEED * Vector2.RIGHT)
