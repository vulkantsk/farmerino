LinkLuaModifier("modifier_item_attackspeed", "items/item_attackspeed", LUA_MODIFIER_MOTION_NONE)

item_attackspeed = class({})

function item_attackspeed:GetIntrinsicModifierName()
	return "modifier_item_attackspeed"
end


item_attackspeed_1 = class(item_attackspeed)
item_attackspeed_2 = class(item_attackspeed)
item_attackspeed_3 = class(item_attackspeed)
item_attackspeed_4 = class(item_attackspeed)
item_attackspeed_5 = class(item_attackspeed)
item_attackspeed_6 = class(item_attackspeed)
item_attackspeed_7 = class(item_attackspeed)
item_attackspeed_8 = class(item_attackspeed)


modifier_item_attackspeed = class({
	IsHidden 		= function(self) return true end,
	GetAttributes 	= function(self) return MODIFIER_ATTRIBUTE_MULTIPLE end,
	DeclareFunctions  = function(self) return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}end,
})

function modifier_item_attackspeed:OnCreated()
	self.ability = self:GetAbility()
	self.bonus_attackspeed = self.ability:GetSpecialValueFor("bonus_attackspeed")
end

function modifier_item_attackspeed:OnRefresh()
	self:OnCreated()
end

function modifier_item_attackspeed:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_attackspeed
end