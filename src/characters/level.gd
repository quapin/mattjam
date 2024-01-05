extends Node2D



@export var xp = 0
@export var level = 1
@export var xpReq = 100
@export var skillPoint = 0
@export var nextSkillPoint = level + 5


func _ready():
	$GPUParticles2D.set_emitting(false)
	$LineEdit.hide()
	loadData()
	nextSkillPoint = level + 5
	
	
func _process(delta):
	playerXPGain()
	playerLevelUp()
	saveData()
	
	
func playerXPGain():
	if Input.is_action_just_pressed("shoot"):
		if $LevelTimer.is_stopped():
			xp += 5
			print(xp)
			print(level)
			PlayerSignals.emit_onPlayerXPGain(xp)
		else:
			xp -= 0.01
	
func playerLevelUp():
	while xp >= xpReq:
		$LevelTimer.start()
		xpReq = xp + 1
		$LineEdit.show()
		$LineEdit.set_text("Level up! Level: " + str(level + 1))
		$GPUParticles2D.set_emitting(true)
		print(xpReq)
		print(xp)
		break


func _on_timer_timeout():
	xp = 0
	level += 1
	$GPUParticles2D.set_emitting(false)
	$LineEdit.hide()
	xpReq += RandomNumberGenerator.new().randi_range(25, 50)
	print(xpReq)
	PlayerSignals.emit_onPlayerLevelUp(level, xpReq)
	if level == nextSkillPoint:
		skillPoint += 1
		nextSkillPoint += 5
		print("Next Skill Point Level: " + str(nextSkillPoint))
		PlayerSignals.emit_onPlayerSkillPointGain(skillPoint)

func saveData():
	if Input.is_action_just_pressed("select"):
		PlayerSignals.emit_setPlayerData(PlayerDataContainer.createStorageDictionary())

func loadData():
	level = PlayerDataContainer.getPlayerLevel()
	xp = PlayerDataContainer.getPlayerXP()
	xpReq = PlayerDataContainer.getPlayerNextXP()
	skillPoint = PlayerDataContainer.getPlayerSkillPoints()
	
