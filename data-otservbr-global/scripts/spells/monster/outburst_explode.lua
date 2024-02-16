local function outExplode()
	local upConer = { x = 32223, y = 31273, z = 14 } -- upLeftCorner
	local downConer = { x = 32246, y = 31297, z = 14 } -- downRightCorner

	for i = upConer.x, downConer.x do
		for j = upConer.y, downConer.y do
			for k = upConer.z, downConer.z do
				local room = { x = i, y = j, z = k }
				local tile = Tile(room)
				if tile then
					local creatures = tile:getCreatures()
					if creatures and #creatures > 0 then
						for _, creatureUid in pairs(creatures) do
							local creature = Creature(creatureUid)
							if creature then
								if creature:isPlayer() then
									creature:teleportTo({ x = 32234, y = 31280, z = 14 })
								elseif creature:isMonster() and creature:getName() == "Charging Outburst" then
									creature:teleportTo({ x = 32234, y = 31279, z = 14 })
								end
							end
						end
					end
				end
			end
		end
	end
end

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_PURPLEENERGY)

local spellArea = {
	{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
	{ 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
}

local area = createCombatArea(spellArea)
combat:setArea(area)

local function delayedCastSpell(creature, var)
	if not creature then
		return
	end
	return combat:execute(creature, positionToVariant(creature:getPosition()))
end

function removeOutburst(cid)
	local creature = Creature(cid)
	if not creature then
		return false
	end
	creature:remove()
end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	outExplode()
	delayedCastSpell(creature, var)
	Game.setStorageValue(GlobalStorage.HeartOfDestruction.OutburstChargingKilled, 1)
	addEvent(removeOutburst, 1000, creature.uid)

	local monster = Game.createMonster("Outburst", Position(32234, 31284, 14), false, true)
	if monster then
		local outburstHealth = Game.getStorageValue(GlobalStorage.HeartOfDestruction.OutburstHealth) > 0 and Game.getStorageValue(GlobalStorage.HeartOfDestruction.OutburstHealth) or 0
		monster:addHealth(-monster:getHealth() + outburstHealth, COMBAT_PHYSICALDAMAGE)
	end
	return true
end

spell:name("outburst explode")
spell:words("###449")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()
