# The ball script defines a specific class name
class_name Ball
# The ball script attaches to a KinematicBody2D
extends KinematicBody2D


# The speed at which the ball moves
const SPEED = 2.0

# The current velocity of the ball
var velocity = Vector2.ZERO

# Flag set when the game starts
var started = false
# The initial position of the ball
var init_pos

# Constant path to the ball scene
const BALL_SCENE_PATH = "res://ball.tscn"
# Loaded ball scene used for spawning
var ball_scene


# Called when the node is spawned and enters the tree
func _ready():
	# Save initial position
	init_pos = position
	# Load the ball scene for future spawns
	# We have to do this instead of using preload()
	# because this script is a dependency of the ball scene
	ball_scene = load(BALL_SCENE_PATH)

# Called each physics frame (exactly 60 FPS)
func _physics_process(delta):
	# If we haven't started moving
	if not started:
		# And the player is pressing a move action
		if Input.get_action_strength("move_left") > 0 or Input.get_action_raw_strength("move_right") > 0:
			# Call our custom function to start moving
			start()
	
	# Move along velocity vector and check for collision
	var collision = move_and_collide(velocity)
	# If we hit something
	if collision != null:
		# Bounce along the normal of the object we hit
		velocity = velocity.bounce(collision.normal)
		# If the object we hit is a brick
		if collision.collider is Brick:
			# Call the brick's destroy methog
			collision.collider.destroy()
			# A random number of times from 1 to 3
			for i in range(0, randi() % 3 + 1):
				# Spawn another ball
				spawn_ball()
		
		# Hack to check if object we hit is another ball
		# We can't use the Ball class here
		# because that would be a circular reference
		# This problem is fixed in Godot 4.0 or by using C# scripting
		if collision.collider.has_method("reset"):
			# If a random chance is less that 0.3
			if randf() < 0.3:
				# Remove the other ball
				collision.collider.queue_free()
			# Otherwise
			else:
				# If a random chance is less than 0.05
				if randf() < 0.05:
					# Spawn another ball
					spawn_ball()

# Custom function to spawn another ball at our position
func spawn_ball():
	# Instance the ball scene, and add it as a child of our parent
	# We add to parent instead of ourselves here, because otherwise
	# the movement of this ball would affect the new one
	var ball_instance = ball_scene.instance()
	get_parent().add_child(ball_instance)
	
	# Set the new ball's position to ours plus a random offset
	ball_instance.position = position + Vector2(randf(), randf())
	# Start the new ball moving
	ball_instance.start()

# Custom function to set the started flag and start moving
func start():
	# Set velocity to a random upwards direction
	velocity = Vector2(randf(), -1).normalized() * SPEED
	# Set the started flag
	started = true

# Custom functiont to reset
func reset():
	# Return to initial position
	position = init_pos
	# Clear started flag
	started = false
	# Set velocity to zero
	velocity = Vector2.ZERO
