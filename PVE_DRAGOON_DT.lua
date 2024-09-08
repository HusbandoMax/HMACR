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
        ["Setting"] = "Debuffs",
        ["Options"] = {
            { ["Name"] = "Debuffs", ["Tooltip"] = "Debuffs ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Debuffs", ["Tooltip"] = "Debuffs OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "CDs",
        ["Options"] = {
            { ["Name"] = "CDs", ["Tooltip"] = "CDs ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "CDs", ["Tooltip"] = "CDs OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "Jumps",
        ["Options"] = {
            { ["Name"] = "Jumps", ["Tooltip"] = "Jumps ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Jumps", ["Tooltip"] = "Jumps OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "PositionalHelper",
        ["Options"] = {
            { ["Name"] = "POS HELP", ["Tooltip"] = "Positional Helper OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "POS HELP", ["Tooltip"] = "Positional Helper ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
        },
    },
}

function Profile:SkillTable(Data,Target,ClassTypeID)
	self.SendConsoleMessage(ClassTypeID.." PROFILE",1)

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

	--[[
		75      True Thrust             LNC DRG
		78      Vorpal Thrust           LNC DRG
		83      Life Surge              LNC DRG
		84      Full Thrust             LNC DRG
		85      Lance Charge            LNC DRG
		86      Doom Spike              DRG
		87      Disembowel              LNC DRG
		88      Chaos Thrust            LNC DRG
		90      Piercing Talon          LNC DRG
		92      Jump                    DRG
		94      Elusive Jump            DRG
		96      Dragonfire Dive         DRG
		3554    Fang and Claw           DRG
		3555    Geirskogul              DRG
		3556    Wheeling Thrust         DRG
		3557    Battle Litany           DRG
		7397    Sonic Thrust            DRG
		7399    Mirage Dive             DRG
		7400    Nastrond                DRG
		16477   Coerthan Torment        DRG
		16478   High Jump               DRG
		16479   Raiden Thrust           DRG
		16480   Stardiver               DRG
		25770   Draconian Fury          DRG
		25771   Heavens' Thrust         DRG
		25772   Chaotic Spring          DRG
		25773   Wyrmwind Thrust         DRG
		36951   Winged Glide            DRG
		36952   Drakesbane              DRG
		36953   Rise of the Dragon      DRG
		36954   Lance Barrage           DRG
		36955   Spiral Blow             DRG
		36956   Starcross               DRG
	]]
	local Positinal = "None"
	if self.ActionProc(3554) == true then -- Fang and Claw
		Positinal = "Flank"
	elseif self.ActionProc(3556) == true then -- Wheeling Thrust
		Positinal = "Rear"
	end
	local SkillList = {
		-- AOE
		{
			["Type"] = 1, ["Name"] = "Wyrmwind Thrust", ["ID"] = 25773, ["Range"] = 15, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["Proc"] = true,
		},

		{
			["Type"] = 1, ["Name"] = "Draconian Fury", ["ID"] = 25770, ["Range"] = 10, ["TargetCast"] = true, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["Proc"] = true,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Line2", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 10, ["MaxDistance"] = 10, ["LineWidth"] = 4, ["Angle"] = 0, },
		},
		{
			["Type"] = 1, ["Name"] = "Coerthan Torment", ["ID"] = 16477, ["Range"] = 10, ["TargetCast"] = true, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["Proc"] = true,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Line2", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 10, ["MaxDistance"] = 10, ["LineWidth"] = 4, ["Angle"] = 0, },
		},
		{
			["Type"] = 1, ["Name"] = "Sonic Thrust", ["ID"] = 7397, ["Range"] = 10, ["TargetCast"] = true, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["Proc"] = true,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Line2", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 10, ["MaxDistance"] = 10, ["LineWidth"] = 4, ["Angle"] = 0, },
		},
		{
			["Type"] = 1, ["Name"] = "Doom Spike", ["ID"] = 86, ["Range"] = 10, ["TargetCast"] = true, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Line2", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 10, ["MaxDistance"] = 10, ["LineWidth"] = 4, ["Angle"] = 0, },
		},

		-- Single
		{
			["Type"] = 1, ["Name"] = "Drakesbane", ["ID"] = 36952, ["Range"] = 3, ["TargetCast"] = true,
		},

		{
			["Type"] = 1, ["Name"] = "Raiden Thrust", ["ID"] = 16479, ["Range"] = 3, ["TargetCast"] = true, ["Proc"] = true,
		},

		{
			["Type"] = 1, ["Name"] = "Spiral Blow", ["ID"] = 36955, ["Proc"] = true, ["Range"] = 3, ["Buff"] = self.TargetBuff2(Player,2720,0,"Missing",PlayerID), ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Disembowel", ["ID"] = 87, ["Proc"] = true, ["Range"] = 3, ["Buff"] = self.TargetBuff2(Player,2720,0,"Missing",PlayerID), ["TargetCast"] = true,
		},

		{
			["Type"] = 1, ["Name"] = "Wheeling Thrust", ["ID"] = 3556, ["Proc"] = true,  ["Range"] = 3, ["TargetCast"] = true,
		},

		{
			["Type"] = 1, ["Name"] = "Chaotic Spring", ["ID"] = 25772, ["Proc"] = true,  ["TargetCast"] = true, 
		},
		{
			["Type"] = 1, ["Name"] = "Chaos Thrust", ["ID"] = 88, ["Proc"] = true, ["TargetCast"] = true,
		},

		{
			["Type"] = 1, ["Name"] = "Fang and Claw", ["ID"] = 3554, ["Proc"] = true, ["Range"] = 3, ["TargetCast"] = true,
		},

		{
			["Type"] = 1, ["Name"] = "Heaven's Thrust", ["ID"] = 25771, ["Proc"] = true,  ["Range"] = 3, ["TargetCast"] = true, 
		},
		{
			["Type"] = 1, ["Name"] = "Full Thrust", ["ID"] = 84, ["Proc"] = true,  ["Range"] = 3, ["TargetCast"] = true, 
		},

		{
			["Type"] = 1, ["Name"] = "Lance Barrage", ["ID"] = 36954, ["Proc"] = true, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Vorpal Thrust", ["ID"] = 78, ["Proc"] = true, ["Range"] = 3, ["TargetCast"] = true,
		},

		{
			["Type"] = 1, ["Name"] = "True Thrust", ["ID"] = 75, ["Range"] = 3, ["TargetCast"] = true,
		},


		{
			["Type"] = 1, ["Name"] = "Piercing Talon", ["ID"] = 90, ["Range"] = 20, ["TargetCast"] = true, ["OtherCheck"] = TargetDistance > 3,
		},

		-- OGCD
		{
			["Type"] = 1, ["Name"] = "Starcross", ["ID"] = 36956, ["Proc"] = true, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Stardiver AOE", ["ID"] = 16480, ["Range"] = 20, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[3] < 3000,
			["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["Proc"] = true,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Line2", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 20, ["MaxDistance"] = 20, ["LineWidth"] = 4, ["Angle"] = 0, },
		
		},
		{
			["Type"] = 1, ["Name"] = "Stardiver", ["ID"] = 16480, ["Range"] = 20, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[3] < 3000,
		},

		{
			["Type"] = 1, ["Name"] = "Nastrond", ["ID"] = 7400, ["Range"] = 20, ["Buff"] = self.TargetBuff2(Player,3844,0,"Has",PlayerID), ["TargetCast"] = true, --["GaugeCheck"] = GaugeData1[3] >= 1000,--3844
		},
		{
			["Type"] = 1, ["Name"] = "Geirskogul", ["ID"] = 3555, ["Range"] = 20, ["TargetCast"] = true,
		},

		{
			["Type"] = 1, ["Name"] = "Mirage Dive", ["ID"] = 7399, ["Range"] = 20, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "High Jump", ["ID"] = 16478, ["Range"] = 20, ["TargetCast"] = true, ["SettingValue"] = JumpTimeout == false and self.GetSettingsValue(ClassTypeID,"Jumps") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Jump", ["ID"] = 92, ["Range"] = 20, ["TargetCast"] = true, ["SettingValue"] = JumpTimeout == false and self.GetSettingsValue(ClassTypeID,"Jumps") == 1,
		},

		{
			["Type"] = 1, ["Name"] = "Rise of the Dragon", ["ID"] = 36953, ["Range"] = 20, ["TargetCast"] = true, ["SettingValue"] = JumpTimeout == false and self.GetSettingsValue(ClassTypeID,"Jumps") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Dragonfire Dive", ["ID"] = 96, ["Range"] = 20, ["TargetCast"] = true, ["SettingValue"] = JumpTimeout == false and self.GetSettingsValue(ClassTypeID,"Jumps") == 1,
		},
		
		{
			["Type"] = 1, ["Name"] = "Battle Litnay", ["ID"] = 3557, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerInCombat == true,
		},
		{
			["Type"] = 1, ["Name"] = "Life Surge", ["ID"] = 83, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerInCombat == true,
		},
		{
			["Type"] = 1, ["Name"] = "Lance Charge", ["ID"] = 85, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerInCombat == true,
		},
		{
			["Type"] = 1, ["Name"] = "Dragon Sight", ["ID"] = 7398, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerInCombat == true,
		},

		-- Shared CDS
		{
			["Type"] = 1, ["Name"] = "Feint", ["ID"] = 7549, ["Range"] = 0, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerInCombat == true,
		},
		{
			["Type"] = 1, ["Name"] = "Bloodbath", ["ID"] = 7542, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerInCombat == true and PlayerHP < 50,
		},
		{
			["Type"] = 1, ["Name"] = "Seccond Wind", ["ID"] = 7541, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerInCombat == true and PlayerHP < 30,
		},

	}

	self.SendConsoleMessage(ClassTypeID.."PROFILE END",1)
    return SkillList,Positinal
end

return Profile