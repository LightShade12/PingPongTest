extends CharacterBody2D

class_name Ball

@export var initial_ball_speed = 15
@onready var audio_stream_player = $AudioStreamPlayer

@export var speed_multiplier = 1.02

var ball_speed = initial_ball_speed


func _ready():
	start_ball()

func _physics_process(delta):
	# Move the ball and check for collisions
	var collision = move_and_collide(velocity * ball_speed * delta)
	
	if collision:
		# Reflect the velocity based on the collision normal
		velocity = velocity.bounce(collision.get_normal()) * speed_multiplier
		
		# Adjust the position to prevent the ball from getting stuck or teleporting
		position += collision.get_remainder()

func start_ball():
	randomize()
	# Randomize the initial direction of the ball
	velocity.x = [-1, 1][randi() % 2] * initial_ball_speed
	velocity.y = [-0.8, 0.8][randi() % 2] * initial_ball_speed
