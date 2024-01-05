extends Node


const playerSavePath: String = "user://PlayerData.save"

var playerDictionary: Dictionary = {}

func _ready():
	PlayerSignals.setPlayerData.connect(onPlayerDataSave)
	loadPlayerData()
	
func onPlayerDataSave(data: Dictionary):
	var savePlayerData = FileAccess.open(playerSavePath, FileAccess.WRITE)
	var jsonDataString = JSON.stringify(data)
	
	savePlayerData.store_line(jsonDataString)
	
func loadPlayerData():
	if !FileAccess.file_exists(playerSavePath):
		return
	var playerDataFile = FileAccess.open(playerSavePath, FileAccess.READ)
	var loadedData: Dictionary = {}
	
	while playerDataFile.get_position() < playerDataFile.get_length():
		var jsonString = playerDataFile.get_line()
		var json = JSON.new()
		var _parsed_result = json.parse(jsonString)
		
		loadedData = json.get_data()
	
	PlayerSignals.emit_loadPlayerData(loadedData)
	loadedData = {}
