extends Node


@onready var defaultPlayerData = preload("res://src/resources/settings/DefaultPlayerStats.tres")
@onready var defaultLevelData = preload("res://src/resources/settings/DefaultLevelStats.tres")
var currentLevel: int = 1
var currentXP: int = 0
var currentSkillPoints = 0
var currentXPReq: int = 100
var currentHealth: float = 3
var currentSpeed: int = 200
var currentClass: String = " "

var loadedPlayerData: Dictionary = {}

func _ready():
	handleSignals()
	createStorageDictionary()
	
	
func createStorageDictionary() -> Dictionary:
	var playerContainerDictionary: Dictionary = {
		"currentHealth" : currentHealth,
		"currentSpeed" : currentSpeed,
		"currentClass" : currentClass,
		"currentLevel" : currentLevel,
		"currentXP" : currentXP,
		"currentXPReq" : currentXPReq,
		"currentSkillPoints" : currentSkillPoints
	}
	return playerContainerDictionary
	

func getPlayerHealth() -> float:
	if loadedPlayerData == {}:
		return defaultPlayerData.baseHealth
	return currentHealth

func getPlayerSpeed() -> int:
	if loadedPlayerData == {}:
		return defaultPlayerData.baseSpeed
	return currentSpeed

func getPlayerClass() -> String:
	if loadedPlayerData == {}:
		return defaultPlayerData.playerClass
	return currentClass

func getPlayerLevel() -> int:
	if loadedPlayerData == {}:
		return defaultLevelData.startLevel
	return currentLevel

func getPlayerXP() -> int:
	if loadedPlayerData == {}:
		return defaultLevelData.startXP
	return currentXP

func getPlayerSkillPoints() -> int:
	if loadedPlayerData == {}:
		return defaultLevelData.startSkillPoint
	return currentSkillPoints

func getPlayerNextXP() -> int:
	if loadedPlayerData == {}:
		return defaultLevelData.startXPReq
	return currentXPReq
	
func onPlayerHealthChange(health: float):
	currentHealth = health
	
func onPlayerSpeedChange(speed: int):
	currentSpeed = speed
	
func onPlayerClassChoose(playerClass: String):
	currentClass = playerClass
	
func onPlayerLevelUp(level: int, xpReq: int):
	currentLevel = level
	currentXPReq = xpReq

func onPlayerXPGain(xp: int):
	currentXP = xp

func onPlayerSkillPointGain(skillPoints: int):
	currentSkillPoints = skillPoints

func onPlayerDataLoaded(data: Dictionary):
	loadedPlayerData = data
	print(loadedPlayerData)
	onPlayerHealthChange(loadedPlayerData.currentHealth)
	onPlayerSpeedChange(loadedPlayerData.currentSpeed)
	onPlayerClassChoose(loadedPlayerData.currentClass)
	onPlayerLevelUp(loadedPlayerData.currentLevel, loadedPlayerData.currentXPReq)
	onPlayerXPGain(loadedPlayerData.currentXP)
	onPlayerSkillPointGain(loadedPlayerData.currentSkillPoints)

func handleSignals():
	PlayerSignals.onPlayerHealthChange.connect(onPlayerHealthChange)
	PlayerSignals.onPlayerSpeedChange.connect(onPlayerSpeedChange)
	PlayerSignals.onPlayerClassChoose.connect(onPlayerClassChoose)
	PlayerSignals.onPlayerLevelUp.connect(onPlayerLevelUp)
	PlayerSignals.onPlayerXPGain.connect(onPlayerXPGain)
	PlayerSignals.onPlayerSkillPointGain.connect(onPlayerSkillPointGain)
	PlayerSignals.loadPlayerData.connect(onPlayerDataLoaded)







