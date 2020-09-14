dofile(ModPath .. "vocalheisterscore.lua")

-- Play a line when reviving a teammate
Hooks:PostHook(PlayerStandard, "_start_action_interact", "vocalheisters_revivecomment", function(self)
    if self._interact_params and self._interact_params.tweak_data == "revive" then
        VocalHeisters:Say("s08x_sin")
    end
end)
