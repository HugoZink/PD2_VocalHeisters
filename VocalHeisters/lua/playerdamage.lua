dofile(ModPath .. "vocalheisterscore.lua")

-- Play a flashbanged voice line
Hooks:PostHook(PlayerDamage, "on_flashbanged", "vocalheisters_playerdamage_flashbanged", function(self)
    DelayedCalls:Add("vocalheisters_playerdamage_commentflashbang", 1, function()
        VocalHeisters:Say("g41x_any")
    end)
end)

-- Play a teargas voice line
-- At the time of writing, if the player is damaged by a killzone and is not instantly dead, the damage is *always* gas or fire.
-- Either a crime spree teargas grenade or an environmental gas zone (Hoxton Breakout, H&T Bank)
-- TODO: Find a way to stop this from triggering on fire, only trigger on gas

-- Don't spam the voice line, only play it once every 10 seconds at most
local last_gas_speak_time = 0
Hooks:PostHook(PlayerDamage, "damage_killzone", "vocalheisters_playerdamage_killzone", function(self, attack_data)
    if not attack_data or attack_data.instant_death then
        return
    end

    -- Check if the last instance of saying the line was more than 10 seconds ago
    if (os.clock() - last_gas_speak_time) > 10 then
        VocalHeisters:Say("g42x_any")
        last_gas_speak_time = os.clock()
    end
end)

-- Play a line when getting revived
local last_being_revived_speak_time = 0
Hooks:PostHook(PlayerDamage, "pause_downed_timer", "vocalheisters_playerdamage_pausedowntimer_playreviveline", function(self)
    if (os.clock() - last_being_revived_speak_time) > 10 then
        DelayedCalls:Add("vocalheisters_playerdamage_commentgetrevived", 1, function()
            local line_to_play = "s05a_sin"
            if math.random() > 0.5 then
                line_to_play = "s05b_sin"
            end
            VocalHeisters:SayThirdPersonLine(line_to_play)
            last_being_revived_speak_time = os.clock()
        end)
    end
end)
