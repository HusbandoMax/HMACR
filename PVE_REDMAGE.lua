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
        ["Setting"] = "JumpIn",
        ["Options"] = {
            { ["Name"] = "Jump In", ["Tooltip"] = "Jump In ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Jump In", ["Tooltip"] = "Jump In OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "JumpOut",
        ["Options"] = {
            { ["Name"] = "Jump Out", ["Tooltip"] = "Jump Out ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Jump Out", ["Tooltip"] = "Jump Out OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "Raise",
        ["Options"] = {
            { ["Name"] = "Raise", ["Tooltip"] = "Raise ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Raise", ["Tooltip"] = "Raise OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "Heals",
        ["Options"] = {
            { ["Name"] = "Heals", ["Tooltip"] = "Heals ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Heals", ["Tooltip"] = "Heals OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
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
    
	local HasDualcastBuff = self.TargetBuff2(Player,1249,0,"Has",PlayerID)

	local OGCDTime = ActionList:Get(1,7505).cd

	local SkillList = {
		{
			["Type"] = 3, ["Name"] = "Vercure", ["ID"] = 7514, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 50, ["PartyOnly"] = false, ["OtherCheck"] = PlayerMoving == false and HasDualcastBuff == false,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Heals") == 1,
		},

		{
			["Type"] = 2, ["Name"] = "Manafication", ["ID"] = 7521, ["Range"] = 3, ["TargetCast"] = false, ["GaugeCheck"] = GaugeData1[1] < 40 and GaugeData1[2] < 40, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
		},

		{
			["Type"] = 1, ["Name"] = "Corps-a-corps", ["ID"] = 7506, ["Range"] = 25, ["TargetCast"] = true, ["SettingValue"] = JumpTimeout == false and self.GetSettingsValue(ClassTypeID,"JumpIn") == 1, ["OGCDLimited"] = OGCDTime > 0.6, ["OtherCheck"] = PlayerInCombat == true and TargetDistance > 3, ["GaugeCheck"] = GaugeData1[1] >= 50 and GaugeData1[2] >= 50,
			["LastActionTimeout"] = "RDMJump", ["LastActionTime"] = 5000,
		},
		{
			["Type"] = 1, ["Name"] = "Displacment", ["ID"] = 7515, ["Range"] = 5, ["TargetCast"] = true, ["SettingValue"] = JumpTimeout == false and self.GetSettingsValue(ClassTypeID,"JumpOut") == 1, ["OtherCheck"] = PlayerInCombat == true and TargetDistance < 5, ["ComboIDNOT"] = { [7504] = true, [7512] = true, },
			["LastActionTimeout"] = "RDMJump", ["LastActionTime"] = 5000,
		},

		{
			["Type"] = 1, ["Name"] = "Enchanted Riposte", ["ID"] = 7504, ["Range"] = 3, ["TargetCast"] = true, ["OtherCheck"] = PlayerLevel < 2,
		},
		{
			["Type"] = 1, ["Name"] = "Enchanted Riposte", ["ID"] = 7527, ["Range"] = 3, ["TargetCast"] = true, ["OtherCheck"] = PlayerLevel < 35, ["GaugeCheck"] = GaugeData1[1] >= 20 and GaugeData1[2] >= 20,
		},
		{
			["Type"] = 1, ["Name"] = "Enchanted Riposte", ["ID"] = 7527, ["Range"] = 3, ["TargetCast"] = true, ["OtherCheck"] = PlayerLevel < 50, ["GaugeCheck"] = GaugeData1[1] >= 35 and GaugeData1[2] >= 35, ["ComboIDNOT"] = { [7504] = true },
		},
		{
			["Type"] = 1, ["Name"] = "Enchanted Riposte", ["ID"] = 7527, ["Range"] = 3, ["TargetCast"] = true, ["OtherCheck"] = PlayerLevel >= 50, ["GaugeCheck"] = GaugeData1[1] >= 50 and GaugeData1[2] >= 50, ["ComboIDNOT"] = { [7504] = true, [7512] = true, },
		},

		{
			["Type"] = 1, ["Name"] = "Enchanted Zwerchhau", ["ID"] = 7528, ["Range"] = 3, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[1] >= 15 and GaugeData1[2] >= 15,
			["ComboID"] = { [7504] = true },
		},
		{
			["Type"] = 1, ["Name"] = "Enchanted Redoublement", ["ID"] = 7529, ["Range"] = 3, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[1] >= 15 and GaugeData1[2] >= 15,
			["ComboID"] = { [7512] = true },
		},

		{
			["Type"] = 1, ["Name"] = "Enchanted Reprise", ["ID"] = 16528, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = PlayerMoving == true, ["GaugeCheck"] = GaugeData1[1] >= 55 and GaugeData1[2] >= 55, ["ComboIDNOT"] = { [7504] = true, [7512] = true, },
		},
		{
			["Type"] = 1, ["Name"] = "Enchanted Reprise", ["ID"] = 16528, ["Range"] = 25, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[1] >= 80 and GaugeData1[2] >= 80, ["ComboIDNOT"] = { [7504] = true, [7512] = true, },
		},
		{
			["Type"] = 1, ["Name"] = "Enchanted Reprise", ["ID"] = 16528, ["Range"] = 8, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[1] >= 70 and GaugeData1[2] >= 70, ["ComboIDNOT"] = { [7504] = true, [7512] = true, },
			["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Cone", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 8, ["MaxDistance"] = 8, ["Angle"] = 90, },
		},
		{
			["Type"] = 1, ["Name"] = "Enchanted Reprise", ["ID"] = 16528, ["Range"] = 8, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[1] >= 20 and GaugeData1[2] >= 20, ["ComboIDNOT"] = { [7504] = true, [7512] = true, },
			["AOECount"] = 5, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Cone", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 8, ["MaxDistance"] = 8, ["Angle"] = 90, },
		},

		-- Prio Procs
		{
			["Type"] = 1, ["Name"] = "Verholy", ["ID"] = 7526, ["Range"] = 25, ["TargetCast"] = true, ["GaugeCheck"] = (GaugeData1[1] - GaugeData1[2]) <= 0,
		},
		{
			["Type"] = 1, ["Name"] = "Verflare", ["ID"] = 7525, ["Range"] = 25, ["TargetCast"] = true, ["GaugeCheck"] = (GaugeData1[2] - GaugeData1[1]) <= 0,
		},
		{
			["Type"] = 1, ["Name"] = "Scorch", ["ID"] = 16530, ["Range"] = 25, ["TargetCast"] = true,
		},

		-- AOE Casts
		{
			["Type"] = 1, ["Name"] = "Impact", ["ID"] = 16526, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = HasDualcastBuff == true,
			["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 5, ["Angle"] = 90, },
		},
		{
			["Type"] = 1, ["Name"] = "Veraero II", ["ID"] = 16525, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = PlayerMoving == false or HasDualcastBuff == false,
			["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 5, ["Angle"] = 90, },
		},
		{
			["Type"] = 1, ["Name"] = "Verthunder II", ["ID"] = 16524, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = PlayerMoving == false or HasDualcastBuff == false,
			["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 5, ["Angle"] = 90, },
		},

		-- Single Casts
		{
			["Type"] = 1, ["Name"] = "Verstone", ["ID"] = 7511, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = PlayerMoving == false or HasDualcastBuff == true,
		},
		{
			["Type"] = 1, ["Name"] = "Verfire", ["ID"] = 7510, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = PlayerMoving == false or HasDualcastBuff == true,
		},
		{
			["Type"] = 1, ["Name"] = "Veraero", ["ID"] = 7507, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = HasDualcastBuff == true, ["GaugeCheck"] = (GaugeData1[1] - GaugeData1[2]) <= 0,
		},
		{
			["Type"] = 1, ["Name"] = "Verthunder", ["ID"] = 7505, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = HasDualcastBuff == true, ["GaugeCheck"] = (GaugeData1[2] - GaugeData1[1]) <= 0,
		},
		{
			["Type"] = 1, ["Name"] = "Veraero III", ["ID"] = 25856, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = HasDualcastBuff == true, ["GaugeCheck"] = (GaugeData1[1] - GaugeData1[2]) <= 0,
		},
		{
			["Type"] = 1, ["Name"] = "Verthunder III", ["ID"] = 25855, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = HasDualcastBuff == true, ["GaugeCheck"] = (GaugeData1[2] - GaugeData1[1]) <= 0,
		},

		{
			["Type"] = 1, ["Name"] = "Jolt", ["ID"] = 7503, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = PlayerMoving == false and HasDualcastBuff == false,
		},
		{
			["Type"] = 1, ["Name"] = "Jolt II", ["ID"] = 7524, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = PlayerMoving == false and HasDualcastBuff == false,
		},


		{
			["Type"] = 1, ["Name"] = "Embolden", ["ID"] = 7520, ["Range"] = 3, ["TargetCast"] = false, ["GaugeCheck"] = GaugeData1[1] >= 50 and GaugeData1[2] >= 50, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Contre Sixte", ["ID"] = 7519, ["Range"] = 25, ["TargetCast"] = true, ["OGCDLimited"] = OGCDTime > 0.6,
			["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 6, ["MaxDistance"] = 6, ["Angle"] = 90, },
		},
		{
			["Type"] = 1, ["Name"] = "Fleche", ["ID"] = 7517, ["Range"] = 25, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OGCDLimited"] = OGCDTime > 0.6,
		},
		{
			["Type"] = 1, ["Name"] = "Acceleration", ["ID"] = 7518, ["Range"] = 25, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OGCDLimited"] = OGCDTime > 0.6, ["OtherCheck"] = PlayerInCombat == true and HasDualcastBuff == false,
		},
		{
			["Type"] = 1, ["Name"] = "Magick Barrier", ["ID"] = 25857, ["Range"] = 25, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OGCDLimited"] = OGCDTime > 0.6, ["OtherCheck"] = PlayerInCombat == true and PlayerHP < 50,
		},
		{
			["Type"] = 1, ["Name"] = "Engaement", ["ID"] = 16527, ["Range"] = 25, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1 and self.GetSettingsValue(ClassTypeID,"JumpOut") == 2, ["OGCDLimited"] = OGCDTime > 0.6, ["ComboIDNOT"] = { [7504] = true, [7512] = true, },
		},
		{
			["Type"] = 1, ["Name"] = "Engaement", ["ID"] = 16527, ["Range"] = 25, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1 and self.GetSettingsValue(ClassTypeID,"JumpOut") == 1, ["OGCDLimited"] = OGCDTime > 0.6, ["Charges"] = 2, ["ComboIDNOT"] = { [7504] = true, [7512] = true, },
		},

		-- Shared CDS
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