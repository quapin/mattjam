extends Control





func _on_start_button_button_up():
	get_tree().change_scene_to_file("res://levels/test level.tscn")




func _on_quit_button_button_up():
	get_tree().quit()


