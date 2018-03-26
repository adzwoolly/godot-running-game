extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const distance_to_energy_scale = 50 / 5# max distance / max desired energy

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	translate(Vector3(-20 * delta, 0, 0))
	var energy = exp(0.05 * (translation.z + 50)) - 1
	get_node("OmniLight").light_energy = energy#(50 - translation.z) / distance_to_energy_scale
	
	if translation.z < -50:
		queue_free()
