local Profile = {}

Profile.Settings = {
    {
        ["Setting"] = "CDs",
        ["Options"] = {
            { ["Name"] = "CDs", ["Tooltip"] = "CDs ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "CDs", ["Tooltip"] = "CDs OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "Heals",
        ["Options"] = {
            { ["Name"] = "Heals Self", ["Tooltip"] = "Heals Self", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Heals Party", ["Tooltip"] = "Heals Party", ["Colour"] = { ["r"] = 0.7, ["g"] = 0.7, ["b"] = 1, ["a"] = 1 }, },
            { ["Name"] = "Heals Off", ["Tooltip"] = "Heals OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "Raise",
        ["Options"] = {
            { ["Name"] = "Raise", ["Tooltip"] = "Raise ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Raise", ["Tooltip"] = "Raise OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
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
    local PlayerMP = Data.PlayerMP
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
    local CurrentPet = Data.CurrentPet
    local CurrentPetData = Data.CurrentPetData
    local CurrentPetPOS = Data.CurrentPetPOS
    local LastActivePetTime = Data.LastActivePetTime

    local HasRubyTopazEmerald = GaugeData1[5] == 1 or GaugeData1[6] == 1 or GaugeData1[7] == 1
    local HasOtherSummonBuff = not self.TargetBuff2(Player,{2724,2853,2725},-1,"Missing")
    
    local AetherflowCD = self.GetActionCD(166,true)
    local GCD = self.GetActionCD(163,true)

    --[[
        163     Ruin                    ACN SMN
        172     Ruin II                 ACN SMN
        181     Fester                  ACN SMN
        3578    Painflare               SMN
        3579    Ruin III                SMN
        3581    Dreadwyrm Trance        SMN
        3582    Deathflare              SMN
        7426    Ruin IV                 SMN
        7427    Summon Bahamut          SMN
        7428    Wyrmwave                SMN
        7429    Enkindle Bahamut        SMN
        7449    Akh Morn                SMN
        16230   Physick                 ACN SMN
        16508   Energy Drain            ACN SMN
        16510   Energy Siphon           SMN
        16511   Outburst                ACN SMN
        16514   Fountain of Fire        SMN
        16515   Brand of Purgatory      SMN
        16516   Enkindle Phoenix        SMN
        16517   Everlasting Flight      SMN
        16518   Revelation              SMN
        16519   Scarlet Flame           SMN
        25798   Summon Carbuncle        ACN SMN
        25799   Radiant Aegis           ACN SMN
        25800   Aethercharge            ACN SMN
        25801   Searing Light           SMN
        25802   Summon Ruby             ACN SMN
        25803   Summon Topaz            ACN SMN
        25804   Summon Emerald          ACN SMN
        25805   Summon Ifrit            SMN
        25806   Summon Titan            SMN
        25807   Summon Garuda           SMN
        25808   Ruby Ruin               ACN SMN
        25809   Topaz Ruin              ACN SMN
        25810   Emerald Ruin            ACN SMN
        25811   Ruby Ruin II            ACN SMN
        25812   Topaz Ruin II           ACN SMN
        25813   Emerald Ruin II         ACN SMN
        25814   Ruby Outburst           ACN SMN
        25815   Topaz Outburst          ACN SMN
        25816   Emerald Outburst        ACN SMN
        25817   Ruby Ruin III           SMN
        25818   Topaz Ruin III          SMN
        25819   Emerald Ruin III        SMN
        25820   Astral Impulse          SMN
        25821   Astral Flare            SMN
        25822   Astral Flow             SMN
        25823   Ruby Rite               SMN
        25824   Topaz Rite              SMN
        25825   Emerald Rite            SMN
        25826   Tri-disaster            SMN
        25827   Ruby Disaster           SMN
        25828   Topaz Disaster          SMN
        25829   Emerald Disaster        SMN
        25830   Rekindle                SMN
        25831   Summon Phoenix          SMN
        25832   Ruby Catastrophe        SMN
        25833   Topaz Catastrophe       SMN
        25834   Emerald Catastrophe     SMN
        25835   Crimson Cyclone         SMN
        25836   Mountain Buster         SMN
        25837   Slipstream              SMN
        25838   Summon Ifrit II         SMN
        25839   Summon Titan II         SMN
        25840   Summon Garuda II        SMN
        25841   Radiant Aegis           ACN SMN
        25843   Glittering Ruby         ACN SMN
        25844   Glittering Topaz        ACN SMN
        25845   Glittering Emerald      ACN SMN
        25846   Burning Strike          SMN
        25847   Rock Buster             SMN
        25848   Aerial Slash            SMN
        25849   Inferno                 SMN
        25850   Earthen Fury            SMN
        25851   Aerial Blast            SMN
        25852   Inferno                 SMN
        25853   Earthen Fury            SMN
        25854   Aerial Blast            SMN
        25883   Gemshine                ACN SMN
        25884   Precious Brilliance     ACN SMN
        25885   Crimson Strike          SMN
        36990   Necrotize               SMN
        36991   Searing Flash           SMN
        36992   Summon Solar Bahamut    SMN
        36993   Luxwave                 SMN
        36994   Umbral Impulse          SMN
        36995   Umbral Flare            SMN
        36996   Sunflare                SMN
        36997   Lux Solaris             SMN
        36998   Enkindle Solar Bahamut  SMN
        36999   Exodus                  SMN
    ]]

	local SkillList = {

        -- Prio GCD
		-- AOE DPS
        {
			["Type"] = 1, ["Name"] = "Crimson Cyclone", ["ID"] = 25835, ["Range"] = 25, ["TargetCast"] = true, ["OGCDLimited"] = GCD > 0.6,
            ["Level"] = self.SkillAccessCheck(25835,nil,PlayerLevel), ["GaugeCheck"] = GaugeData1[3] == 0, ["OtherCheck"] = CurrentPet ~= 0, 
        },
        {
			["Type"] = 1, ["Name"] = "Crimson Strike", ["ID"] = 25885, ["Range"] = 25, ["TargetCast"] = true, ["OGCDLimited"] = GCD > 0.6,
            ["Level"] = self.SkillAccessCheck(25885,nil,PlayerLevel), ["GaugeCheck"] = GaugeData1[3] == 0, ["OtherCheck"] = CurrentPet ~= 0, 
        },
        {
			["Type"] = 1, ["Name"] = "Mountain Buster", ["ID"] = 25836, ["Range"] = 25, ["TargetCast"] = true, ["OGCDLimited"] = GCD > 0.6,
            ["Level"] = self.SkillAccessCheck(25836,nil,PlayerLevel), ["Buff"] = self.TargetBuff2(Player,2853,0,"Has"), ["OtherCheck"] = CurrentPet ~= 0,
        },
        {
			["Type"] = 1, ["Name"] = "Slipstream", ["ID"] = 25837, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = CurrentPet ~= 0, 
            ["Level"] = self.SkillAccessCheck(25837,nil,PlayerLevel), ["GaugeCheck"] = GaugeData1[3] == 0, ["Buff"] = self.TargetBuff2(Player,2725,0,"Has"),
        },

        {
			["Type"] = 1, ["Name"] = "Enkindle Bahamut", ["ID"] = 7429, ["Range"] = 25, ["TargetCast"] = true, ["OGCDLimited"] = GCD > 0.6,
            ["OtherCheck"] = CurrentPet ~= 0, ["Level"] = self.SkillAccessCheck(7429,nil,PlayerLevel),
        },
        {
			["Type"] = 1, ["Name"] = "Enkindle Solar Bahamut", ["ID"] = 36998, ["Range"] = 25, ["TargetCast"] = true, ["OGCDLimited"] = GCD > 0.6,
            ["OtherCheck"] = CurrentPet ~= 0, ["Level"] = self.SkillAccessCheck(36998,nil,PlayerLevel),
        },
        {
			["Type"] = 1, ["Name"] = "Deathflare", ["ID"] = 3582, ["Range"] = 25, ["TargetCast"] = true, ["OGCDLimited"] = GCD > 0.6,
            ["OtherCheck"] = CurrentPet ~= 0, ["Level"] = self.SkillAccessCheck(3582,nil,PlayerLevel),
        },
        {
			["Type"] = 1, ["Name"] = "Sunflare", ["ID"] = 36996, ["Range"] = 25, ["TargetCast"] = true, ["OGCDLimited"] = GCD > 0.6,
            ["OtherCheck"] = CurrentPet ~= 0, ["Level"] = self.SkillAccessCheck(36996,nil,PlayerLevel),
        },
        {
			["Type"] = 1, ["Name"] = "Searing Flesh", ["ID"] = 36991, ["Range"] = 25, ["TargetCast"] = true, ["OGCDLimited"] = GCD > 0.6,
            ["OtherCheck"] = CurrentPet ~= 0, ["Level"] = self.SkillAccessCheck(36991,nil,PlayerLevel),
        },

        {
			["Type"] = 2, ["Name"] = "Rekindle", ["ID"] = 25830, ["Range"] = 25, ["TargetCast"] = false, ["OGCDLimited"] = GCD > 0.6,
            ["OtherCheck"] = CurrentPet ~= 0, ["Level"] = self.SkillAccessCheck(25830,nil,PlayerLevel),
        },
        {
			["Type"] = 1, ["Name"] = "Enkindle Phoenix", ["ID"] = 16516, ["Range"] = 25, ["TargetCast"] = true, ["OGCDLimited"] = GCD > 0.6,
            ["OtherCheck"] = CurrentPet ~= 0, ["Level"] = self.SkillAccessCheck(16516,nil,PlayerLevel),
        },

        {
			["Type"] = 1, ["Name"] = "Ruin IV", ["ID"] = 7426, ["Range"] = 25, ["TargetCast"] = true,
        },

        -- Pet Summons
        {
			["Type"] = 2, ["Name"] = "Summon Carbuncle", ["ID"] = 25798, ["Range"] = 25, ["TargetCast"] = false, 
            ["OtherCheck"] = CurrentPet == 0 and LastActivePetTime + 5000 < HMTick() and HasOtherSummonBuff == false and PlayerMoving == false, ["LastActionTimeout"] = "PetSummon", ["LastActionTime"] = 5000,
        },
        {
			["Type"] = 2, ["Name"] = "Aethercharge", ["ID"] = 25800, ["Range"] = 25, ["TargetCast"] = false, 
            ["OtherCheck"] = CurrentPet ~= 0 and HasOtherSummonBuff == false and HasRubyTopazEmerald == false, ["Level"] = self.SkillAccessCheck(25800,3581,PlayerLevel),
        },
        {
			["Type"] = 2, ["Name"] = "Dreadwyrm Trance", ["ID"] = 3581, ["Range"] = 25, ["TargetCast"] = false, 
            ["OtherCheck"] = CurrentPet ~= 0 and HasOtherSummonBuff == false and HasRubyTopazEmerald == false, ["Level"] = self.SkillAccessCheck(3581,7427,PlayerLevel),
        },
        {
			["Type"] = 1, ["Name"] = "Summon Bahamut", ["ID"] = 7427, ["Range"] = 25, ["TargetCast"] = true, 
            ["OtherCheck"] = CurrentPet ~= 0 and HasOtherSummonBuff == false and HasRubyTopazEmerald == false, ["Level"] = self.SkillAccessCheck(7427,nil,PlayerLevel),
        },
        {
			["Type"] = 1, ["Name"] = "Summon Solar Bahamut", ["ID"] = 36992, ["Range"] = 25, ["TargetCast"] = true, 
            ["OtherCheck"] = CurrentPet ~= 0 and HasOtherSummonBuff == false and HasRubyTopazEmerald == false, ["Level"] = self.SkillAccessCheck(36992,nil,PlayerLevel),
        },
        {
			["Type"] = 1, ["Name"] = "Summon Phoenix", ["ID"] = 25831, ["Range"] = 25, ["TargetCast"] = true, 
            ["OtherCheck"] = CurrentPet ~= 0 and HasOtherSummonBuff == false and HasRubyTopazEmerald == false, ["Level"] = self.SkillAccessCheck(25831,nil,PlayerLevel),
        },
        -- Summon Ruby 
        {
			["Type"] = 1, ["Name"] = "Summon Ruby", ["ID"] = 25802, ["Range"] = 25, ["TargetCast"] = true, 
            ["OtherCheck"] = CurrentPet ~= 0 and HasOtherSummonBuff == false and GaugeData1[3] == 0 and GaugeData1[5] == 1, ["Level"] = self.SkillAccessCheck(25802,25805,PlayerLevel),
        },
        {
			["Type"] = 1, ["Name"] = "Summon Ifrit", ["ID"] = 25805, ["Range"] = 25, ["TargetCast"] = true, 
            ["OtherCheck"] = CurrentPet ~= 0 and HasOtherSummonBuff == false and GaugeData1[3] == 0 and GaugeData1[5] == 1, ["Level"] = self.SkillAccessCheck(25805,25838,PlayerLevel),
        },
        {
			["Type"] = 1, ["Name"] = "Summon Ifrit II", ["ID"] = 25838, ["Range"] = 25, ["TargetCast"] = true, 
            ["OtherCheck"] = CurrentPet ~= 0 and HasOtherSummonBuff == false and GaugeData1[3] == 0 and GaugeData1[5] == 1, ["Level"] = self.SkillAccessCheck(25838,nil,PlayerLevel),
        },
        -- Summon Topaz
        {
			["Type"] = 1, ["Name"] = "Summon Topaz", ["ID"] = 25803, ["Range"] = 25, ["TargetCast"] = true, 
            ["OtherCheck"] = CurrentPet ~= 0 and HasOtherSummonBuff == false and GaugeData1[3] == 0 and GaugeData1[5] == 0 and GaugeData1[6] == 1, ["Level"] = self.SkillAccessCheck(25803,25806,PlayerLevel),
        },
        {
			["Type"] = 1, ["Name"] = "Summon Titan", ["ID"] = 25806, ["Range"] = 25, ["TargetCast"] = true, 
            ["OtherCheck"] = CurrentPet ~= 0 and HasOtherSummonBuff == false and GaugeData1[3] == 0 and GaugeData1[5] == 0 and GaugeData1[6] == 1, ["Level"] = self.SkillAccessCheck(25806,25839,PlayerLevel),
        },
        {
			["Type"] = 1, ["Name"] = "Summon Titan II", ["ID"] = 25839, ["Range"] = 25, ["TargetCast"] = true, 
            ["OtherCheck"] = CurrentPet ~= 0 and HasOtherSummonBuff == false and GaugeData1[3] == 0 and GaugeData1[5] == 0 and GaugeData1[6] == 1, ["Level"] = self.SkillAccessCheck(25839,nil,PlayerLevel),
        },
        -- Summon Topaz
        {
			["Type"] = 1, ["Name"] = "Summon Emerald", ["ID"] = 25804, ["Range"] = 25, ["TargetCast"] = true, 
            ["OtherCheck"] = CurrentPet ~= 0 and HasOtherSummonBuff == false and GaugeData1[3] == 0 and GaugeData1[5] == 0 and GaugeData1[6] == 0 and GaugeData1[7] == 1, ["Level"] = self.SkillAccessCheck(25804,25807,PlayerLevel),
        },
        {
			["Type"] = 1, ["Name"] = "Summon Garuda", ["ID"] = 25807, ["Range"] = 25, ["TargetCast"] = true, 
            ["OtherCheck"] = CurrentPet ~= 0 and HasOtherSummonBuff == false and GaugeData1[3] == 0 and GaugeData1[5] == 0 and GaugeData1[6] == 0 and GaugeData1[7] == 1, ["Level"] = self.SkillAccessCheck(25807,25840,PlayerLevel),
        },
        {
			["Type"] = 1, ["Name"] = "Summon Garuda II", ["ID"] = 25840, ["Range"] = 25, ["TargetCast"] = true, 
            ["OtherCheck"] = CurrentPet ~= 0 and HasOtherSummonBuff == false and GaugeData1[3] == 0 and GaugeData1[5] == 0 and GaugeData1[6] == 0 and GaugeData1[7] == 1, ["Level"] = self.SkillAccessCheck(25840,nil,PlayerLevel),
        },
        
		{
			["Type"] = 2, ["Name"] = "Physick", ["ID"] = 16230, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 60, ["PartyOnly"] = true,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Heals") == 1,
		},
		{
			["Type"] = 3, ["Name"] = "Physick", ["ID"] = 16230, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 60, ["PartyOnly"] = true,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Heals") == 2,
		},
        -- Prio GCD

		-- AOE Pet Stuff
        {
			["Type"] = 1, ["Name"] = "Astral Flare", ["ID"] = 25821, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(3578,nil,PlayerLevel),
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
        },
        {
			["Type"] = 1, ["Name"] = "Brand of Purgatory", ["ID"] = 16515, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(16515,nil,PlayerLevel),
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
        },
        -- Ruby
        {
			["Type"] = 1, ["Name"] = "Ruby Outburst", ["ID"] = 25814, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25814,25827,PlayerLevel), ["GaugeCheck"] = GaugeData1[3] > 0,
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
        },
        {
			["Type"] = 1, ["Name"] = "Ruby Disaster", ["ID"] = 25827, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25827,25832,PlayerLevel), ["GaugeCheck"] = GaugeData1[3] > 0,
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
        },
        {
			["Type"] = 1, ["Name"] = "Ruby Catastrophere", ["ID"] = 25832, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25832,nil,PlayerLevel), ["GaugeCheck"] = GaugeData1[3] > 0,
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
        },
        -- Topaz
        {
			["Type"] = 1, ["Name"] = "Topaz Outburst", ["ID"] = 25815, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25815,25828,PlayerLevel), ["GaugeCheck"] = GaugeData1[3] > 0,
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
        },
        {
			["Type"] = 1, ["Name"] = "Topaz Disaster", ["ID"] = 25828, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25828,25833,PlayerLevel), ["GaugeCheck"] = GaugeData1[3] > 0,
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
        },
        {
			["Type"] = 1, ["Name"] = "Topaz Catastrophere", ["ID"] = 25833, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25833,nil,PlayerLevel), ["GaugeCheck"] = GaugeData1[3] > 0,
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
        },
        -- Emerald
        {
			["Type"] = 1, ["Name"] = "Emerald Outburst", ["ID"] = 25816, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25816,25829,PlayerLevel), ["GaugeCheck"] = GaugeData1[3] > 0,
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
        },
        {
			["Type"] = 1, ["Name"] = "Emerald Disaster", ["ID"] = 25829, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25829,25834,PlayerLevel), ["GaugeCheck"] = GaugeData1[3] > 0,
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
        },
        {
			["Type"] = 1, ["Name"] = "Emerald Catastrophere", ["ID"] = 25834, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25834,nil,PlayerLevel), ["GaugeCheck"] = GaugeData1[3] > 0,
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
        },

		-- AOE Other GCD
        {
			["Type"] = 1, ["Name"] = "Painflare", ["ID"] = 3578, ["Range"] = 25, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[10] > 0, ["Level"] = self.SkillAccessCheck(3578,nil,PlayerLevel),
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
        },
        {
			["Type"] = 1, ["Name"] = "Tri-disaster", ["ID"] = 25826, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25826,nil,PlayerLevel), ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1, 
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
        },
		-- Single Target
        {
			["Type"] = 1, ["Name"] = "Necrotize", ["ID"] = 36990, ["Range"] = 25, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[10] > 0, 
        },
        {
			["Type"] = 1, ["Name"] = "Fester", ["ID"] = 181, ["Range"] = 25, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[10] > 0, 
        },

        -- Single Target Pet Stuff
        {
			["Type"] = 1, ["Name"] = "Astral Impulse", ["ID"] = 25820, ["Range"] = 25, ["TargetCast"] = true,
        },
        {
			["Type"] = 1, ["Name"] = "Fountian of Fire", ["ID"] = 16514, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(16514,nil,PlayerLevel),
        },
        -- Ruby
        {
			["Type"] = 1, ["Name"] = "Ruby Ruin", ["ID"] = 25808, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25808,25811,PlayerLevel), ["GaugeCheck"] = GaugeData1[3] > 0,
        },
        {
			["Type"] = 1, ["Name"] = "Ruby Ruin II", ["ID"] = 25811, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25811,25817,PlayerLevel), ["GaugeCheck"] = GaugeData1[3] > 0,
        },
        {
			["Type"] = 1, ["Name"] = "Ruby Ruin III", ["ID"] = 25817, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25817,25823,PlayerLevel), ["GaugeCheck"] = GaugeData1[3] > 0,
        },
        {
			["Type"] = 1, ["Name"] = "Ruby Rite", ["ID"] = 25823, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25823,nil,PlayerLevel), ["GaugeCheck"] = GaugeData1[3] > 0,
        },
        -- Topaz
        {
			["Type"] = 1, ["Name"] = "Topaz Ruin", ["ID"] = 25809, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25809,25812,PlayerLevel), ["GaugeCheck"] = GaugeData1[3] > 0,
        },
        {
			["Type"] = 1, ["Name"] = "Topaz Ruin II", ["ID"] = 25812, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25812,25818,PlayerLevel), ["GaugeCheck"] = GaugeData1[3] > 0,
        },
        {
			["Type"] = 1, ["Name"] = "Topaz Ruin III", ["ID"] = 25818, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25818,25824,PlayerLevel), ["GaugeCheck"] = GaugeData1[3] > 0,
        },
        {
			["Type"] = 1, ["Name"] = "Topaz Rite", ["ID"] = 25824, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25824,nil,PlayerLevel), ["GaugeCheck"] = GaugeData1[3] > 0,
        },
        -- Emerald
        {
			["Type"] = 1, ["Name"] = "Emerald Ruin", ["ID"] = 25810, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25810,25813,PlayerLevel), ["GaugeCheck"] = GaugeData1[3] > 0,
        },
        {
			["Type"] = 1, ["Name"] = "Emerald Ruin II", ["ID"] = 25813, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25813,25819,PlayerLevel), ["GaugeCheck"] = GaugeData1[3] > 0,
        },
        {
			["Type"] = 1, ["Name"] = "Emerald Ruin III", ["ID"] = 25819, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25819,25825,PlayerLevel), ["GaugeCheck"] = GaugeData1[3] > 0,
        },
        {
			["Type"] = 1, ["Name"] = "Emerald Rite", ["ID"] = 25825, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25825,nil,PlayerLevel), ["GaugeCheck"] = GaugeData1[3] > 0,
        },

        {
			["Type"] = 1, ["Name"] = "Outburst", ["ID"] = 16511, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(16511,nil,PlayerLevel),
        },


        
        -- Single Target Other GCD
        {
			["Type"] = 1, ["Name"] = "Ruin", ["ID"] = 163, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(163,172,PlayerLevel),
        },
        {
			["Type"] = 1, ["Name"] = "Ruin II", ["ID"] = 172, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(172,3579,PlayerLevel),
        },
        {
			["Type"] = 1, ["Name"] = "Ruin III", ["ID"] = 3579, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25826,nil,PlayerLevel),
        },

        {
			["Type"] = 1, ["Name"] = "Energy Siphon", ["ID"] = 16510, ["Range"] = 25, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[10] == 0, ["Level"] = self.SkillAccessCheck(16510,nil,PlayerLevel),
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
        },
        {
			["Type"] = 1, ["Name"] = "Energy Drain", ["ID"] = 16508, ["Range"] = 25, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[10] == 0, 
        },
        -- CDs
        
        {
			["Type"] = 2, ["Name"] = "Lux Solaris", ["ID"] = 36997, ["Range"] = 25, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true and PlayerHP < 80, 
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
        },
        {
			["Type"] = 2, ["Name"] = "Radiant Aegis", ["ID"] = 25799, ["Range"] = 25, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true and PlayerHP < 80, 
			["LastActionTimeout"] = "RadiantAegis", ["LastActionTime"] = 5000,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["Buff"] = self.TargetBuff2(Player,2702,-1,"Missing")
        },
        {
			["Type"] = 2, ["Name"] = "Searing Light", ["ID"] = 25801, ["Range"] = 25, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true, 
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
        },
        {
			["Type"] = 1, ["Name"] = "Addle", ["ID"] = 7560, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = PlayerInCombat == true, 
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
        },

        {
			["Type"] = 2, ["Name"] = "Lucid Dreaming", ["ID"] = 7562, ["Range"] = 25, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true and PlayerMP < 70, 
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
        },
        
			
	}

	self.SendConsoleMessage(ClassTypeID.."PROFILE END",1)
    return SkillList
end

return Profile