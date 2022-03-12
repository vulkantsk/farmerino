LinkLuaModifier("modifier_item_ancient_shield", "items/item_ancient_shield", LUA_MODIFIER_MOTION_NONE)

item_ancient_shield = class({})

function item_ancient_shield:GetIntrinsicModifierName()
	return "modifier_item_ancient_shield"
end

item_ancient_shield_1 = class(item_ancient_shield)
item_ancient_shield_2 = class(item_ancient_shield)
item_ancient_shield_3 = class(item_ancient_shield)
item_ancient_shield_4 = class(item_ancient_shield)
item_ancient_shield_5 = class(item_ancient_shield)
item_ancient_shield_6 = class(item_ancient_shield)
item_ancient_shield_7 = class(item_ancient_shield)
item_ancient_shield_8 = class(item_ancient_shield)

modifier_item_ancient_shield = class({
	IsHidden 		= function(self) return true end,
	GetAttributes 	= function(self) return MODIFIER_ATTRIBUTE_MULTIPLE end,
	DeclareFunctions  = function(self) return {
		MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK,
	}end,
})

function modifier_item_ancient_shield:GetModifierPhysical_ConstantBlock()
	return self:GetAbility():GetSpecialValueFor("bonus_block")
end



