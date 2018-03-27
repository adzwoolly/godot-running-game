extends Spatial

func _ready():
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	translate(Vector3(-20 * delta, 0, 0))
	var energy = exp(0.055 * (translation.z + 50)) - 1
	get_node("OmniLight").light_energy = energy
	
	if translation.z < -50:
		queue_free()
