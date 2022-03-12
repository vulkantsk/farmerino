LinkLuaModifier("modifier_item_invul_potion", "items/item_invul_potion", 0)

item_invul_potion = class({})

function item_invul_potion:OnSpellStart()
	local item = self
	local caster = self:GetCaster()
	local duration = item:GetSpecialValueFor("duration")

	caster:AddNewModifier(caster, self, "modifier_item_invul_potion", {duration = duration})
	caster:EmitSound("DOTA_Item.Mango.Activate")
	
	item:SpendCharge()
	if item:GetCurrentCharges() <1 then
		self:Destroy()
	end
end


modifier_item_invul_potion = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsBuff                  = function(self) return true end,
    RemoveOnDeath           = function(self) return true end,
    CheckState      = function(self) return 
        {
            [MODIFIER_STATE_INVULNERABLE] = true, 
--            [MODIFIER_STATE_OUT_OF_GAME] = true, 
        } end,
})

function modifier_item_invul_potion:GetEffectName()
	return "particles/econ/items/omniknight/omni_ti8_head/omniknight_repel_buff_ti8.vpcf"--"particles/items_fx/black_king_bar_avatar.vpcf"
end

