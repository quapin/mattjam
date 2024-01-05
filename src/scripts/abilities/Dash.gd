extends Node2D

const dash_delay = 0.2

@onready var duration_timer = $DurationTimer
@onready var ghost_timer = $GhostTimer
@onready var dust_trail = $DustTrail

var ghost_scene = preload("res://src/characters/actions/dash_ghost.tscn")
var sprite
var can_dash = true

func start_dash(sprite, duration):
	# Whiten the dash ghost
	self.sprite = sprite
	#sprite.material.set_shader_param("mix_weight", 0.7)
	#sprite.material.set_shader_param("whiten", true)
	
	# Dash duration
	duration_timer.wait_time = duration
	duration_timer.start()
	$GhostTimer.start()
	instance_ghost()
	
	# Dust trail WIP
	#dust_trail.restart()
	#dust_trail.emitting = true

# Create the ghost
func instance_ghost():
	# Pull ghost scene
	var ghost = ghost_scene.instantiate()
	get_parent().get_parent().add_child(ghost)
	
	# Match ghost frame with player sprite frame
	ghost.global_position = global_position
	ghost.texture = sprite.texture
	ghost.vframes = sprite.vframes
	ghost.hframes = sprite.hframes
	ghost.frame = sprite.frame
	ghost.flip_h = sprite.flip_h

func is_dashing():
	return !duration_timer.is_stopped()

# Finish dashing and spawning ghosts
func end_dash():
	$GhostTimer.stop()
	
	can_dash = false
	await(get_tree().create_timer(dash_delay).timeout)
	can_dash = true


func _on_duration_timer_timeout() -> void:
	end_dash()

# Spawn ghost every time the ghost timer loops
func _on_ghost_timer_timeout():
	instance_ghost()
