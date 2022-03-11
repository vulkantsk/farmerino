
modifier_example_creep = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsBuff                  = function(self) return true end,
    RemoveOnDeath           = function(self) return true end,
    CheckState      = function(self) return 
        {
            [MODIFIER_STATE_NO_HEALTH_BAR] = true,          
            [MODIFIER_STATE_INVULNERABLE] = true, 
            [MODIFIER_STATE_ROOTED] = true, 
            [MODIFIER_STATE_DISARMED] = true, 
--            [MODIFIER_STATE_OUT_OF_GAME] = true, 
        } end,
})

