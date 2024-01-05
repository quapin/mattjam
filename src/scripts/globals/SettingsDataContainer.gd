extends Node

@onready var defaultSettings: DefaultSettingsResource = preload("res://src/resources/settings/DefaultSettings.tres")
#@onready var keybindResource: PlayerKeybindResource = preload("res://src/resources/settings/DefaultPlayerKeybinds.tres")
var windowModeIndex: int = 0
var resolutionIndex: int = 0
var fpsValue: bool = false

var loadedData: Dictionary = {}

func _ready():
	handleSignals()
	createStorageDictionary()
	

func createStorageDictionary() -> Dictionary:
	var settingsContanierDictionary: Dictionary = {
		"windowModeIndex" : windowModeIndex,
		"resolutionIndex" : resolutionIndex,
		"fpsValue" : fpsValue
		#"keybinds" : createKeybindDictionary()
	}
	return settingsContanierDictionary
	
#func createKeybindDictionary() -> Dictionary:
	#var keybindsContainerDictionary = {
		#keybindResource.moveLeft : keybindResource.moveLeftKey,
		#keybindResource.moveRight : keybindResource.moveRightKey,
		#keybindResource.moveUp : keybindResource.moveRightKey,
		#keybindResource.moveDown : keybindResource.moveDownKey,
		#keybindResource.attack : keybindResource.attackKey,
		#keybindResource.ability : keybindResource.abilityKey,
		#keybindResource.select : keybindResource.selectKey,
		#keybindResource.pause : keybindResource.pauseKey
	#}
	#return keybindsContainerDictionary

func getWindowModeIndex() -> int:
	if loadedData == {}:
		return defaultSettings.defualtWindowModeIndex
	return windowModeIndex
	
func getResolutionIndex() -> int:
	if loadedData == {}:
		return defaultSettings.defualtResolutionIndex
	return resolutionIndex

func getFPSToggled() -> bool:
	if loadedData == {}:
		return defaultSettings.defualtFPSValue
	return fpsValue

#func getKeybinds(action: String):
	#if !loadedData.has("keybinds"):
		#match action:
			#keybindResource.moveLeft:
				#return keybindResource.defaultMoveLeftKey
			#keybindResource.moveRight:
				#return keybindResource.defaultMoveRightKey
			#keybindResource.moveUp:
				#return keybindResource.defaultMoveUpKey
			#keybindResource.moveDown:
				#return keybindResource.defaultMoveDownKey
			#keybindResource.attack:
				#return keybindResource.defaultAttackKey
			#keybindResource.ability:
				#return keybindResource.defaultAbilityKey
			#keybindResource.select:
				#return keybindResource.defaultSelectKey
			#keybindResource.pause:
				#return keybindResource.defaultPauseKey
	#else:
		#match action:
			#keybindResource.moveLeft:
				#return keybindResource.moveLeftKey
			#keybindResource.moveRight:
				#return keybindResource.moveRightKey
			#keybindResource.moveUp:
				#return keybindResource.moveUpKey
			#keybindResource.moveDown:
				#return keybindResource.moveDownKey
			#keybindResource.attack:
				#return keybindResource.attackKey
			#keybindResource.ability:
				#return keybindResource.abilityKey
			#keybindResource.select:
				#return keybindResource.selectKey
			#keybindResource.pause:
				#return keybindResource.pauseKey
			
			

func onWindowModeSelected(index: int):
	windowModeIndex = index
	
func onResolutionSelected(index: int):
	resolutionIndex = index
	
func onFPSToggled(toggled: bool):
	fpsValue = toggled

#func setKeybind(action: String, event):
	#match action:
		#keybindResource.moveLeft:
			#keybindResource.moveLeftKey = event
		#keybindResource.moveRight:
			#keybindResource.moveRightKey = event
		#keybindResource.moveUp:
			#keybindResource.moveUpKey = event
		#keybindResource.moveDown:
			#keybindResource.moveDownKey = event
		#keybindResource.attack:
			#keybindResource.attackKey = event
		#keybindResource.ability:
			#keybindResource.abilityKey = event
		#keybindResource.select:
			#keybindResource.selectKey = event
		#keybindResource.pause:
			#keybindResource.pauseKey = event
		#
#
##func onKeybindsLoaded(data: Dictionary):
	##var loadedMoveLeft = InputEventKey.new()
	##var loadedMoveRight = InputEventKey.new()
	##var loadedMoveUp = InputEventKey.new()
	##var loadedMoveDown = InputEventKey.new()
	##var loadedAttack = InputEventMouseButton.new()
	##var loadedAbility = InputEventKey.new()
	##var loadedSelect = InputEventKey.new()
	##var loadedPause = InputEventKey.new()
	##
	##loadedMoveLeft.set_physical_keycode(int(data.left))
	##loadedMoveRight.set_physical_keycode(int(data.right))
	##loadedMoveUp.set_physical_keycode(int(data.up))
	##loadedMoveDown.set_physical_keycode(int(data.down))
	##loadedAttack.set_button_index(int(data.shoot))
	##loadedAbility.set_physical_keycode(int(data.dash))
	##loadedSelect.set_physical_keycode(int(data.select))
	##loadedPause.set_physical_keycode(int(data.pause))
	##
	##keybindResource.moveLeftKey = loadedMoveLeft
	##keybindResource.moveRightKey = loadedMoveRight
	##keybindResource.moveUpKey = loadedMoveUp
	##keybindResource.moveDownKey = loadedMoveDown
	##keybindResource.attackKey = loadedAttack
	##keybindResource.abilityKey = loadedAbility
	##keybindResource.selectKey = loadedSelect
	##keybindResource.pauseKey = loadedPause


func onSettingsDataLoaded(data: Dictionary):
	loadedData = data
	print(loadedData)
	onWindowModeSelected(loadedData.windowModeIndex)
	onResolutionSelected(loadedData.resolutionIndex)
	onFPSToggled(loadedData.fpsValue)
	#onKeybindsLoaded(loadedData.keybinds)
	

func handleSignals():
	SettingsSignals.onWindowModeSelected.connect(onWindowModeSelected)
	SettingsSignals.onResolutionSelected.connect(onResolutionSelected)
	SettingsSignals.onFPSToggled.connect(onFPSToggled)
	SettingsSignals.loadSettingsData.connect(onSettingsDataLoaded)
