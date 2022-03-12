LinkLuaModifier("modifier_item_damage", "items/item_damage", LUA_MODIFIER_MOTION_NONE)

item_damage = class({})

function item_damage:GetIntrinsicModifierName()
	return "modifier_item_damage"
end

item_damage_1 = class(item_damage)
item_damage_2 = class(item_damage)
item_damage_3 = class(item_damage)
item_damage_4 = class(item_damage)
item_damage_5 = class(item_damage)
item_damage_6 = class(item_damage)
item_damage_7 = class(item_damage)
item_damage_8 = class(item_damage)


modifier_item_damage = class({
	IsHidden 		= function(self) return true end,
	GetAttributes 	= function(self) return MODIFIER_ATTRIBUTE_MULTIPLE end,
	DeclareFunctions  = function(self) return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}end,
})

function modifier_item_damage:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end