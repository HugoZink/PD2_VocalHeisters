dofile(ModPath .. "vocalheisterscore.lua")

-- Play a "being tased" voiceline
-- UPDATE: Turns out this isn't actually a thing anymore, only Wolf has lines and they already play
--[[
Hooks:PostHook(PlayerTased, "enter", "vocalheisters_ontased", function(self)
    VocalHeisters:Say("s07x_sin")
end)
]]
