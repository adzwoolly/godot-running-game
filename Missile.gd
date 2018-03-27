extends Spatial

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	translate(Vector3(-20 * delta, 0, 0))
	var energy = exp(0.055 * (translation.z + 50)) - 1
	get_node("OmniLight").light_energy = energy
	
	if translation.z < -50:
		queue_free()
