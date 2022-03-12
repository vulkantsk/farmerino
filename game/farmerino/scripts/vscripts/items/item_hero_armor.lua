LinkLuaModifier('modifier_item_hero_armor', 'items/item_hero_armor', LUA_MODIFIER_MOTION_NONE)

item_hero_armor = class({})

function item_hero_armor:GetCastRange()
    return self:GetSpecialValueFor("search_radius")
end

function item_hero_armor:GetIntrinsicModifierName()
    return "modifier_item_hero_armor"
end

item_hero_armor_1 = class(item_hero_armor)
item_hero_armor_2 = class(item_hero_armor)
item_hero_armor_3 = class(item_hero_armor)
item_hero_armor_4 = class(item_hero_armor)
item_hero_armor_5 = class(item_hero_armor)
item_hero_armor_6 = class(item_hero_armor)
item_hero_armor_7 = class(item_hero_armor)
item_hero_armor_8 = class(item_hero_armor)


modifier_item_hero_armor = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return true end,
    IsDebuff                = function(self) return false end,
    IsBuff                  = function(self) return true end,
    RemoveOnDeath           = function(self) return true end,
    DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        }
    end,
})


function modifier_item_hero_armor:OnCreated(data)
    local ability = self:GetAbility()
    self.search_radius = ability:GetSpecialValueFor("search_radius")
    self.bonus_armor = ability:GetSpecialValueFor("bonus_armor")
    self.armor_per_enemy = ability:GetSpecialValueFor("armor_per_enemy")
   
   self:StartIntervalThink(0.1)
end

function modifier_item_hero_armor:OnIntervalThink()
    if IsClient() then return end
    
    local units = FindUnitsInRadius(self:GetCaster():GetTeam(), 
    self:GetParent():GetOrigin(), 
    nil, 
    self.search_radius,
    DOTA_UNIT_TARGET_TEAM_ENEMY, 
    DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
    self:GetAbility():GetAbilityTargetFlags(),
    FIND_ANY_ORDER, 
    false)

    self:SetStackCount(#units)
end

function modifier_item_hero_armor:OnRefresh()
    self:OnCreated()
end

function modifier_item_hero_armor:GetModifierPhysicalArmorBonus()
    return self.bonus_armor + self.armor_per_enemy * self:GetStackCount()
end
