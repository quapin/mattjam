extends Node


const settingsSavePath: String = "user://Settings.save"

var settingsDataDictionary: Dictionary = {}


func _ready():
	SettingsSignals.setSettingsDictionary.connect(onSettingsSave)
	loadSettings()
	

func onSettingsSave(data : Dictionary):
	var saveSettingsFile = FileAccess.open(settingsSavePath, FileAccess.WRITE)
	var jsonDataString = JSON.stringify(data)
	
	saveSettingsFile.store_line(jsonDataString)
	
func loadSettings():
	if !FileAccess.file_exists(settingsSavePath):
		return
	
	var saveSettingsFile = FileAccess.open(settingsSavePath, FileAccess.READ)
	var loadedData: Dictionary = {}
	
	while saveSettingsFile.get_position() < saveSettingsFile.get_length():
		var jsonString = saveSettingsFile.get_line()
		var json = JSON.new()
		var _parsed_result = json.parse(jsonString)
		
		loadedData = json.get_data()
		
	SettingsSignals.emit_loadSettingsData(loadedData)
	loadedData = {}
