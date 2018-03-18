extends Spatial

export var speed = 2

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	rotate(Vector3(1, 0, 0), speed * delta)
	rotate(Vector3(0, 1, 0), speed * delta)

func _on_Area_body_entered(body):
	if body is KinematicBody:
		print("Give the player a coconut!")
		get_tree().root.get_node("Main").modify_score(10)
		queue_free()
