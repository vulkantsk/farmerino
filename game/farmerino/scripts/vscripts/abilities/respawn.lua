LinkLuaModifier("modifier_respawn_weak", "abilities/respawn", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_respawn_strong", "abilities/respawn", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_respawn_boss", "abilities/respawn", LUA_MODIFIER_MOTION_NONE)

respawn_weak = class({})

function respawn_weak:GetIntrinsicModifierName()
	return "modifier_respawn_weak"
end

modifier_respawn_weak = class({
	IsHidden 		= function(self) return true end,
	DeclareFunctions = function(self) return {
		MODIFIER_EVENT_ON_DEATH
	}end,
})

function modifier_respawn_weak:OnCreated( kv )
	self.ability = self:GetAbility()
	self.respawn_duration = self.ability:GetSpecialValueFor("respawn_duration")
end

function modifier_respawn_weak:OnDeath(data)
	if not IsServer() then return end
	local unit = data.unit
	local caster = self:GetCaster()

	if unit == self:GetCaster() then
		local spawn_loc = caster:GetAbsOrigin()
		local caster_fw = caster:GetForwardVector()
		local unit_name = caster:GetUnitName()
		local team = caster:GetTeam()

		Timers:CreateTimer(self.respawn_duration, function()
--			local unit = CreateUnitByName(unit_name, spawn_loc, true, nil, nil, team)
			unit:SetForwardVector(caster_fw)
			unit:RespawnUnit()
		end)
	end
end


respawn_strong = class({})

function respawn_strong:GetIntrinsicModifierName()
	return "modifier_respawn_strong"
end

respawn_strong_boss = class({})

function respawn_strong_boss:GetIntrinsicModifierName()
	return "modifier_respawn_strong"
end

modifier_respawn_strong = class({
	IsHidden 		= function(self) return true end,
	DeclareFunctions = function(self) return {
		MODIFIER_EVENT_ON_DEATH
	}end,
})

function modifier_respawn_strong:OnCreated( kv )
	if not IsServer() then return end
	Timers:CreateTimer(0,function()
		self.ability = self:GetAbility()
		self.respawn_duration = self.ability:GetSpecialValueFor("respawn_duration")
		self.spawn_loc = self:GetCaster():GetAbsOrigin()
		self.caster_fw = self:GetCaster():GetForwardVector()
	end)
end

function modifier_respawn_strong:OnDeath(data)
	if not IsServer() then return end
	local unit = data.unit
	local caster = self:GetCaster()

	if unit == self:GetCaster() then
		local spawn_loc = self.spawn_loc
		local caster_fw = self.caster_fw
		local unit_name = caster:GetUnitName()
		local team = caster:GetTeam()
		local respawn_duration = self:GetAbility():GetSpecialValueFor("respawn_duration")

		Timers:CreateTimer(self.respawn_duration, function()
--			local unit = CreateUnitByName(unit_name, self.spawn_loc, true, nil, nil, team)
			unit:RespawnUnit()
			unit:SetAbsOrigin(spawn_loc)
			unit:SetForwardVector(caster_fw)
		end)
	end
end


respawn_boss = class({})

function respawn_boss:GetIntrinsicModifierName()
	return "modifier_respawn_boss"
end

modifier_respawn_boss = class({
	IsHidden 		= function(self) return true end,
	DeclareFunctions = function(self) return {
		MODIFIER_EVENT_ON_DEATH
	}end,
})

function modifier_respawn_boss:OnCreated( kv )
	if not IsServer() then return end
	Timers:CreateTimer(0,function()
		self.ability = self:GetAbility()
		self.respawn_duration = self.ability:GetSpecialValueFor("respawn_duration")
		self.spawn_loc = self:GetCaster():GetAbsOrigin()
		self.caster_fw = self:GetCaster():GetForwardVector()
	end)
end

function modifier_respawn_boss:OnDeath(data)
	if not IsServer() then return end
	local unit = data.unit
	local caster = self:GetCaster()

	if unit == self:GetCaster() then
		local unit_name = caster:GetUnitName()
		if unit_name == "npc_neutral_boss_1" then
			unit_name = "npc_neutral_boss_2"
		elseif unit_name == "npc_neutral_boss_2" then
			unit_name = "npc_neutral_boss_3"
		else
			return
		end
		local spawn_loc = self.spawn_loc
		local caster_fw = self.caster_fw
		local team = caster:GetTeam()
		local respawn_duration = self:GetAbility():GetSpecialValueFor("respawn_duration")

		Timers:CreateTimer(self.respawn_duration, function()
			local unit = CreateUnitByName(unit_name, self.spawn_loc, true, nil, nil, team)
			unit:SetForwardVector(caster_fw)
		end)
	end
end