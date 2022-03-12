function TeleportCreep(trigger)

	local npc = trigger.activator
	local npc_entindex = npc:entindex()
	local triggerName = thisEntity:GetName()
	local teleport_point_name = "point_teleport_creep_"
	local creep_level = 0
	
	if triggerName == "trigger_teleport_creep_1" then
		creep_level = 1
	elseif triggerName == "trigger_teleport_creep_2" then
		creep_level = 2
	elseif triggerName == "trigger_teleport_creep_3" then
		creep_level = 3
	elseif triggerName == "trigger_teleport_creep_4" then
		creep_level = 4
	elseif triggerName == "trigger_teleport_creep_5" then
		creep_level = 5
	elseif triggerName == "trigger_teleport_creep_6" then
		creep_level = 6
	elseif triggerName == "trigger_teleport_creep_7" then
		creep_level = 7
	elseif triggerName == "trigger_teleport_creep_8" then
		creep_level = 8
	end

	local team_id = npc:GetTeamNumber()
	teleport_point_name = teleport_point_name..team_id

	TeleportToPoint( npc, teleport_point_name )
	CreateCreepsForTeam(creep_level, team_id)
end

function TeleportBoss(trigger)
	local npc = trigger.activator
	local npc_entindex = npc:entindex()
	local triggerName = thisEntity:GetName()
	local teleport_point_name = "point_teleport_creep_"
	local boss_level = 0
	
	if triggerName == "trigger_teleport_boss_1" then
		boss_level = 1
	elseif triggerName == "trigger_teleport_boss_2" then
		boss_level = 2
	elseif triggerName == "trigger_teleport_boss_3" then
		boss_level = 3
	elseif triggerName == "trigger_teleport_boss_4" then
		boss_level = 4
	end

	local team_id = npc:GetTeamNumber()
	teleport_point_name = teleport_point_name..team_id

	if TeamTable[team_id].boss_available == nil then
		TeamTable[team_id].boss_available = true
	end
	
	if TeamTable[team_id].boss_available == true then
		TeamTable[team_id].boss_available = false
		Timers:CreateTimer(BOSS_REFRESH_TIMER, function()
			TeamTable[team_id].boss_available = true
		end)
		TeleportToPoint( npc, teleport_point_name )
		CreateBossForTeam(boss_level, team_id)
	end
end

function TeleportHome( keys )
	local trigger_name = thisEntity:GetName()
	local target = keys.activator
	local team = target:GetTeam()
	local player = target:GetPlayerOwnerID()
	local point_name = "point_teleport_home"

	if team == DOTA_TEAM_NEUTRALS then
		return
	end

	local point =  Entities:FindByName( nil, point_name):GetAbsOrigin()
	 
	FindClearSpaceForUnit(target, point, true)
	target:Stop()
	target:SetHealth(target:GetMaxHealth())

	if team == DOTA_TEAM_NEUTRALS or not target:IsRealHero() then
		return
	end
	
	PlayerResource:SetCameraTarget(player, target)
	Timers:CreateTimer(0.1, function()
		PlayerResource:SetCameraTarget(player, nil) -- Чтобы камера разблочилась
	end)	
end

function TeleportToPoint( target, point_name )
	local player = target:GetPlayerOwnerID()

	if team == DOTA_TEAM_NEUTRALS or not target:IsRealHero() then
		return
	end

	local point =  Entities:FindByName( nil, point_name):GetAbsOrigin()
	 
	FindClearSpaceForUnit(target, point, true)
	target:Stop()
	
	PlayerResource:SetCameraTarget(player, target)
	Timers:CreateTimer(0.1, function()
		PlayerResource:SetCameraTarget(player, nil) -- Чтобы камера разблочилась
	end)	
end

function CreateCreepsForTeam(creep_level, team_id)
	
	if  not TeamTable[team_id].CreepLevel then
		print("creep_level = "..creep_level)
--		print("entindex = "..TeamTable[team_id].CreepLevel)
		TeamTable[team_id].CreepLevel = creep_level
	elseif TeamTable[team_id].CreepLevel == creep_level then
		print("creep_level = "..creep_level)
		print("table_creep_level = "..TeamTable[team_id].CreepLevel)
		return
	end
	
	--Убить всех юнитов с прошлого спавна
	if TeamTable[team_id].Creeps then
		for ent_id, creep in pairs(TeamTable[team_id].Creeps) do
			UTIL_Remove(TeamTable[team_id].Creeps[ent_id])
			TeamTable[team_id].Creeps[ent_id] = nil
		end
	else
		TeamTable[team_id].Creeps = {}
	end

	local unit_name = "npc_creep_"..creep_level
	local points = Entities:FindAllByName("point_spawn_creep_"..team_id)
	
	for i=1, LOCATION_CREEP_COUNT do
		local point = points[RandomInt(1, #points)]:GetAbsOrigin()
		local unit = CreateUnitByName(unit_name, point, true, nil, nil, DOTA_TEAM_NEUTRALS)
		unit:SetUnitCanRespawn(true)
		local ent_id = unit:entindex()
		
		TeamTable[team_id].Creeps[ent_id] = unit
	end

end

function CreateBossForTeam(boss_level, team_id)
	TeamTable[team_id].CreepLevel = 0

	--Убить всех юнитов с прошлого спавна
	if TeamTable[team_id].Creeps then
		for ent_id, creep in pairs(TeamTable[team_id].Creeps) do
			UTIL_Remove(TeamTable[team_id].Creeps[ent_id])
			TeamTable[team_id].Creeps[ent_id] = nil
		end
	else
		TeamTable[team_id].Creeps = {}
	end

	local unit_name = "npc_boss_"..boss_level
	local point = Entities:FindByName(nil, "point_spawn_boss_"..team_id)
	local point_origin = point:GetAbsOrigin()
	local point_fw = point:GetForwardVector()
	
	local unit = CreateUnitByName(unit_name, point_origin, true, nil, nil, DOTA_TEAM_NEUTRALS)
	unit:SetForwardVector(point_fw)
	unit:SetUnitCanRespawn(true)
	local ent_id = unit:entindex()
	
	TeamTable[team_id].Creeps[ent_id] = unit

end

