extends CharacterBody2D

class_name flyingslime

@export var speed : float = 100
@export var flapspeed : float = -100
@export var gravitymult : float = 0.5

@onready var floorsensor : RayCast2D = $Floordetector
@onready var verticalcheck : RayCast2D = $verticalcheck
@onready var horizontalcheck : RayCast2D = $horizontalcheck
@onready var animations : AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity. we use gravitymult so it doesnt fall as quick as other entities
	if not is_on_floor():
		velocity += get_gravity() * delta * gravitymult
		
	if floorsensor.is_colliding():
		velocity.y = flapspeed
	
	if not verticalcheck.is_colliding() or horizontalcheck.is_colliding():
		swap_direction()
		
	velocity.x = speed
	update_animation()
	move_and_slide()

func swap_direction():
	if animations.flip_h:
		animations.flip_h = false
	else:
		animations.flip_h = true
	horizontalcheck.target_position.x *= -1
	speed *= -1

func update_animation():
	if velocity.y < 0:
		animations.play("falling")
	elif velocity.y > 0:
		animations.play("rising")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is player:
		body.queue_free()
		#body.get_hit()
