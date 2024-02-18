local function ServerSave()
	if configManager.getBoolean(configKeys.GLOBAL_SERVER_SAVE_CLEAN_MAP) then
		cleanMap()
	end
	if configManager.getBoolean(configKeys.GLOBAL_SERVER_SAVE_CLOSE) then
		Game.setGameState(GAME_STATE_CLOSED)
	end
	if configManager.getBoolean(configKeys.GLOBAL_SERVER_SAVE_SHUTDOWN) then
		Game.setGameState(GAME_STATE_SHUTDOWN)
	end
	-- Updating daily reward next server save
	UpdateDailyRewardGlobalStorage(DailyReward.storages.lastServerSave, os.time())
	-- Reset gamestore exp boost count.
	db.query("UPDATE `player_storage` SET `value` = 0 WHERE `player_storage`.`key` = 51052")
end

local addons = TalkAction("/ss")

function addons.onSay(player, words, param)

	logCommand(player, words, param)

	if configManager.getBoolean(configKeys.GLOBAL_SERVER_SAVE_NOTIFY_MESSAGE) then
		local message = "Server is saving game in 1 minute. Please logout."
		Webhook.sendMessage("Server save", message, WEBHOOK_COLOR_WARNING)
		Game.broadcastMessage(message, MESSAGE_GAME_HIGHLIGHT)
	end
	addEvent(ServerSave, 60000)
	return true
end

addons:separator(" ")
addons:groupType("normal")
addons:register()