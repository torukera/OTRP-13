local spell = Spell("instant")

function spell.onCastSpell(player, variant)
	player:CreateFamiliarSpell()
	return true
end

spell:group("support")
spell:id(195)
spell:name("Paladin familiar")
spell:words("utevo gran res sac")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_SUMMON_PALADIN_FAMILIAR)
spell:level(200)
spell:mana(2000)
spell:cooldown(configManager.getNumber(configKeys.FAMILIAR_TIME) * 60 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:isAggressive(false)
spell:vocation("paladin;true", "royal paladin;true")
spell:register()
