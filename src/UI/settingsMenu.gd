extends Control

class_name Settings


@onready var buttonScene = preload("res://src/input/inputButton.tscn")
@onready var actionList = $TabContainer/Controls/MarginContainer/VBoxContainer/ScrollContainer/ActionList 
@onready var windowModeButton = $TabContainer/Video/MarginContainer/ScrollContainer/VBoxContainer/WindowModeButton/HBoxContainer/OptionButton
@onready var resolutionModeButton = $TabContainer/Video/MarginContainer/ScrollContainer/VBoxContainer/ResolutionModeButton/HBoxContainer/OptionButton
@onready var scaleLabel = $TabContainer/Video/MarginContainer/ScrollContainer/VBoxContainer/ResolutionModeButton/ScaleSlider/ScaleLabel
@onready var scaleSlider = $TabContainer/Video/MarginContainer/ScrollContainer/VBoxContainer/ResolutionModeButton/ScaleSlider



const windowModeArray : Array[String] = [
	"Windowed",
	"Full Screen",
	"Boarderless Window",
]

const resolutionDictionary : Dictionary = {
	"640 x 360" : Vector2i(640, 360),
	"1280 x 720" : Vector2i(1280, 720),
	"1600 x 900" : Vector2i(1600, 900),
	"1920 x 1080" : Vector2i(1920, 1080),
	"2560 x 1440" : Vector2i(2560, 1440),
	"3840 x 2160" : Vector2i(3840, 2160)
}

var isRemapping = false
var actionRemapping = null
var keyRemapping = null
var settingsClosed = true


var inputActions = {
	"up": "Move Up",
	"left": "Move Left",
	"down": "Move Down",
	"right": "Move Right",
	"shoot": "Main Attack",
	"dash": "Ability",
	"select": "Select",
}

func _ready():
	addWindowModeItems()
	addResolutionItems()
	_create_action_list()
	checkVars()
	set_process(false)
	windowModeButton.item_selected.connect(onWindowModeSelected)
	resolutionModeButton.item_selected.connect(onResolutionSelected)

func checkVars():
	var window = get_window()
	var mode = window.get_mode()
	
	if mode == Window.MODE_EXCLUSIVE_FULLSCREEN:
		windowModeButton.select(1)

func setResoultionText():
	var resolutionText = str(get_window().get_size().x) + " x " + str(get_window().get_size().y)
	resolutionModeButton.set_text(resolutionText)

func addWindowModeItems():
		for windowMode in windowModeArray:
			windowModeButton.add_item(windowMode)
	
func onWindowModeSelected(index : int):
	match index:
		0: # Windowed
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			DisplayServer.window_set_size(Vector2i(1280, 720))
		1: # FullScreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		2: # Borderless Window
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	setResoultionText()
	centerWindow()
	
func addResolutionItems():
	var currentResolution = get_window().get_size()
	var ID = 0
	
	for resolution in resolutionDictionary:
		resolutionModeButton.add_item(resolution, ID)
		
		if resolutionDictionary[resolution] == currentResolution:
			resolutionModeButton.select(ID)
			
		ID += 1

func onResolutionSelected(index: int):
	DisplayServer.window_set_size(resolutionDictionary.values()[index])
	centerWindow()
	#var ID = resolutionModeButton.get_item_text(index)
	#get_window().set_size(resolutionDictionary[ID])

func centerWindow():
	var centerScreen = DisplayServer.screen_get_position() + DisplayServer.screen_get_size() / 2
	var windowSize = get_window().get_size_with_decorations()
	get_window().set_position(centerScreen - windowSize / 2)
	
func _create_action_list():
	InputMap.load_from_project_settings()
	for item in actionList.get_children():
		item.queue_free()
	
	for action in inputActions:
		var button = buttonScene.instantiate()
		var actionLabel = button.find_child("LabelAction")
		var inputLabel = button.find_child("LabelInput")
		
		actionLabel.text = inputActions[action]
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			inputLabel.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			inputLabel.text = ""
			
		actionList.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button, action))
		
func _on_input_button_pressed(button, action):
	if !isRemapping:
		isRemapping = true
		actionRemapping = action
		keyRemapping = button
		button.find_child("LabelInput").text = "Press key to bind..."

func _input(event):
	if isRemapping:
		if (event is InputEventKey || (event is InputEventMouseButton && event.pressed)):
			if event is InputEventMouseButton && event.double_click:
				event.double_click = false
			
			InputMap.action_erase_events(actionRemapping)
			InputMap.action_add_event(actionRemapping, event)
			_update_action_list(keyRemapping, event)
			
			isRemapping = false
			actionRemapping = null
			keyRemapping = null
			
			accept_event()
			
func _update_action_list(button, event):
	button.find_child("LabelInput").text = event.as_text().trim_suffix(" (Physical)")
	


func _on_defaults_button_pressed():
	_create_action_list()





func _on_exit_pressed():
	hide()
	$TabContainer.current_tab = 0
	settingsClosed = true
	set_process(false)


func _on_h_slider_value_changed(value):
	var resolutionScale = value/100.0
	var resolutionText = str(round(get_window().get_size().x * resolutionScale)) + " x " + str(round(get_window().get_size().y * resolutionScale))
	
	scaleLabel.set_text(str(value) + "% - " + resolutionText)
	
	
