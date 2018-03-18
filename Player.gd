extends Spatial

enum positions {
	LEFT = 0
	MIDDLE = 1
	RIGHT=2
}

var left_key_released = true
var right_key_released = true
var up_key_released = true

var jump_animation_complete = true

var position = positions.MIDDLE
var move_direction = Vector3()

var animation

func _ready():
	# Called every time the node is added to the scene.
	animation = get_node("AnimationPlayer")
	animation.play("run-animation")

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	if position == positions.LEFT and translation.x >= -2:
		translate(move_direction * delta)
	if position == positions.MIDDLE and (translation.x < -0.02 or translation.x > 0.02):
		translate(move_direction * delta)
	if position == positions.RIGHT and translation.x <= 2:
		translate(move_direction * delta)
	
	check_key_ups()
	
	if Input.is_key_pressed(KEY_LEFT) and left_key_released:
		left_key_released = false
		move_left()
	if Input.is_key_pressed(KEY_RIGHT) and right_key_released:
		right_key_released = false
		move_right()
	if Input.is_key_pressed(KEY_UP) and up_key_released and jump_animation_complete:
		up_key_released = false
		jump_animation_complete = false
		animation.play("jump-animation", 0.01)

func _on_AnimationPlayer_animation_finished(anim_name):
	animation.play("run-animation", 0.2)
	
	if anim_name == "jump-animation":
		jump_animation_complete = true

func move_left():
	if position != positions.LEFT:
		position = position - 1
		move_direction = Vector3(2.5, 0, 0)

func move_right():
	if position != positions.RIGHT:
		position = position + 1
		move_direction = Vector3(-2.5, 0, 0)
		
func check_key_ups():
	if !Input.is_key_pressed(KEY_LEFT):
		left_key_released = true
	if !Input.is_key_pressed(KEY_RIGHT):
		right_key_released = true
	if !Input.is_key_pressed(KEY_UP):
		up_key_released = true