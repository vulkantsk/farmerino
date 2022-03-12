LinkLuaModifier('modifier_item_hard_armor', 'items/item_hard_armor', LUA_MODIFIER_MOTION_NONE)

item_hard_armor = class({})

function item_hard_armor:GetIntrinsicModifierName()
    return "modifier_item_hard_armor"
end

item_hard_armor_1 = class(item_hard_armor)
item_hard_armor_2 = class(item_hard_armor)
item_hard_armor_3 = class(item_hard_armor)
item_hard_armor_4 = class(item_hard_armor)
item_hard_armor_5 = class(item_hard_armor)
item_hard_armor_6 = class(item_hard_armor)
item_hard_armor_7 = class(item_hard_armor)
item_hard_armor_8 = class(item_hard_armor)


modifier_item_hard_armor = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return true end,
    IsDebuff                = function(self) return false end,
    IsBuff                  = function(self) return true end,
    RemoveOnDeath           = function(self) return true end,
    DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
            MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        }
    end,
})


function modifier_item_hard_armor:OnCreated(data)
--    if IsClient() then return end
    local ability = self:GetAbility()
    self.bonus_armor = ability:GetSpecialValueFor("bonus_armor")
    self.chance_block = ability:GetSpecialValueFor("chance_block")
   
end

function modifier_item_hard_armor:GetModifierIncomingDamage_Percentage()
    if RollPercentage(self.chance_block) then
        return -1000
    end
end

function modifier_item_hard_armor:GetModifierPhysicalArmorBonus()
    return self.bonus_armor
end
