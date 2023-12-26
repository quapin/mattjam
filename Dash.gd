extends Node2D

const dash_delay = 0.2

@onready var duration_timer = $DurationTimer
var ghost_scene = preload("res://characters/actions/dash_ghost.tscn")
var can_dash = true
var sprite

func start_dash(sprite, duration):
	self.sprite = sprite
	
	duration_timer.wait_time = duration
	duration_timer.start()
	
	instance_ghost()
	
func instance_ghost():
	var ghost = ghost_scene.instantiate()
	get_parent().get_parent().add_child(ghost)
	
	ghost.global_position = global_position
	ghost.texture = sprite.texture
	ghost.vframes = sprite.vframes
	ghost.hframes = sprite.hframes
	ghost.frame = sprite.frame
	ghost.flip_h = sprite.flip_h
	
	
func is_dashing():
	return !duration_timer.is_stopped()

func end_dash():
	can_dash = false
	await(get_tree().create_timer(dash_delay).timeout)
	can_dash = true

func _on_duration_timer_timeout() -> void:
	end_dash()
