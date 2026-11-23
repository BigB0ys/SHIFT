extends State

func on_exit():
	state_animations.visible = false
	
func on_enter():
	state_animations.visible = true

func state_process(delta):
	update_animation()

func update_animation():
	if character.velocity.y < 0:
		state_animations.play("jumps")
	elif character.velocity.y > 0:
		state_animations.play("falling")
	elif character.velocity.x != 0:
		state_animations.play("running")
	elif character.velocity == Vector2.ZERO and character.is_on_floor():
		state_animations.play("idle")
	
