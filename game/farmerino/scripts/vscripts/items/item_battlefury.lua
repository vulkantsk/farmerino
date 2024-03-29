LinkLuaModifier( "modifier_item_battlefury_custom", "items/item_battlefury", LUA_MODIFIER_MOTION_NONE ) 

item_battlefury = class({})

function item_battlefury:GetIntrinsicModifierName()
	return "modifier_item_battlefury_custom"
end

item_battlefury_1 = class(item_battlefury)
item_battlefury_2 = class(item_battlefury)
item_battlefury_3 = class(item_battlefury)
item_battlefury_4 = class(item_battlefury)
item_battlefury_5 = class(item_battlefury)
item_battlefury_6 = class(item_battlefury)
item_battlefury_7 = class(item_battlefury)
item_battlefury_8 = class(item_battlefury)

modifier_item_battlefury_custom = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsBuff                  = function(self) return true end,
    RemoveOnDeath           = function(self) return false end,
    DeclareFunctions        = function(self) return 
        {           
            MODIFIER_EVENT_ON_ATTACK_LANDED,
            MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
 --           MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT_ADJUST,
        } end,
})

function modifier_item_battlefury_custom:GetModifierPreAttack_BonusDamage()
    return self:GetAbility():GetSpecialValueFor("bonus_damage")
end


function modifier_item_battlefury_custom:OnAttackLanded( params )
    if IsServer() then
		if params.attacker == self:GetParent() and ( not self:GetParent():IsIllusion() ) then
			local target = params.target
			if target ~= nil and target:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
				local cleave_damage = params.damage * self:GetAbility():GetSpecialValueFor("splash_pct") / 100
				local cleave_radius = self:GetAbility():GetSpecialValueFor("splash_radius")
				local effect = "particles/items_fx/battlefury_cleave.vpcf"

				DoCleaveAttack( self:GetParent(), target, self:GetAbility(), cleave_damage, cleave_radius, cleave_radius, cleave_radius, effect )
			end
		end
    end
    return 0
end


