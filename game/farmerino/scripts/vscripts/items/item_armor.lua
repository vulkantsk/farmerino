LinkLuaModifier("modifier_item_armor", "items/item_armor", LUA_MODIFIER_MOTION_NONE)

item_armor = class({})

function item_armor:GetIntrinsicModifierName()
	return "modifier_item_armor"
end


item_armor_1 = class(item_armor)
item_armor_2 = class(item_armor)
item_armor_3 = class(item_armor)
item_armor_4 = class(item_armor)
item_armor_5 = class(item_armor)
item_armor_6 = class(item_armor)
item_armor_7 = class(item_armor)
item_armor_8 = class(item_armor)

modifier_item_armor = class({
	IsHidden 		= function(self) return true end,
	GetAttributes 	= function(self) return MODIFIER_ATTRIBUTE_MULTIPLE end,
	DeclareFunctions  = function(self) return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}end,
})

function modifier_item_armor:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_armor")
end