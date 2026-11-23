extends Node

class_name State

var character : CharacterBody2D
var next_state : State
@export var state_animations : AnimatedSprite2D

func state_process(delta):
	pass

func state_input (event : InputEvent):
	pass

func on_enter():
	pass

func on_exit():
	pass
