LinkLuaModifier("modifier_example_creep", "abilities/modifier_example_creep", LUA_MODIFIER_MOTION_NONE)

TeamTable = {
	[2] = { -- GOODGUYS
		CreepLevel = 0,
		Creeps = {},
	},
	[3] = { -- BADGUYS
		CreepLevel = 0,
		Creeps = {},
	},
	[6] = { -- CUSTOM #1
		CreepLevel = 0,
		Creeps = {},
	},
	[7] = { -- CUSTOM #2
		CreepLevel = 0,
		Creeps = {},
	},
	[8] = { -- CUSTOM #3
		CreepLevel = 0,
		Creeps = {},
	},
	[9] = { -- CUSTOM #4
		CreepLevel = 0,
		Creeps = {},
	},
	[10] = { -- CUSTOM #5
		CreepLevel = 0,
		Creeps = {},
	},
	[11] = { -- CUSTOM #6
		CreepLevel = 0,
		Creeps = {},
	},
}
LOCATION_CREEP_COUNT = 8
if GameMode == nil then
	_G.GameMode = class({})
end

function GameMode:InitGameMode()
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(self, 'OnGameRulesStateChange'), self)
	ListenToGameEvent("npc_spawned",Dynamic_Wrap( self, 'OnNPCSpawned' ), self )
	ListenToGameEvent('entity_killed', Dynamic_Wrap(self, 'OnEntityKilled'), self)
end

function GameMode:OnGameRulesStateChange()
	local newState = GameRules:State_Get()

	if newState == DOTA_GAMERULES_STATE_HERO_SELECTION then
		self:SpawnExampleCreeps()
	elseif newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
	end
end

function GameMode:SpawnExampleCreeps()
	for index =1,8 do
		local creep_name = "npc_creep_"..index
		local point = Entities:FindByName(nil, "point_example_creep_"..index)
		local point_origin = point:GetAbsOrigin()
		local point_fw = point:GetForwardVector()
		
		local unit = CreateUnitByName(creep_name, point_origin, true, nil, nil, DOTA_TEAM_NEUTRALS)
		unit:SetForwardVector(point_fw)
		unit:AddNewModifier(unit, nil, "modifier_example_creep", {duration = -1})
	end
	for index =1,4 do
		local key = index * 2
		local creep_name = "npc_creep_"..key
		local point = Entities:FindByName(nil, "point_example_creep_"..key)
		local point_origin = point:GetAbsOrigin()
		local point_fw = point:GetForwardVector()
		
		local unit = CreateUnitByName(creep_name, point_origin, true, nil, nil, DOTA_TEAM_NEUTRALS)
		unit:SetForwardVector(point_fw)
		unit:AddNewModifier(unit, nil, "modifier_example_creep", {duration = -1})
	end
end

function GameMode:OnNPCSpawned(keys)
--	print("[BAREBONES] NPC Spawned")
--	DeepPrintTable(keys)
	local npc = EntIndexToHScript(keys.entindex)
	local name = npc:GetUnitName()
	
	if npc:IsRealHero() and npc.bbFirstSpawned == nil then
--		GameSpawner:OnHeroInGame(npc)			
		npc.bbFirstSpawned = true
		local playerID = npc:GetPlayerID()
		local steamID = PlayerResource:GetSteamAccountID(playerID)

--		npc:AddItemByName("item_baseitem_1")
	

	elseif npc:IsRealHero() and npc.spawn_point then
		npc:SetAbsOrigin(npc.spawn_point)
	end
end

function GameMode:OnEntityKilled(keys)

	local unit = EntIndexToHScript(keys.entindex_killed)
	local unit_name = unit:GetUnitName()
	
	if unit_name == "npc_goodguys_fort" then
		GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)		
	end

	if unit.reward then
		local ent_index = unit:entindex()
		
		self.current_units[ent_index] = nil
		local units = 0
		for key,value in pairs(self.current_units) do
			units = units + 1
		end

		if units == 0 then
			local current_wave = self.wave_list[self.wave_number]
			local reward_gold = current_wave.reward_gold
			local reward_exp = current_wave.reward_exp

			GiveGoldPlayers( reward_gold )
			GiveExperiencePlayers( reward_exp )
			GameMode:LineBossSpawner()
		end
	end
end

function GiveGoldPlayers( gold )
	for index=0 ,4 do
		if PlayerResource:HasSelectedHero(index) then
			local player = PlayerResource:GetPlayer(index)
			local hero = PlayerResource:GetSelectedHeroEntity(index)
			hero:ModifyGold(gold, false, 0)
			SendOverheadEventMessage( player, OVERHEAD_ALERT_GOLD, hero, gold, nil )
		end
	end
end

function GiveExperiencePlayers( experience )
	for index=0 ,4 do
		if PlayerResource:HasSelectedHero(index) then
			local player = PlayerResource:GetPlayer(index)
			local hero = PlayerResource:GetSelectedHeroEntity(index)
			hero:AddExperience(experience, 0, false, true )
		end
	end
end

GameMode:InitGameMode()