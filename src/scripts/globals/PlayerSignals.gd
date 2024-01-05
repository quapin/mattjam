extends Node

signal onPlayerHealthChange(health: float)
signal onPlayerSpeedChange(speerd: int)
signal onPlayerClassChoose(playerClass: String)
signal onPlayerLevelUp(level: int, xpReq: int)
signal onPlayerXPGain(xp: int)
signal onPlayerSkillPointGain(skillPoints: int)

signal setPlayerData(playerDataDictionary: Dictionary)
signal loadPlayerData(playerDataDictionary: Dictionary)

func emit_loadPlayerData(playerDataDictionary: Dictionary):
	loadPlayerData.emit(playerDataDictionary)
	
func emit_setPlayerData(playerDataDictionary: Dictionary):
	setPlayerData.emit(playerDataDictionary)

func emit_onPlayerHealthChange(health: float):
	onPlayerHealthChange.emit(health)

func emit_onPlayerSpeedChange(speed: int):
	onPlayerSpeedChange.emit(speed)

func emit_onPlayerClassChoose(playerClass: String):
	onPlayerClassChoose.emit(playerClass)

func emit_onPlayerLevelUp(level: int, xpReq: int):
	onPlayerLevelUp.emit(level, xpReq)

func emit_onPlayerXPGain(xp: int):
	onPlayerXPGain.emit(xp)

func emit_onPlayerSkillPointGain(skillPoints: int):
	onPlayerSkillPointGain.emit(skillPoints)


