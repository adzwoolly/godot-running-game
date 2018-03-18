extends Spatial

export var speed = 10
export var max_distance = 0.5

var centre_translation
var shake_direction
var moving_out

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	centre_translation = translation
	shake_direction = Vector3(0, 0, 0)
	moving_out = false

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if translation.distance_to(centre_translation) < 0.05 and !moving_out:
		moving_out = true
		var speed_x = rand_range(0, speed)
		var speed_y = speed - speed_x
		if randi() % 2 == 1:
			speed_x = -speed_x
		if randi() % 2 == 1:
			speed_y = -speed_y
		shake_direction = Vector3(speed_x, speed_y, 0)
		
	if translation.distance_to(centre_translation) > max_distance and moving_out:
		moving_out = false
		shake_direction = Vector3(0 - shake_direction.x, 0 - shake_direction.y, 0 - shake_direction.z)
	
	translate(shake_direction * delta)
