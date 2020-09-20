dofile(ModPath .. "vocalheisterscore.lua")

local anticipation_lines = {
    [3] = "g70",
    [2] = nil,
    [1] = "g50"
}

-- Say a line when assaults are anticipating
-- STRONGLY recommend using this in conjunction with Kuziz' narrator restoration https://modworkshop.net/mod/28454
-- VoidUI also has this
-- I think without one of those mods, this part doesn't work at all
if VocalHeisters.Settings.enable_anticipation_lines then
    Hooks:PostHook(HUDManager, "sync_assault_dialog", "vocalheisters_sync_assault_dialog_playassaultlines", function(self, index)
        if not anticipation_lines[index] then
            return
        end

        DelayedCalls:Add("vocalheisters_sayassaultline_" .. anticipation_lines[index], 5, function()
            VocalHeisters:SayOnceThirdPersonLine(anticipation_lines[index])
        end)
    end)
end