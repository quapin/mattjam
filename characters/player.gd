extends CharacterBody2D

var move_speed = 400  # speed in pixels/sec
var dash_speed = 1800
var dash_duration = 0.1

@onready var dash = $Dash
@onready var sprite = $Sprite2D
@onready var animplayer = $AnimationPlayer

func _process(delta):
	
	if Input.is_action_just_pressed("dash") && dash.can_dash && !dash.is_dashing() :
		dash.start_dash(sprite, dash_duration)
		
	

func _physics_process(delta):
	var speed = dash_speed if dash.is_dashing() else move_speed
	# Simple top down movement
	var direction = Input.get_vector("left", "right", "up", "down")
	
	velocity = direction * speed
	move_and_slide()
