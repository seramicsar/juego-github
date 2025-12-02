extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED 
	
func _input(event):
	if event is InputEventMouse:
		SpringArm3D.rotation.x +=event.relative.y * mouse
		SpringArm3D.rotation.x = clamp(spring_arm_3d.rotation.x, -PI/2 , PI/4)
		SpringArm3D.totation.y -=event.relative.x * mouse
		
		





func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var inputDirection = Vector3(Input.get_axis("ui_left","ui_right"),
								0,
								Input.get_axis("ui_up","ui_down"))
								
	inputDirection = inputDirection.rotated(Vector3.UP, SpringArm3D.rotation.y).normalized()
	

	if inputDirection:
		velocity.x = inputDirection.x * SPEED
		velocity.z = inputDirection.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
