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
        ["Setting"] = "ThirdEye",
        ["Options"] = {
            { ["Name"] = "Third Eye", ["Tooltip"] = "Third Eye ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Third Eye", ["Tooltip"] = "Third Eye OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "Hagakure",
        ["Options"] = {
            { ["Name"] = "Hagakure", ["Tooltip"] = "Hagakure ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Hagakure", ["Tooltip"] = "Hagakure OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "DOTs",
        ["Options"] = {
            { ["Name"] = "DOTs", ["Tooltip"] = "DOTs OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "DOTs", ["Tooltip"] = "DOTs ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
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

    local BestNextAction = 1
	local FugetsuTime = 0
	local FukaTime = 0
	for i,e in pairs(Player.buffs) do
		local BuffID = e.id
		if BuffID == 1298 then FugetsuTime = e.duration end
		if BuffID == 1299 then FukaTime = e.duration end
	end
	if FugetsuTime > FukaTime then BestNextAction = 2 end

	local SkillList = {
		{ 
			["Type"] = 2, ["Name"] = "Tenka Goken", ["ID"] = 7488,
			["Range"] = 0, ["TargetCast"] = false,  ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1 and self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["Buff"] = self.TargetBuff2(Player,1298,0,"Has",PlayerID) and self.TargetBuff2(Player,1299,0,"Has",PlayerID),
			["AOECount"] = 3,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 8, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Kaeshi: Goken", ["ID"] = 16485, ["Range"] = 0, ["TargetCast"] = false, 
		},
		{
			["Type"] = 2, ["Name"] = "Mangetsu", ["ID"] = 7484, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["Buff"] = self.TargetBuff2(Player,1233,0,"Has",PlayerID), ["GaugeCheck"] = GaugeData1[2] == 0, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Oka", ["ID"] = 7485, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["Buff"] = self.TargetBuff2(Player,1233,0,"Has",PlayerID), ["GaugeCheck"] = GaugeData1[2] == 2, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Yukize", ["ID"] = 7480, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["Buff"] = self.TargetBuff2(Player,1233,0,"Has",PlayerID), ["GaugeCheck"] = GaugeData1[2] == 2, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},

		{ -- 26
			["Type"] = 2, ["Name"] = "Fuga", ["ID"] = 7483, ["ComboIDNOT"] = { [7483] = PlayerLevel >= 26, }, ["Range"] = 8, ["TargetCast"] = false, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Cone", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{ -- 86
			["Type"] = 2, ["Name"] = "Fuko", ["ID"] = 25780, ["ComboIDNOT"] = { [7477] = PlayerLevel >= 4, [7478] = PlayerLevel >= 30, [7479] = PlayerLevel >= 40, [25780] = PlayerLevel >= 86, }, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{ -- 35
			["Type"] = 2, ["Name"] = "Mangetsu", ["ID"] = 7484, ["ComboID"] = { [25780] = true, [7483] = true, }, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["GaugeCheck"] = GaugeData1[2] == 0 or TargetID == 0 and BestNextAction == 1, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{ -- 45
			["Type"] = 2, ["Name"] = "Oka", ["ID"] = 7485, ["ComboID"] = { [25780] = true, [7483] = true, }, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["GaugeCheck"] = GaugeData1[2] == 2 or TargetID == 0 and BestNextAction == 2, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 1, ["Name"] = "Midare Setsugekka", ["ID"] = 7487, ["Range"] = 3, ["TargetCast"] = true,  ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Kaeshi: Setsugekka", ["ID"] = 16486, ["Range"] = 3, ["TargetCast"] = true,
		},
		{ -- Higanbana buff 1228, fugetsu 1298 fuka 1299
			["Type"] = 1, ["Name"] = "Higanbana", ["ID"] = 7489, ["Range"] = 3, ["TargetCast"] = true,  ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1 and self.GetSettingsValue(ClassTypeID,"DOTs") == 2, 
			["Buff"] = self.TargetBuff2(Target,1228,6,"Missing",PlayerID) and self.TargetBuff2(Player,1298,0,"Has",PlayerID) and self.TargetBuff2(Player,1299,0,"Has",PlayerID),
		},
		{
			["Type"] = 2, ["Name"] = "Shoha II", ["ID"] = 25779, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["OtherCheck"] = PlayerInCombat == true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 1, ["Name"] = "Shoha", ["ID"] = 16487, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Hissatsu: Gyoten", ["ID"] = 7492, ["Range"] = 20, ["TargetCast"] = true, ["SettingValue"] = JumpTimeout == false and self.GetSettingsValue(ClassTypeID,"Jumps") == 1, ["OtherCheck"] = TargetDistance > 15,
		},
		{
			["Type"] = 1, ["Name"] = "Ogi Namikiri", ["ID"] = 25781, ["Range"] = 8, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Kaeshi: Namikiri", ["ID"] = 25782, ["Range"] = 8, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Hissautssu: Senei", ["ID"] = 16481, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Hakaze", ["ID"] = 7477, ["ComboIDNOT"] = { [7477] = PlayerLevel >= 4, [7478] = PlayerLevel >= 30, [7479] = PlayerLevel >= 40, }, ["Range"] = 3, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[2] == 6,
		},
		{
			["Type"] = 1, ["Name"] = "Yukikze", ["ID"] = 7480, ["ComboID"] = { [7477] = true,}, ["Range"] = 3, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[2] == 6,
		},

		--These are for AOE with Meikyo Shisui
		{
			["Type"] = 1, ["Name"] = "Mangetsu", ["ID"] = 7484, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["Buff"] = self.TargetBuff2(Player,1233,0,"Has",PlayerID), ["OtherCheck"] = PlayerInCombat == true, ["GaugeCheck"] = GaugeData1[2] == 0, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 1, ["Name"] = "Oka", ["ID"] = 7485, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["Buff"] = self.TargetBuff2(Player,1233,0,"Has",PlayerID), ["OtherCheck"] = PlayerInCombat == true, ["GaugeCheck"] = GaugeData1[2] == 2, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 1, ["Name"] = "Yukize", ["ID"] = 7480, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["Buff"] = self.TargetBuff2(Player,1233,0,"Has",PlayerID), ["OtherCheck"] = PlayerInCombat == true, ["GaugeCheck"] = GaugeData1[2] == 2, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},

		--Aoe Rotation
		{ -- 26
			["Type"] = 2, ["Name"] = "Fuga", ["ID"] = 7483, ["ComboIDNOT"] = { [7483] = PlayerLevel >= 26, }, ["Range"] = 8, ["TargetCast"] = false, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Cone", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{ -- 86
			["Type"] = 2, ["Name"] = "Fuko", ["ID"] = 25780, ["ComboIDNOT"] = { [25780] = PlayerLevel >= 86, }, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{ -- 35
			["Type"] = 2, ["Name"] = "Mangetsu", ["ID"] = 7484, ["ComboID"] = { [25780] = true, [7483] = true, }, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["GaugeCheck"] = GaugeData1[2] == 0, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{ -- 45
			["Type"] = 2, ["Name"] = "Oka", ["ID"] = 7485, ["ComboID"] = { [25780] = true, [7483] = true, }, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["GaugeCheck"] = GaugeData1[2] == 2, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
        
		--These are for Single Target with Meikyo Shisui
		{
			["Type"] = 1, ["Name"] = "Gekko", ["ID"] = 7481, ["Range"] = 3, ["Buff"] = self.TargetBuff2(Player,1233,0,"Has",PlayerID), ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[2] == 0,
		},
		{
			["Type"] = 1, ["Name"] = "Kasha", ["ID"] = 7482, ["Range"] = 3, ["Buff"] = self.TargetBuff2(Player,1233,0,"Has",PlayerID), ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[2] == 2,
		},
		{
			["Type"] = 1, ["Name"] = "Yukikze", ["ID"] = 7480, ["Range"] = 3, ["Buff"] = self.TargetBuff2(Player,1233,0,"Has",PlayerID), ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[2] == 6,
		},

		{
			["Type"] = 1, ["Name"] = "Hakaze", ["ID"] = 7477, ["ComboIDNOT"] = { [7477] = PlayerLevel >= 4, [7478] = PlayerLevel >= 30, [7479] = PlayerLevel >= 40, }, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Jimpu", ["ID"] = 7478, ["ComboID"] = { [7477] = true,}, ["Range"] = 3, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[2] == 0,
		},
		{
			["Type"] = 1, ["Name"] = "Gekko", ["ID"] = 7481, ["ComboID"] = { [7478] = true,}, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Shifu", ["ID"] = 7479, ["ComboID"] = { [7477] = true,}, ["Range"] = 3, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[2] == 2,
		},
		{
			["Type"] = 1, ["Name"] = "Kasha", ["ID"] = 7482, ["ComboID"] = { [7479] = true,}, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Yukikze", ["ID"] = 7480, ["ComboID"] = { [7477] = true,}, ["Range"] = 3, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[2] == 6,
		},
		{
			["Type"] = 1, ["Name"] = "Hissatsu: Kyunten", ["ID"] = 7483, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["OtherCheck"] = PlayerInCombat == true, ["GaugeCheck"] = GaugeData1[1] >= 70, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 1, ["Name"] = "Hissatsu: Shinten", ["ID"] = 7490, ["Range"] = 3, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[1] >= 70, --May not need gauge check.
		},
		{
			["Type"] = 1, ["Name"] = "Hissatsu: Guren", ["ID"] = 7496, ["ComboIDNOT"] = { [25780] = true, }, ["Range"] = 10, ["TargetCast"] = false, ["AOECount"] = 3, ["OtherCheck"] = PlayerInCombat == true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Line", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 10, ["MaxDistance"] = 0, ["LineWidth"] = 10, ["Angle"] = 0, },
		},
		{
			["Type"] = 1, ["Name"] = "Ikishoten", ["ID"] = 16482, ["Range"] = 0, ["TargetCast"] = false, ["GaugeCheck"] = GaugeData1[1] <= 50,
		},
		{
			["Type"] = 1, ["Name"] = "Hissatsu: Kaiten", ["ID"] = 7494, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["GaugeCheck"] = GaugeData1[1] >=45 , ["Buff"] = self.TargetBuff2(Player,1229,0,"Missing",PlayerID),
		},
		{
			["Type"] = 1, ["Name"] = "Third Eye", ["ID"] = 7498, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"ThirdEye") == 1, ["GaugeCheck"] = GaugeData1[1] <= 90,
		},
		{
			["Type"] = 1, ["Name"] = "Meikyo Shisui", ["ID"] = 7499, ["Range"] = 0, ["Buff"] = self.TargetBuff2(Player,1233,0,"Missing",PlayerID) and self.TargetBuff2(Player,2959,0,"Missing",PlayerID) and self.TargetBuff2(Player,1298,0,"Has",PlayerID) and self.TargetBuff2(Player,1299,0,"Has",PlayerID), ["TargetCast"] = false, ["GaugeCheck"] = GaugeData1[2] ==0 and GaugeData1[3] ~= 3,
		},
		{
			["Type"] = 1, ["Name"] = "Hagakure", ["ID"] = 16482, ["Range"] = 0, ["TargetCast"] = false, ["GaugeCheck"] = GaugeData1[1] <= 70, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Hagakure") == 1,
		},
		--{
		--["Name"] = "Meditate", ["ID"] = 7497, ["Range"] = 0, ["TargetCast"] = false,   %%%%Stands and cast to increase Kenki, want it to use action to on;y get Meditation Stack.
		--},

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
    return SkillList
end

return Profile