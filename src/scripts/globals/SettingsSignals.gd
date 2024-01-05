extends Node


signal onWindowModeSelected(index: int)
signal onResolutionSelected(index: int)
signal onFPSToggled(value: bool)

signal setSettingsDictionary(settingsDictionary: Dictionary)

signal loadSettingsData(settingsDictionary : Dictionary)

func _ready():
	pass

func emit_loadSettingsData(settingsDictionary : Dictionary):
	loadSettingsData.emit(settingsDictionary)

func emit_setSettingsDictionary(settingsDictionary: Dictionary):
	setSettingsDictionary.emit(settingsDictionary)
	
func emit_onWindowModeSelected(index: int):
	onWindowModeSelected.emit(index)

func emit_onResolutionSelected(index: int):
	onResolutionSelected.emit(index)
	
func emit_onFPSToggled(value: bool):
	onFPSToggled.emit(value)
	
