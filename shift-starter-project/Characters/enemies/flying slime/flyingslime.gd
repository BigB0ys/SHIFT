extends CharacterBody2D


@export var speed : float = 150
@export var flapspeed : float = -100
@export var gravitymult : float = 0.5

@onready var floorsensor : RayCast2D = $Floordetector
@onready var verticalcheck : RayCast2D = $verticalcheck
@onready var horizontalcheck : RayCast2D = $horizontalcheck


func _physics_process(delta: float) -> void:
	# Add the gravity. we use gravitymult so it doesnt fall as quick as other entities
	if not is_on_floor():
		velocity += get_gravity() * delta * gravitymult
		
	if floorsensor.is_colliding():
		velocity.y = flapspeed
	
	if not verticalcheck.is_colliding() or horizontalcheck.is_colliding():
		swap_direction()
		
	velocity.x = speed
	move_and_slide()

func swap_direction():
	horizontalcheck.target_position.x *= -1
	speed *= -1
