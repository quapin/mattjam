extends Sprite2D

@onready var tween = get_tree().create_tween()

func _ready():
	# Honestly no idea what most of these do tweens are weird
	tween.set_trans(Tween.TRANS_QUART) 
	# This maybe(?) does the fade out
	tween.set_ease(Tween.EASE_OUT)
	# Or this is the fade out messing with the alpha value idk i think thats in the shader tho
	tween.tween_property(self,"modulate:a",0.0,0.5)
