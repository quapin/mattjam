extends Control



# When Start Button gets released
func _on_start_button_button_up():
	get_tree().change_scene_to_file("res://levels/test level.tscn")
	
# When Quit Button gets released



func _on_quit_button_button_up():
	get_tree().quit()
