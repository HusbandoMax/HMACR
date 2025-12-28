local Profile = {}

Profile.Settings = {
    {
        ["Setting"] = "AOE",
        ["Options"] = {
            { ["Name"] = "AOE", ["Tooltip"] = "AOE ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "AOE", ["Tooltip"] = "AOE OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "SelfHealing",
        ["Options"] = {
            { ["Name"] = "SelfHealing", ["Tooltip"] = "Self Healing ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "SelfHealing", ["Tooltip"] = "Self Healing OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
	{
        ["Setting"] = "Feint",
        ["Options"] = {
            { ["Name"] = "Feint", ["Tooltip"] = "Feint ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Feint", ["Tooltip"] = "Feint OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "Meditation",
        ["Options"] = {
            { ["Name"] = "Meditation", ["Tooltip"] = "Meditation ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Meditation", ["Tooltip"] = "Meditation OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
	{
		["Setting"] = "PB",
		["Options"] = {
            { ["Name"] = "PB", ["Tooltip"] = "Perfect Balance ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "PB", ["Tooltip"] = "Perfect Balance OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
	},
	{
		["Setting"] = "RoF",
		["Options"] = {
            { ["Name"] = "RoF", ["Tooltip"] = "Riddle of Fire ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "RoF", ["Tooltip"] = "Riddle of Fire OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
	},
	{
		["Setting"] = "RoW",
		["Options"] = {
            { ["Name"] = "RoW", ["Tooltip"] = "Riddle of Wind ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "RoW", ["Tooltip"] = "Riddle of Wind OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
	},
	{
		["Setting"] = "RoE",
		["Options"] = {
            { ["Name"] = "RoE", ["Tooltip"] = "Riddle of Earth ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "RoE", ["Tooltip"] = "Riddle of Earth OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
	},
	{
		["Setting"] = "Brotherhood",
		["Options"] = {
            { ["Name"] = "Brotherhood", ["Tooltip"] = "Brotherhood ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Brotherhood", ["Tooltip"] = "Brotherhood OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
	}
}

function Profile:SkillTable(Data,Target,ClassTypeID)
    self.SendConsoleMessage(ClassTypeID.."PROFILE",1)

    local PlayerPOS = Data.PlayerPOS
    local TargetPOS = Data.TargetPOS
    local TargetCastingInterruptible = Data.TargetCastingInterruptible
    local PlayerMoving = Data.PlayerMoving
    local PlayerInCombat = Data.PlayerInCombat
    local PlayerID = Data.PlayerID
    local TargetID = Data.TargetID
    local TargetDistance = Data.TargetDistance
    local TargetHP = Data.TargetHP
    local PlayerHP = Data.PlayerHP
    local PartySize = Data.PartySize
    local PlayerLevel = Data.PlayerLevel
    local CastingInfo = Data.CastingInfo
    local CurrentCast = Data.CurrentCast
    local LastCast = Data.LastCast
    local LastCombo = Data.LastCombo
    local CurrentChannel = Data.CurrentChannel
    local GaugeData1 = Data.GaugeData1
    local GaugeData2 = Data.GaugeData2
    local AOETimeout = Data.AOETimeout
    local JumpTimeout = Data.JumpTimeout
    local CastTimeout = Data.CastTimeout

    local CurrentForm = 1
	local earthReply = false
	local windReply = false
	local fireReply = false
    for i,e in pairs(Player.buffs) do
        local BuffID = e.id
        if e.ownerid == PlayerID then
            if BuffID == 108 then -- Raptor
                CurrentForm = 2
            elseif BuffID == 109 then -- Coeurl
                CurrentForm = 3
            elseif BuffID == 107 then -- Opo-opo
                CurrentForm = 4
            elseif BuffID == 2513 then -- Formless Fist
                CurrentForm = 5
            elseif BuffID == 110 then -- Perfect Balance
                CurrentForm = 6
			elseif BuffID == 3841 then
				earthReply = true
			elseif BuffID == 3842 then
				windReply = true
			elseif BuffID == 3843 then
				fireReply = true
			end
        end
    end
    self.SendConsoleMessage("CurrentForm: "..tostring(CurrentForm), 2)

    local chakra = GaugeData2[1] or 0

    local function GetFury()
        local v = (GaugeData2 and GaugeData2[5]) or 0
        local opo = v % 2
        local rap = math.floor(v / 4) % 2
        local coe = math.floor(v / 16)

        if coe > 2 then coe = 2 end
        return opo, rap, coe
    end
    local furyOpo, furyRap, furyCoe = GetFury()
    self.SendConsoleMessage("Chakra: "..tostring(chakra).." | Fury O/R/C: "..tostring(furyOpo).."/"..tostring(furyRap).."/"..tostring(furyCoe), 2)

    local function GetBeastGauge()
        if not GaugeData2 then
            return false, 0, 0, 0, 0
        end

        local beast1 = GaugeData2[2] or 0
        local beast2 = GaugeData2[3] or 0
        local beast3 = GaugeData2[4] or 0

        local full = (beast1 ~= 0 and beast2 ~= 0 and beast3 ~= 0)
        if not full then
            return false, beast1, beast2, beast3, 0
        end

        local unique = {}
        unique[beast1] = true
        unique[beast2] = true
        unique[beast3] = true

        local count = 0
        for _ in pairs(unique) do
            count = count + 1
        end

        return true, beast1, beast2, beast3, count
    end
    local beastFull, beast1, beast2, beast3, beastState = GetBeastGauge()
    self.SendConsoleMessage(string.format("BeastGauge full=%s slots={%d,%d,%d} pattern=%d", tostring(beastFull), beast1 or 0, beast2 or 0, beast3 or 0, beastState or 0), 2)

    local function GetBeastPresence()
        local beastOpo = false
        local beastRap = false
        local beastCoe = false

        -- 1 = Opo
        -- 2 = Raptor
        -- 3 = Coeurl
        local function check(v)
            if v == 1 then
                beastOpo = true
            elseif v == 2 then
                beastRap = true
            elseif v == 3 then
                beastCoe = true
            end
        end

        check(beast1)
        check(beast2)
        check(beast3)

        return beastOpo, beastRap, beastCoe
    end
    local beastOpo, beastRap, beastCoe = GetBeastPresence()
    self.SendConsoleMessage(string.format("BeastPresence | Opo=%s Raptor=%s Coeurl=%s", tostring(beastOpo), tostring(beastRap), tostring(beastCoe)), 2)

    local function GetNadi()
        local n = (GaugeData2 and GaugeData2[6]) or 0
        local lunar = (n % 2) == 1
        local solar = n >= 2
        local both = n == 3
        return n, lunar, solar, both
    end
    local nadi, lunarNadi, solarNadi, bothNadi = GetNadi()
    self.SendConsoleMessage(string.format("NADI | Lunar: %s | Solar: %s | Raw[6]: %d", tostring(lunarNadi), tostring(solarNadi), nadi), 2)

    local function PerfectBalanceAbility()
        -- 1: Opo, 2: Raptor, 3: Coeurl

        if bothNadi then
            return 1, "PB Ability: Opo (BOTH NADI)"
        end

        if solarNadi then
            if not beastOpo and not beastRap and not beastCoe then
                return 1, "PB Ability: Opo (HAS NONE + SOLAR)"
            elseif beastOpo then
                return 1, "PB Ability: Opo (HAS OPO + SOLAR)"
            elseif beastRap then
                return 2, "PB Ability: Rap (HAS RAP + SOLAR)"
            elseif beastCoe then
                return 3, "PB Ability: Coe (HAS COE + SOLAR)"
            end
        end

        -- Lunar or no nadi: try to complete 3 different
        if lunarNadi or (not lunarNadi and not solarNadi) then
            if not beastOpo then
                return 1, "PB Ability: Opo (NO OPO + LUNAR/NONE)"
            elseif not beastRap then
                return 2, "PB Ability: Rap (NO RAP + LUNAR/NONE)"
            elseif not beastCoe then
                return 3, "PB Ability: Coe (NO COE + LUNAR/NONE)"
            end
        end

        return 1, "PB Ability: Opo (fallback)"
    end
    local pbAbility, pbLog = PerfectBalanceAbility()
    self.SendConsoleMessage(pbLog, 2)

	--[[
        53		Bootshine
        56		Snap Punch
        61		Twin Snakes
        66		Demolish
        69		Perfect Balance
        70		Rockbreaker
        74	    Dragon Kick
        3543	Tornado Kick
        3545	Elixir Field
        3546	Meditation
        3547	The Forbidden Chakra
        4262	Form Shift
        7394	Riddle of Earth
        7395	Riddle of Fire
        7396	Brotherhood
        7541	Second Wind
        7542	Bloodbath
        7549	Feint
        16473	Four-point Fury
        25761	Steel Peak
        25763	Howling Fist
        25765	Celestial Revolution
        25766	Riddle of Wind
        25767	Shadow of the Destroyer
        25768	Rising Phoenix
        25769	Phantom Rush
        25882	Flint Strike
        36944	Earth's Reply
        36945	Leaping Opo
        36946	Rising Raptor
        36947	Pouncing Coeurl
        36948	Elixir Burst
        36949	Wind's Reply
        36950	Fire's Reply
	]]--
	
    local SkillList = {
        -- Meditation (build chakra when not capped)
        {
            ["Type"] = 2, ["Name"] = "Meditation", ["ID"] = 3546, ["Range"] = 10, ["TargetCast"] = false,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Meditation") == 1,
            ["OtherCheck"] = (chakra < 5) and (PlayerInCombat == false),
        },
		
		-- Riddles
		{
			["Type"] = 1,
			["TargetCast"] = false,
			["Name"] = "Riddle of Fire",
			["ID"] = 7395,
			["Level"] = PlayerLevel >= 68,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID, "RoF") == 1,
			["OtherCheck"] = PlayerInCombat == true
		},
		{
			["Type"] = 1,
			["TargetCast"] = true,
			["Name"] = "Fire's Reply",
			["ID"] = 36950,
			["Level"] = PlayerLevel >= 100,
			["OtherCheck"] = fireReply
		},
		{
			["Type"] = 1,
			["TargetCast"] = false,
			["Name"] = "Riddle of Wind",
			["ID"] = 25766,
			["Level"] = PlayerLevel >= 72,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID, "RoW") == 1,
			["OtherCheck"] = PlayerInCombat == true
		},
		{
			["Type"] = 1,
			["TargetCast"] = true,
			["Name"] = "Wind's Reply",
			["ID"] = 36949,
			["Level"] = PlayerLevel >= 96,
			["OtherCheck"] = windReply
		},
		{
            ["Type"] = 1, 
			["Name"] = "Riddle of Earth", 
			["ID"] = 7394,
			["TargetCast"] = false,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"RoE") == 1,
            ["OtherCheck"] = PlayerInCombat == true and PlayerHP < 60,
        },
		{
            ["Type"] = 1, 
			["Name"] = "Earth's Reply", 
			["ID"] = 36944,
			["TargetCast"] = false,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"RoE") == 1,
            ["OtherCheck"] = PlayerInCombat == true and PlayerHP < 60 and earthReply,
        },
		
		-- Brotherhood
		{
			["Type"] = 2,
			["TargetCast"] = false,
			["Name"] = "Brotherhood",
			["ID"] = 7396,
			["Level"] = PlayerLevel >= 70,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID, "Brotherhood") == 1,
			["OtherCheck"] = PlayerInCombat == true
		},
		
		-- Perfect Balance
		{
			["Type"] = 1,
			["TargetCast"] = false,
			["Name"] = "Perfect Balance",
			["ID"] = 69,
			["Level"] = self.SkillAccessCheck(69,nil,PlayerLevel),
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"PB") == 1,
			["OtherCheck"] = PlayerInCombat == true and CurrentForm ~= 6
		},
		
		-- Beast Gauge Spenders
		{
			["Type"] = 1,
			["TargetCast"] = true,
			["Name"] = "Phantom Rush",
			["ID"] = 25769,
			["Level"] = PlayerLevel >= 90,
			["OtherCheck"] = beastFull and bothNadi
		},
		{
			["Type"] = 1,
			["TargetCast"] = true,
			["Name"] = "Tornado Kick",
			["ID"] = 3543,
			["Level"] = PlayerLevel >= 60 and PlayerLevel < 90,
			["OtherCheck"] = beastFull and bothNadi
		},
		{
			["Type"] = 1,
			["TargetCast"] = false,
			["Range"] = 3,
			["Name"] = "Elixir Burst",
			["ID"] = 36948,
			["Level"] = PlayerLevel >= 92,
			["OtherCheck"] = beastFull and beastState == 1
		},
		{
			["Type"] = 1,
			["TargetCast"] = false,
			["Range"] = 3,
			["Name"] = "Elixir Field",
			["ID"] = 3545,
			["Level"] = PlayerLevel >= 60 and PlayerLevel < 92,
			["OtherCheck"] = beastFull and beastState == 1
		},
		{
			["Type"] = 1,
			["TargetCast"] = false,
			["Range"] = 3,
			["Name"] = "Rising Phoenix",
			["ID"] = 25768,
			["Level"] = PlayerLevel >= 86,
			["OtherCheck"] = beastFull and beastState == 3
		},
		{
			["Type"] = 1,
			["TargetCast"] = false,
			["Range"] = 3,
			["Name"] = "Flint Strike",
			["ID"] = 25882,
			["Level"] = PlayerLevel >= 60 and PlayerLevel < 86,
			["OtherCheck"] = beastFull and beastState == 3
		},
		{
			["Type"] = 1,
			["TargetCast"] = true,
			["Name"] = "Celestial Revolution",
			["ID"] = 25765,
			["Level"] = PlayerLevel >= 60,
			["OtherCheck"] = beastFull and beastState == 2
		},

		-- Beast Gauge Builders AoE
		{
			["Type"] = 2,
			["TargetCast"] = false,
			["Range"] = 3,
			["Name"] = "Shadow of the Destroyer", -- Gives Opo
			["ID"] = 25767,
			["Level"] = PlayerLevel >= 82,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOECount"] = 3, 
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 160, },
			["OtherCheck"] = (CurrentForm == 6) and pbAbility == 1
		},
		{
			["Type"] = 2,
			["TargetCast"] = false,
			["Range"] = 3,
			["Name"] = "Four-Point Fury", -- Gives Raptor
			["ID"] = 16473,
			["Level"] = PlayerLevel >= 45,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOECount"] = 3, 
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 160, },
			["OtherCheck"] = (CurrentForm == 6) and pbAbility == 2
		},
		{
			["Type"] = 2,
			["TargetCast"] = false,
			["Range"] = 3,
			["Name"] = "Rockbreaker", -- Gives Coeurl
			["ID"] = 70,
			["Level"] = PlayerLevel >= 30,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOECount"] = 3, 
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 160, },
			["OtherCheck"] = (CurrentForm == 6) and pbAbility == 3
		},
		
		-- Beast Gauge Builders Single Target
		-- Opo
		{
			["Type"] = 1,
			["TargetCast"] = true,
			["Name"] = "Leaping Opo",
			["ID"] = 36945,
			["Level"] = PlayerLevel >= 92,
			["OtherCheck"] = (CurrentForm == 6)and pbAbility == 1,
		},
		{
			["Type"] = 1,
			["Name"] = "Bootshine",
			["ID"] = 53,
			["Range"] = 3,
			["Level"] = PlayerLevel < 92,
			["TargetCast"] = true,
			["OtherCheck"] = (CurrentForm == 6)and pbAbility == 1,
		},
		-- Raptor
		{
			["Type"] = 1,
			["TargetCast"] = true,
			["Name"] = "Rising Raptor",
			["ID"] = 36946,
			["Level"] = PlayerLevel >= 92,
			["OtherCheck"] = (CurrentForm == 6) and pbAbility == 2,
		},
		{
			["Type"] = 1,
			["Name"] = "True Strike",
			["ID"] = 36946,
			["Range"] = 54,
			["Level"] = PlayerLevel < 92,
			["TargetCast"] = true,
			["OtherCheck"] = (CurrentForm == 6) and pbAbility == 2,
		},
		-- Coeurl
		{
			["Type"] = 1,
			["TargetCast"] = true,
			["Name"] = "Pouncing Coeurl",
			["ID"] = 36947,
			["Level"] = PlayerLevel >= 92,
			["OtherCheck"] = (CurrentForm == 6) and pbAbility == 3,
		},
		{
			["Type"] = 1,
			["Name"] = "Snap Punch",
			["ID"] = 56,
			["Range"] = 3,
			["Level"] = PlayerLevel < 92,
			["TargetCast"] = true,
			["OtherCheck"] = (CurrentForm == 6) and pbAbility == 3,
		},

				
        -- AoE GCD Rotation
        {
            ["Type"] = 2, ["Name"] = "Shadow of the Destroyer", ["ID"] = 25767, ["Range"] = 3, ["Level"] = PlayerLevel >= 82,
            ["TargetCast"] = false,
            ["OtherCheck"] = (CurrentForm == 4 or CurrentForm == 5),
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 160, },
        },
        {
            ["Type"] = 2, ["Name"] = "Rockbreaker", ["ID"] = 70, ["Range"] = 3, ["Level"] = PlayerLevel >= 30,
            ["TargetCast"] = false,
            ["OtherCheck"] = (CurrentForm == 3 or CurrentForm == 5),
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 160, },
        },
        {
            ["Type"] = 2, ["Name"] = "Four-point Fury", ["ID"] = 16473, ["Range"] = 3, ["Level"] = PlayerLevel >= 45,
            ["TargetCast"] = false,
            ["OtherCheck"] = (CurrentForm == 2 or CurrentForm == 5),
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 160, },
        },
        {
            ["Type"] = 2, ["Name"] = "Shadow of the Destroyer", ["ID"] = 25767, ["Range"] = 3, ["Level"] = PlayerLevel >= 82,
            ["TargetCast"] = false, ["OtherCheck"] = CurrentForm == 1,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 160, },
        },

		-- Melee GCD rotation
		-- OPO FORM
		{
			["Type"] = 1,
			["Name"] = "Leaping Opo",
			["ID"] = 36945,
			["Range"] = 3,
			["Level"] = PlayerLevel >= 92,
			["TargetCast"] = true,
			["OtherCheck"] = (CurrentForm == 4 or CurrentForm == 5) and furyOpo >= 1,
		},
		{
			["Type"] = 1,
			["Name"] = "Bootshine",
			["ID"] = 53,
			["Range"] = 3,
			["Level"] = PlayerLevel < 92,
			["TargetCast"] = true,
			["OtherCheck"] = (CurrentForm == 4 or CurrentForm == 5) and furyOpo >= 1,
		},
		{
			["Type"] = 1,
			["Name"] = "Dragon Kick",
			["ID"] = 74,
			["Range"] = 3,
			["Level"] = PlayerLevel >= 1,
			["TargetCast"] = true,
			["OtherCheck"] = (CurrentForm == 4 or CurrentForm == 5) and furyOpo < 1,
		},

		-- RAPTOR FORM
		{
			["Type"] = 1,
			["Name"] = "Rising Raptor",
			["ID"] = 36946,
			["Range"] = 3,
			["Level"] = PlayerLevel >= 92,
			["TargetCast"] = true,
			["OtherCheck"] = (CurrentForm == 2 or CurrentForm == 5) and furyRap >= 1,
		},
		{
			["Type"] = 1,
			["Name"] = "True Strike",
			["ID"] = 36946,
			["Range"] = 54,
			["Level"] = PlayerLevel < 92,
			["TargetCast"] = true,
			["OtherCheck"] = (CurrentForm == 2 or CurrentForm == 5) and furyRap >= 1,
		},
		{
			["Type"] = 1,
			["Name"] = "Twin Snakes",
			["ID"] = 61,
			["Range"] = 3,
			["Level"] = PlayerLevel >= 18,
			["TargetCast"] = true,
			["OtherCheck"] = (CurrentForm == 2 or CurrentForm == 5) and furyRap < 1,
		},

		-- COEURL FORM
		{
			["Type"] = 1,
			["Name"] = "Pouncing Coeurl",
			["ID"] = 36947,
			["Range"] = 3,
			["Level"] = PlayerLevel >= 92,
			["TargetCast"] = true,
			["OtherCheck"] = (CurrentForm == 3 or CurrentForm == 5) and furyCoe >= 1,
		},
		{
			["Type"] = 1,
			["Name"] = "Snap Punch",
			["ID"] = 56,
			["Range"] = 3,
			["Level"] = PlayerLevel < 92,
			["TargetCast"] = true,
			["OtherCheck"] = (CurrentForm == 3 or CurrentForm == 5) and furyCoe >= 1,
		},
		{
			["Type"] = 1,
			["Name"] = "Demolish",
			["ID"] = 66,
			["Range"] = 3,
			["Level"] = PlayerLevel >= 30,
			["TargetCast"] = true,
			["OtherCheck"] = (CurrentForm == 3 or CurrentForm == 5) and furyCoe < 1,
		},

        -- NO FORM
        {
            ["Type"] = 1, ["Name"] = "Form Shift", ["ID"] = 4262, ["Range"] = 3, ["Level"] = PlayerLevel >= 52,
            ["TargetCast"] = false,
            ["OtherCheck"] = CurrentForm == 1,
        },
        {
            ["Type"] = 1, ["Name"] = "Dragon Kick", ["ID"] = 74, ["Range"] = 3, ["Level"] = PlayerLevel >= 90,
            ["TargetCast"] = true,
            ["OtherCheck"] = CurrentForm == 1,
        },
        {
            ["Type"] = 1, ["Name"] = "Bootshine", ["ID"] = 53, ["Range"] = 3, ["Level"] = PlayerLevel >= 1,
            ["TargetCast"] = true,
            ["OtherCheck"] = CurrentForm == 1,
        },
		
		-- OGCDs
        {
            ["Type"] = 1, ["Name"] = "Howling Fist", ["ID"] = 25763, ["Range"] = 10, ["TargetCast"] = true,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
            ["Level"] = self.SkillAccessCheck(25763,16474,PlayerLevel),
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Line", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 10, ["MaxDistance"] = 10, ["LineWidth"] = 2, ["Angle"] = 160, },
        },
        {
            ["Type"] = 1, ["Name"] = "Enlightenment", ["ID"] = 16474, ["Range"] = 10, ["TargetCast"] = true,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
            ["Level"] = self.SkillAccessCheck(16474,nil,PlayerLevel),
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Line", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 10, ["MaxDistance"] = 10, ["LineWidth"] = 2, ["Angle"] = 160, },
        },
        {
            ["Type"] = 1, ["Name"] = "Steel Peak", ["ID"] = 25761, ["Range"] = 3, ["TargetCast"] = true,
            ["Level"] = self.SkillAccessCheck(25761,3547,PlayerLevel),
        },
        {
            ["Type"] = 1, ["Name"] = "The Forbidden Chakra", ["ID"] = 3547, ["Range"] = 3, ["TargetCast"] = true,
            ["OtherCheck"] = (chakra >= 5),
        },

        -- Shared CDs
        {
            ["Type"] = 1, ["Name"] = "Feint", ["ID"] = 7549, ["Range"] = 0, ["TargetCast"] = true,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Feint") == 1,
            ["OtherCheck"] = PlayerInCombat == true,
        },
        {
            ["Type"] = 1, ["Name"] = "Bloodbath", ["ID"] = 7542, ["Range"] = 0, ["TargetCast"] = false,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"SelfHealing") == 1,
            ["OtherCheck"] = PlayerInCombat == true and PlayerHP < 50,
        },
        {
            ["Type"] = 1, ["Name"] = "Second Wind", ["ID"] = 7541, ["Range"] = 0, ["TargetCast"] = false,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"SelfHealing") == 1,
            ["OtherCheck"] = PlayerInCombat == true and PlayerHP < 30,
        },
    }

    self.SendConsoleMessage(ClassTypeID.."PROFILE END",1)
    return SkillList
end

return Profile
