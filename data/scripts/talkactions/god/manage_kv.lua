local get = TalkAction("/getkv")

function get.onSay(player, words, param)
	local value = kv.get(param)
	if value then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "kv[" .. param .. "]: " .. PrettyString(value))
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Key " .. param .. " not found.")
	end
end

get:separator(" ")
get:groupType("normal")
get:register()

local set = TalkAction("/setkv")

function set.onSay(player, words, param)
	local key, value = string.splitFirst(param, " ")
	value = load("return " .. value)()
	kv.set(key, value)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "kv[" .. key .. "] = " .. PrettyString(value))
end

set:separator(" ")
set:groupType("normal")
set:register()

local bossCooldown = TalkAction("/clearcooldown")

function bossCooldown.onSay(player, words, param)
	local boss, playerName = string.splitFirst(param, ",")
	if not playerName then
		playerName = player:getName()
	end
	local targetPlayer = Player(playerName)
	if not targetPlayer then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Player " .. playerName .. " not found.")
		return
	end
	targetPlayer:setBossCooldown(boss, 0)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Boss cooldown for " .. playerName .. " cleared.")
	targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Boss cooldown for " .. boss .. " cleared.")
end

bossCooldown:separator(" ")
bossCooldown:groupType("normal")
bossCooldown:register()
