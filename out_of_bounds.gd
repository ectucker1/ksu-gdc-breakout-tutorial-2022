# The out of bounds script attaches to an Area2D
extends Area2D


# Called when the node enters the tree at the start of the game
func _ready():
	# Connect the Area2D signal for a body entering to our own function
	connect("body_entered", self, "our_body_entered")

# Custom function to be connected to a signal
func our_body_entered(body):
	# If the body that entered it a ball
	if body is Ball:
		# Reset the ball
		body.reset()
