extends Node

@export var jump_state_name = "Jumping"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func step(target: CharacterController, delta):
# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		target.jump()
		pass

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (target.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		target.velocity.x = lerp(target.velocity.x, direction.x * target.SPEED, 10.5 * delta)
		target.velocity.z = lerp(target.velocity.z, direction.z * target.SPEED, 10.5 * delta)
		target.sprite.rotation.y = atan2(target.velocity.x, target.velocity.z)
		target.sprite.animation = "run"
	else:
		target.velocity.x = lerp(target.velocity.x, 0.0, 10 * delta)
		target.velocity.z = lerp(target.velocity.z, 0.0, 10 * delta)
		target.sprite.animation = "idle"
	
	#if velocity.y >= 0:
		#sprite.animation = "jump"
	
	if direction.x <= -0.5:
		target.sprite.flip_h = true
	elif direction.x >= 0.5:
		target.sprite.flip_h = false
	
	target.move_and_slide()
	if(not(target.is_on_floor())):
		target.sprite.animation = "jump"
	pass
