extends Spatial

export var speed = 6
var direction = Vector3()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	direction = Vector3(0, 0, speed * delta)
	translate(direction)
