dofile(ModPath .. "vocalheisterscore.lua")

-- Comment on end of assault
-- Don't spam the voice line, only play it once every 20 seconds at most
local last_assault_end_speak_time = 0
local assault_mode_speak = function(self, enabled)
    if not enabled and (os.clock() - last_assault_end_speak_time) > 20 then
        DelayedCalls:Add("vocalheisters_commentassaultend", 5, function()
            -- Only one person in the lobby should comment on the assault ending
            VocalHeisters:SayOnce("p24")
            last_assault_end_speak_time = os.clock()
        end)
    end
end

-- This is called by the host
Hooks:PostHook(GroupAIStateBase, "set_assault_mode", "vocalheisters_setassaultmode", assault_mode_speak)
-- Called by client
Hooks:PostHook(GroupAIStateBase, "sync_assault_mode", "vocalheisters_syncassaultmode", assault_mode_speak)
