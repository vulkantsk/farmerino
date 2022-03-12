
function OnStartTouch( keys )
	local trigger_name = thisEntity:GetName()
	local target = keys.activator
	local team = target:GetTeam()
	local player = target:GetPlayerOwnerID()

	target:AddNewModifier(target, nil, "modifier_invulnerable", {duration = -1})	
end

function OnEndTouch( keys )
	local trigger_name = thisEntity:GetName()
	local target = keys.activator
	local team = target:GetTeam()
	local player = target:GetPlayerOwnerID()

	target:RemoveModifierByName("modifier_invulnerable")
end

