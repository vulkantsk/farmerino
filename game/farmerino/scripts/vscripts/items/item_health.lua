LinkLuaModifier("modifier_item_health", "items/item_health", LUA_MODIFIER_MOTION_NONE)

item_health = class({})

function item_health:GetIntrinsicModifierName()
	return "modifier_item_health"
end


item_health_1 = class(item_health)
item_health_2 = class(item_health)
item_health_3 = class(item_health)
item_health_4 = class(item_health)
item_health_5 = class(item_health)
item_health_6 = class(item_health)
item_health_7 = class(item_health)
item_health_8 = class(item_health)

modifier_item_health = class({
	IsHidden 		= function(self) return true end,
	GetAttributes 	= function(self) return MODIFIER_ATTRIBUTE_MULTIPLE end,
	DeclareFunctions  = function(self) return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
	}end,
})

function modifier_item_health:GetModifierHealthBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_health")
end

function modifier_item_health:GetModifierConstantHealthRegen()
	return self:GetAbility():GetSpecialValueFor("bonus_regen")
end