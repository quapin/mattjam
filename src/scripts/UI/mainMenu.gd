extends Control

var labelStart = LabelSettings.new()
var labelQuit = LabelSettings.new()
var font = load("res://assets/alagard.ttf")
var settingsShow = false

# When the main menu scene starts up
func _ready():
	labelStart.set_font_color(Color.WHITE)
	labelStart.set_font(font)
	labelStart.set_font_size(130)
	labelStart.set_shadow_size(15)
	labelStart.set_shadow_color(Color.BLACK)
	labelStart.set_shadow_offset(Vector2(-4, 1))
	$StartButton/StartLabel.label_settings = labelStart
	
	labelQuit.set_font_color(Color.WHITE)
	labelQuit.set_font(font)
	labelQuit.set_font_size(130)
	labelQuit.set_shadow_size(15)
	labelQuit.set_shadow_color(Color.BLACK)
	labelQuit.set_shadow_offset(Vector2(-4, 1))
	$QuitButton/QuitLabel.label_settings = labelQuit
	
	
# When Start Button gets released
func _on_start_button_button_up():
	get_tree().change_scene_to_file("res://levels/test level.tscn")
	
# When Start Label is hovered over
func _on_start_label_mouse_entered():
	labelStart.set_font_color(Color.html("FF9A9A"))
	labelStart.set_font_size(140)
	labelStart.set_shadow_size(16)
	labelStart.set_shadow_offset(Vector2(-7, 1))
func _on_start_label_mouse_exited():
	labelStart.set_font_color(Color.WHITE)
	labelStart.set_font_size(130)
	labelStart.set_shadow_size(15)
	labelStart.set_shadow_offset(Vector2(-4, 1))

# When Quit Button gets released
func _on_quit_button_button_up():
	get_tree().quit()
	
# When Quit Label is hovered over
func _on_quit_label_mouse_entered():
	labelQuit.set_font_color(Color.html("FF9A9A"))
	labelQuit.set_font_size(140)
	labelQuit.set_shadow_size(16)
	labelQuit.set_shadow_offset(Vector2(-7, 1))
func _on_quit_label_mouse_exited():
	labelQuit.set_font_color(Color.WHITE)
	labelQuit.set_font_size(130)
	labelQuit.set_shadow_size(15)
	labelQuit.set_shadow_offset(Vector2(-4, 1))
	

func _on_settings_button_pressed():
	if !settingsShow:
		$ColorRect.show()
		$ColorRect/SettingsMenu.show()
	settingsShow = true


func _on_settings_menu_hidden():
	settingsShow = false
	$ColorRect.hide()
