extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -350.0
const Jump_multiplier = 0.05;
@onready var sprite = $AnimatedSprite2D
var stretch_amount := 0.8

var scale_speed := 10.0






func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority(): return
	var target_scale = Vector2(2.656, 2.813) 
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if velocity.y<0:
			target_scale = Vector2(2.656 - stretch_amount, 2.813 + stretch_amount)  

	# Handle jump . 
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY 
	
	if !is_on_floor():
		sprite.play("Jump")
		
	if Input.is_action_just_released("ui_up") and velocity.y < 0: 
		velocity.y *= Jump_multiplier
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		sprite.play("Run")
		sprite.flip_h = direction < 0
	else:
		sprite.play("Idle")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	sprite.scale = sprite.scale.lerp(target_scale, scale_speed * delta)
