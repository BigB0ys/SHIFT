extends CharacterBody2D

class_name player

@export var speed : float = 270
@export var jump_speed : float = -320
@export var jump_acceleration : float = 50

@onready var animations : AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_speed

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction and is_on_floor():
		velocity.x = direction * speed
	elif direction and not(is_on_floor()):
		if direction == Vector2.LEFT.x:
			velocity.x = move_toward(velocity.x, -speed, jump_acceleration)
		elif direction == Vector2.RIGHT.x:
			velocity.x = move_toward(velocity.x, speed, jump_acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_animation()

func update_animation():
	if velocity.x < 0:
		animations.flip_h = true
	elif velocity.x > 0:
		animations.flip_h = false
	if velocity.y < 0:
		animations.play("idle")
	elif velocity.y > 0:
		animations.play("idle")
	elif velocity.x != 0:
		animations.play("running")
	elif velocity == Vector2.ZERO and is_on_floor():
		animations.play("idle")
