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
        ["Setting"] = "DOTs",
        ["Options"] = {
            { ["Name"] = "DOTs", ["Tooltip"] = "DOTs ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "DOTs", ["Tooltip"] = "DOTs OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
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
            { ["Name"] = "Hagakure", ["Tooltip"] = "Hagakure OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Hagakure", ["Tooltip"] = "Hagakure ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
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
	local HasBothBuffs = FugetsuTime > 4 and FukaTime > 4
	
	local HasMeikyoBuff = self.TargetBuff2(Player,1233,0,"Has",PlayerID)
	
	--[[
		7477	Hakaze
		7478	Jinpu
		7479	Shifu
		7480	Yukikaze
		7481	Gekko
		7482	Kasha
		7483	Fuga
		7484	Mangetsu
		7485	Oka
		7486	Enpi
		7487	Midare Setsugekka
		7488	Tenka Goken
		7489	Higanbana
		7490	Hissatsu: Shinten
		7491	Hissatsu: Kyuten
		7492	Hissatsu: Gyoten
		7493	Hissatsu: Yaten
		7495	Hagakure
		7496	Hissatsu: Guren
		7497	Meditate
		7498	Third Eye
		7499	Meikyo Shisui
		7867	Iaijutsu
		16481	Hissatsu: Senei
		16482	Ikishoten
		16483	Tsubame-gaeshi
		16485	Kaeshi: Goken
		16486	Kaeshi: Setsugekka
		16487	Shoha
		25780	Fuko
		25781	Ogi Namikiri
		25782	Kaeshi: Namikiri
		36962	Tengetsu
		36963	Gyofu
		36964	Zanshin
		36965	Tendo Goken
		36966	Tendo Setsugekka
		36967	Tendo Kaeshi Goken
		36968	Tendo Kaeshi Setsugekka
	]]--
	
	local TsubameGauge = GaugeData1[2]

	local SkillList = {
		--[[ High priority misc --]]
		{
			["Type"] = 1, ["Name"] = "Enpi", ["ID"] = 7486, ["Range"] = 20, ["TargetCast"] = true, ["OtherCheck"] = TargetDistance > 3,
		},
		{
			["Type"] = 1, ["Name"] = "Hissatsu: Gyoten", ["ID"] = 7492, ["Range"] = 3, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Jumps") == 1, ["OtherCheck"] = TargetDistance > 5 and PlayerInCombat == true and JumpTimeout == false,
		},
		--[[ Finish combos if started --]]
		{
			["Type"] = 1, ["Name"] = "Kaeshi: Namikiri", ["ID"] = 25782, ["Range"] = 8, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
		}, 
		{
			["Type"] = 1, ["Name"] = "Kaeshi: Setsugekka", ["ID"] = 16486, ["Range"] = 6, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Tendo Kaeshi: Setsugekka", ["ID"] = 36968, ["Range"] = 6, ["TargetCast"] = true,
		},
		{
			["Type"] = 2, ["Name"] = "Kaeshi: Goken", ["ID"] = 16485, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOECount"] = 1,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 8, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Tendo Kaeshi: Goken", ["ID"] = 36967, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOECount"] = 1,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 8, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		--[[ High priority Type 1 --]]
		{
			["Type"] = 1, ["Name"] = "Ogi Namikiri", ["ID"] = 25781, ["Range"] = 8, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["Buff"] = HasBothBuffs
		},
		--[[ Type 2 --]]
		{
			["Type"] = 2, ["Name"] = "Tenka Goken", ["ID"] = 7488, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOECount"] = 2,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 8, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Tendo Goken", ["ID"] = 36965, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOECount"] = 2,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 8, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Mangetsu", ["ID"] = 7484, ["Proc"] = true, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["OtherCheck"] = BestNextAction == 1, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Oka", ["ID"] = 7485, ["Proc"] = true, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["OtherCheck"] = BestNextAction == 2, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Fuga", ["ID"] = 7483, ["Range"] = 8, ["TargetCast"] = false, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Cone", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, }, ["GaugeCheck"] = TsubameGauge ~= 6 and TsubameGauge ~= 7,
		},
		{
			["Type"] = 2, ["Name"] = "Fuko", ["ID"] = 25780, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, }, ["GaugeCheck"] = TsubameGauge ~= 6 and TsubameGauge ~= 7,
		},
		--[[ Type 1 --]]
		{
			["Type"] = 1, ["Name"] = "Higanbana", ["ID"] = 7489, ["Range"] = 6, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DOTs") == 1, ["DOTCheck"] = true, ["Buff"] = self.TargetBuff2(Target,1228,8,"Missing",PlayerID) == true and HasBothBuffs,
		},
		{
			["Type"] = 1, ["Name"] = "Midare Setsugekka", ["ID"] = 7487, ["Range"] = 6, ["TargetCast"] = true,
		},
		{ 
			["Type"] = 1, ["Name"] = "Tendo Setsugekka", ["ID"] = 36966, ["Range"] = 6, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Gekko w/ Meikyo", ["ID"] = 7481, ["Range"] = 3, ["Buff"] = self.TargetBuff2(Player,1233,0,"Has",PlayerID), ["TargetCast"] = true, ["GaugeCheck"] = TsubameGauge == 0 or TsubameGauge == 1 or TsubameGauge == 4 or TsubameGauge == 5,
		},
		{
			["Type"] = 1, ["Name"] = "Kasha w/ Meikyo", ["ID"] = 7482, ["Range"] = 3, ["Buff"] = self.TargetBuff2(Player,1233,0,"Has",PlayerID), ["TargetCast"] = true, ["GaugeCheck"] = TsubameGauge == 2 or TsubameGauge == 3,
		},
		{
			["Type"] = 1, ["Name"] = "Yukikaze w/ Meikyo", ["ID"] = 7480, ["Range"] = 3, ["Buff"] = self.TargetBuff2(Player,1233,0,"Has",PlayerID), ["TargetCast"] = true, ["GaugeCheck"] = TsubameGauge == 6,
		},
		{ -- Getsu
			["Type"] = 1, ["Name"] = "Gekko", ["ID"] = 7481, ["Proc"] = true, ["Range"] = 3, ["TargetCast"] = true,
		},
		{ -- Getsu
			["Type"] = 1, ["Name"] = "Jimpu", ["ID"] = 7478, ["Proc"] = true, ["Range"] = 3, ["TargetCast"] = true, ["GaugeCheck"] = TsubameGauge == 0 or TsubameGauge == 1 or TsubameGauge == 4 or TsubameGauge == 5,
		},
		{ -- Fuka
			["Type"] = 1, ["Name"] = "Kasha", ["ID"] = 7482, ["Proc"] = true, ["Range"] = 3, ["TargetCast"] = true,
		},
		{ -- Fuka
			["Type"] = 1, ["Name"] = "Shifu", ["ID"] = 7479, ["Proc"] = true, ["Range"] = 3, ["TargetCast"] = true, ["GaugeCheck"] = TsubameGauge == 2 or TsubameGauge == 3,
		},
		{ -- Setsu
			["Type"] = 1, ["Name"] = "Yukikaze", ["ID"] = 7480, ["Proc"] = true, ["Range"] = 3, ["TargetCast"] = true, ["GaugeCheck"] = TsubameGauge == 6,
		},
		-- Start
		{
			["Type"] = 1, ["Name"] = "Hakaze", ["ID"] = 7477, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Gyofu", ["ID"] = 36963, ["Range"] = 3, ["TargetCast"] = true,
		},
		--[[ OGCD --]]
		{
			["Type"] = 1, ["Name"] = "Shoha", ["ID"] = 16487, ["Range"] = 10, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
		},
		{ 
			["Type"] = 1, ["Name"] = "Zanshin", ["ID"] = 36964, ["Range"] = 8, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["Buff"] = HasBothBuffs,
		},
		{
			["Type"] = 1, ["Name"] = "Hissatsu: Guren", ["ID"] = 7496, ["Range"] = 10, ["TargetCast"] = true, ["AOECount"] = 3, ["OtherCheck"] = PlayerInCombat == true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["Buff"] = HasBothBuffs,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Line2", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 10, ["MaxDistance"] = 0, ["LineWidth"] = 10, ["Angle"] = 0, },
		},
		{
			["Type"] = 1, ["Name"] = "Hissautssu: Senei", ["ID"] = 16481, ["Range"] = 3, ["TargetCast"] = true, ["Buff"] = HasBothBuffs,
		},
		{
			["Type"] = 1, ["Name"] = "Hissatsu: Kyuten", ["ID"] = 7491, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["OtherCheck"] = PlayerInCombat == true, ["GaugeCheck"] = GaugeData1[1] >= 50, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["Buff"] = HasBothBuffs,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
			["LastActionTimeout"] = "Kenki", ["LastActionTime"] = 2500,
		},
		{
			["Type"] = 1, ["Name"] = "Hissatsu: Shinten", ["ID"] = 7490, ["Range"] = 3, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[1] >= 50, 
			["Buff"] = HasBothBuffs,
			["LastActionTimeout"] = "Kenki", ["LastActionTime"] = 2500,
		},
		{
			["Type"] = 1, ["Name"] = "Meikyo Shisui", ["ID"] = 7499, ["Range"] = 0, ["Buff"] = not HasMeikyoBuff, ["GaugeCheck"] = TsubameGauge ~= 7, ["TargetCast"] = false,
		},
		{
			["Type"] = 1, ["Name"] = "Ikishoten", ["ID"] = 16482, ["Range"] = 0, ["TargetCast"] = false, ["GaugeCheck"] = GaugeData1[1] <= 50,
		},
		{
			["Type"] = 1, ["Name"] = "Third Eye", ["ID"] = 7498, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"ThirdEye") == 1, ["GaugeCheck"] = GaugeData1[1] <= 90,
		},
		{
			["Type"] = 1, ["Name"] = "Tengetsu", ["ID"] = 36962, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"ThirdEye") == 1, ["GaugeCheck"] = GaugeData1[1] <= 90,
		},
		{
			["Type"] = 1, ["Name"] = "Hagakure", ["ID"] = 16482, ["Range"] = 0, ["TargetCast"] = false, ["GaugeCheck"] = GaugeData1[1] <= 70, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Hagakure") == 2,
		},

		--[[ Role actions --]]
		{
			["Type"] = 1, ["Name"] = "Feint", ["ID"] = 7549, ["Range"] = 15, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerInCombat == true,
		},
		{
			["Type"] = 1, ["Name"] = "Bloodbath", ["ID"] = 7542, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerInCombat == true and PlayerHP < 50,
		},
		{
			["Type"] = 1, ["Name"] = "Second Wind", ["ID"] = 7541, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerInCombat == true and PlayerHP < 30,
		},

	}


	self.SendConsoleMessage(ClassTypeID.."PROFILE END",1)
    return SkillList
end

return Profile