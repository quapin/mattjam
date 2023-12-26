extends CharacterBody2D

# Player Variables
@export var move_speed = 200 # speed in pixels/sec
@export var dash_speed = 1800
@export var dash_duration = 0.1

# Node Call-ins
@onready var dash = $Dash
@onready var sprite = $Sprite2D
@onready var animplayer = $AnimationPlayer
@onready var attackTimer = $AttackTimer

# Attack Call-ins
@export var ninjaStar: PackedScene = preload("res://src/entites/ninja_star.tscn")


# Dash Process
func _process(delta):
	
	if Input.is_action_just_pressed("dash") && dash.can_dash && !dash.is_dashing() :
		dash.start_dash(sprite, dash_duration)
		
	

# Player Physics and Actions Process
func _physics_process(delta):
	var speed = dash_speed if dash.is_dashing() else move_speed
	# Simple top down movement
	var direction = Input.get_vector("left", "right", "up", "down")
	
	# Attacking action based off mouse location with timer
	if Input.is_action_just_pressed("shoot") and attackTimer.is_stopped():
		var starDirection = self.global_position.direction_to(get_global_mouse_position())
		throwStar(starDirection)
		
		
	# Match player sprite with direction and animations
	if velocity.x < 0:
		sprite.flip_h = true
		#$Sprite2D/AnimationPlayer.play('run')
	else:
		sprite.flip_h = false
		#$Sprite2D/AnimationPlayer.play('run')
		
	velocity = direction * speed
	move_and_slide()
	
	
# Ninja Star Spawning Function
func throwStar(starDirection: Vector2):
	if ninjaStar:
		var star = ninjaStar.instantiate()
		get_tree().current_scene.add_child(star)
		star.global_position = self.global_position
		
		var starRotate = starDirection.angle()
		star.rotation = starRotate
		
		attackTimer.start()
	
