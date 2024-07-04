local Profile = {}

Profile.Settings = {
    {
        ["Setting"] = "Tank",
        ["Options"] = {
            { ["Name"] = "MT", ["Tooltip"] = "MT", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "OT", ["Tooltip"] = "OT", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "AOE",
        ["Options"] = {
            { ["Name"] = "AOE", ["Tooltip"] = "AOE ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "AOE", ["Tooltip"] = "AOE OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
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
        ["Setting"] = "Holmgang",
        ["Options"] = {
            { ["Name"] = "Holmgang", ["Tooltip"] = "Holmgang On", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Holmgang", ["Tooltip"] = "Holmgang Off", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "Jumps",
        ["Options"] = {
            { ["Name"] = "Jumps > 5", ["Tooltip"] = "Onslaught > 5y", ["Colour"] = { ["r"] = 1, ["g"] = 0.6, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Jumps > 10", ["Tooltip"] = "Onslaught > 10y", ["Colour"] = { ["r"] = 1, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Jumps > 15", ["Tooltip"] = "Onslaught > 15y", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Jumps Off", ["Tooltip"] = "Onslaught Off", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "Interrupts",
        ["Options"] = {
            { ["Name"] = "Interrupts", ["Tooltip"] = "Interrupts On", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Interrupts", ["Tooltip"] = "Interrupts Off", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "ProvokePull",
        ["Options"] = {
            { ["Name"] = "Voke Pull", ["Tooltip"] = "Off", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Voke Pull", ["Tooltip"] = "ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
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
    local TargetInCombat = Data.TargetInCombat
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
		31      Heavy Swing             MRD WAR
		37      Maim                    MRD WAR
		38      Berserk                 MRD WAR
		40      Thrill of Battle        MRD WAR
		41      Overpower               MRD WAR
		42      Storm's Path            MRD WAR
		43      Holmgang                MRD WAR
		44      Vengeance               MRD WAR
		45      Storm's Eye             MRD WAR
		46      Tomahawk                MRD WAR
		48      Defiance                MRD WAR
		49      Inner Beast             WAR
		51      Steel Cyclone           WAR
		52      Infuriate               WAR
		3549    Fell Cleave             WAR
		3550    Decimate                WAR
		3551    Raw Intuition           WAR
		3552    Equilibrium             WAR
		7386    Onslaught               WAR
		7387    Upheaval                WAR
		7388    Shake It Off            WAR
		7389    Inner Release           WAR
		16462   Mythril Tempest         WAR
		16463   Chaotic Cyclone         WAR
		16464   Nascent Flash           WAR
		16465   Inner Chaos             WAR
		25751   Bloodwhetting           WAR
		25752   Orogeny                 WAR
		25753   Primal Rend             WAR
		32066   Release Defiance        MRD WAR
		36923   Damnation               WAR
		36924   Primal Wrath            WAR
		36925   Primal Ruination        WAR
	]]

	local SkillList = {
		{
			["Type"] = 2, ["Name"] = "Defiance", ["ID"] = 48, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Tank") == 1, ["Buff"] = self.TargetBuff2(Player,91,-1,"Missing",PlayerID),
		},
		{
			["Type"] = 2, ["Name"] = "Defiance", ["ID"] = 48, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Tank") == 2, ["Buff"] = self.TargetBuff2(Player,91,0,"Has",PlayerID),
		},
		{
			["Type"] = 2, ["Name"] = "Holmgang", ["ID"] = 43, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Holmgang") == 1, ["OtherCheck"] = PlayerHP < 15 and PlayerInCombat == true,
		},
		{
			["Type"] = 1, ["Name"] = "Primal Ruination", ["ID"] = 36925, ["Range"] = 3, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
		},
		{
			["Type"] = 2, ["Name"] = "Primal Wrath", ["ID"] = 36924, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 1, 
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Chaotic Cyclone", ["ID"] = 16463, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["OtherCheck"] = PlayerInCombat == true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Steel Cyclone", ["ID"] = 51, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["OtherCheck"] = PlayerInCombat == true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Decimate", ["ID"] = 3550, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["OtherCheck"] = PlayerInCombat == true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 1, ["Name"] = "Inner Chaos", ["ID"] = 16465, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Inner Beast", ["ID"] = 49, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Fell Cleave", ["ID"] = 29078, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Fell Cleave", ["ID"] = 3549, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Primal Rend", ["ID"] = 25753, ["Range"] = 20, ["TargetCast"] = true, ["SettingValue"] = JumpTimeout == false and self.GetSettingsValue(ClassTypeID,"Jumps") ~= 4 and self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
		},

		--AOE STuff
		{
			["Type"] = 2, ["Name"] = "Overpower", ["ID"] = 41, ["ComboIDNOT"] = { [41] = PlayerLevel >= 40, }, ["Range"] = 8, ["TargetCast"] = true, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Mythril Tempest", ["ID"] = 16462, ["ComboID"] = { [41] = true, }, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},

		--Single Target
		{
			["Type"] = 1, ["Name"] = "Heavy Swing", ["ID"] = 31, ["ComboIDNOT"] = { [31] = PlayerLevel >= 4, [37] = PlayerLevel >= 26, }, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Maim", ["ID"] = 37, ["ComboID"] = { [31] = true }, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Storm's Eye", ["ID"] = 45, ["ComboID"] = { [37] = true }, ["Range"] = 3, ["TargetCast"] = true, ["Buff"] = self.TargetBuff2(Player,2677,30,"Missing",PlayerID),
		},
		{
			["Type"] = 1, ["Name"] = "Storm's Path", ["ID"] = 42, ["ComboID"] = { [37] = true }, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Onslaught", ["ID"] = 7386, ["Range"] = 20, ["TargetCast"] = true, ["SettingValue"] = JumpTimeout == false and self.GetSettingsValue(ClassTypeID,"Jumps") ~= 4,
			["OtherCheck"] = (self.GetSettingsValue(ClassTypeID,"Jumps") == 1 and TargetDistance > 5) or (self.GetSettingsValue(ClassTypeID,"Jumps") == 2 and TargetDistance > 10) or (self.GetSettingsValue(ClassTypeID,"Jumps") == 3 and TargetDistance > 15),
		},
		{
			["Type"] = 1, ["Name"] = "Tomahawk", ["ID"] = 46, ["Range"] = 20, ["TargetCast"] = true, ["OtherCheck"] = TargetDistance > 3,
		},
		
		-- OGCD
		{
			["Type"] = 1, ["Name"] = "Orogeny", ["ID"] = 25752, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["OtherCheck"] = PlayerInCombat == true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 1, ["Name"] = "Upheavel", ["ID"] = 7387, ["Range"] = 3, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Berserk", ["ID"] = 38, ["Range"] = 3, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerInCombat == true,
		},
		{
			["Type"] = 1, ["Name"] = "Inner Release", ["ID"] = 7389, ["Range"] = 3, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerInCombat == true,
		},
		{
			["Type"] = 1, ["Name"] = "Infuriate", ["ID"] = 52, ["Range"] = 3, ["Buff"] = self.TargetBuff2(Player,1897,0,"Missing",PlayerID) and self.TargetBuff2(Player,1177,0,"Missing",PlayerID), ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerInCombat == true, ["GaugeCheck"] = GaugeData1[1] <= 49,
		},
		{
			["Type"] = 1, ["Name"] = "Thrill of Battle", ["ID"] = 40, ["Range"] = 3, ["TargetCast"] = false, ["OtherCheck"] = PlayerHP <=50, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Equilibrium", ["ID"] = 3552, ["Range"] = 3, ["TargetCast"] = false, ["OtherCheck"] = PlayerHP <=30, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Vengeance", ["ID"] = 44, ["Range"] = 3, ["TargetCast"] = false, ["OtherCheck"] = PlayerHP <=80, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Damnation", ["ID"] = 36923, ["Range"] = 3, ["TargetCast"] = false, ["OtherCheck"] = PlayerHP <=80, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Bloodwhetting", ["ID"] = 25751, ["Range"] = 3, ["TargetCast"] = false, ["OtherCheck"] = PlayerHP <=50, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
		},
		--{--Nascent Flash is a target of party member, not sure how to do this.
		--["Name"] = "Nascent Flash", ["ID"] = 16464, ["Range"] = 3, ["TargetCast"] = false, ["OtherCheck"] = PlayerHP <=50, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
		--},

		-- Shared CDS
		{
			["Type"] = 1, ["Name"] = "Provoke", ["ID"] = 7533, ["Range"] = 25, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"ProvokePull") == 2, 
			["OtherCheck"] = PlayerInCombat == false and table.valid(Target) == true and PlayerInCombat == false,
		},
		{
			["Type"] = 1, ["Name"] = "Interject", ["ID"] = 7538, ["Range"] = 3, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Interrupts") == 1, 
			["OtherCheck"] = PlayerInCombat == true and TargetCastingInterruptible == true,
		},
		{
			["Type"] = 2, ["Name"] = "Reprisal", ["ID"] = 7535, ["Range"] = 0, ["TargetCast"] = false,
			["OtherCheck"] = PlayerHP <= 80 and PlayerInCombat == true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and self.GetSettingsValue(ClassTypeID,"CDs") == 1 and AOETimeout == false,
			["AOECount"] = 3,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 1, ["Name"] = "Rampart", ["ID"] = 7531, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerHP < 75 and PlayerInCombat == true,
		},
	}

	self.SendConsoleMessage(ClassTypeID.."PROFILE END",1)
    return SkillList
end

return Profile