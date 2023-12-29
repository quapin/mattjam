extends Control

class_name Settings


@onready var buttonScene = preload("res://src/input/inputButton.tscn")
@onready var actionList = $TabContainer/Controls/MarginContainer/VBoxContainer/ScrollContainer/ActionList 

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
	_create_action_list()
	
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
