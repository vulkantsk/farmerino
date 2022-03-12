LinkLuaModifier("modifier_item_crit", "items/item_crit", LUA_MODIFIER_MOTION_NONE)

item_crit = class({})

function item_crit:GetIntrinsicModifierName()
	return "modifier_item_crit"
end

item_crit_1 = class(item_crit)
item_crit_2 = class(item_crit)
item_crit_3 = class(item_crit)
item_crit_4 = class(item_crit)
item_crit_5 = class(item_crit)
item_crit_6 = class(item_crit)
item_crit_7 = class(item_crit)
item_crit_8 = class(item_crit)

modifier_item_crit = class({
	IsHidden 		= function(self) return true end,
	GetAttributes 	= function(self) return MODIFIER_ATTRIBUTE_MULTIPLE end,
	DeclareFunctions  = function(self) return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE
	}end,
})

function modifier_item_crit:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_crit:GetModifierPreAttack_CriticalStrike()
	local crit_chance = self:GetAbility():GetSpecialValueFor("crit_chance")
	local crit_mult = self:GetAbility():GetSpecialValueFor("crit_mult")
	
	if RollPercentage(crit_chance) then
		return self:GetAbility():GetSpecialValueFor("crit_mult")
	end
end