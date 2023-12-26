extends Area2D

var SPEED = 400

# Throwing Range
@onready var starRange = $ThrowRange

# Ninja Star Physics Process
func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += SPEED * direction * delta
	

	

# Ninja star destroyed
func destroy():
	queue_free()

# Ninja Star enters a collision box
func _on_body_entered(body):
	destroy()

# Ninja star enters an area box
func _on_area_entered(area):
	destroy()

# Ninja Star despawn when going off screen
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

# Ninja Star despawn when exceeding throwing range
func _on_throw_range_timeout():
	queue_free()
