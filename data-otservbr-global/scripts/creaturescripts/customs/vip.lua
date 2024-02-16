local playerLogin = CreatureEvent("VipLogin")

function playerLogin.onLogin(player)
	if configManager.getBoolean(configKeys.VIP_SYSTEM_ENABLED) then
		local wasVip = player:kv():scoped("account"):get("vip-system") or false
		if wasVip and not player:isVip() then
			player:onRemoveVip()
		end
		if not wasVip and player:isVip() then
			player:onAddVip(player:getVipDays())
		end

		if player:isVip() then
			CheckPremiumAndPrint(player, MESSAGE_LOGIN)
		end
	end
	return true
end

playerLogin:register()
