dofile(ModPath .. "vocalheisterscore.lua")

-- Comment on the cops stealing the bags
-- For real this time
local last_steal_speak_time = 0

-- Note: this hook is called on both the host and the client. Hooking into UnitNetworkHandler is not necessary.
Hooks:PostHook(CarryData, "link_to", "vocalheisters_linkbag_bagpickedupbyenemy", function(self, parent_unit, keep_collisions)

    -- Check if bag picked up by enemy
    if not parent_unit or not managers.enemy or not managers.enemy:all_enemies()[parent_unit:key()] then
        return
    end

    -- Say the line JC
    if last_steal_speak_time and (os.clock() - last_steal_speak_time) > 10 then
        DelayedCalls:Add("vocalheisters_copsarestealingloot", 2, function()
            VocalHeisters:SayOnce("p31")
        end)
        last_steal_speak_time = os.clock()
    end
end)
