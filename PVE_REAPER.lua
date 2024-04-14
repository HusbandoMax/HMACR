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
        ["Setting"] = "Harpe",
        ["Options"] = {
            { ["Name"] = "Harpe On", ["Tooltip"] = "Harpe On", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Harpe Insta", ["Tooltip"] = "Harpe Insta Proc Only", ["Colour"] = { ["r"] = 1, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Harpe Off", ["Tooltip"] = "Harpe Off", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
}

function Profile:SkillTable(Data,Target,ClassTypeID)
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

		d("NEW REAPER")
	self.SendConsoleMessage("REAPER PROFILE",1)
	local Gluttony = ActionList:Get(1,24393)
	local GluttonyHold = Gluttony.usable == true and (Gluttony.isoncd == false or Gluttony.cd > 50)
	--d("GluttonyHold: "..tostring(GluttonyHold))
    -- Type 1 = Target, 2 = Self (OOC), 3 = Party/Ally/NPC (Heals Ect)
	local SkillList = {
		{
			["Type"] = 1, ["Name"] = "Whorl of Death", ["ID"] = 24379, ["Range"] = 5, ["TargetCast"] = false, ["Buff"] = (self.EnemyWithBuff2(Player.pos,5,2586,15,"Missing",PlayerID) > 2),
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and self.AOETimeout == false and self.GetSettingsValue(ClassTypeID,"Debuffs") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Shadow of Death", ["ID"] = 24378, ["Range"] = 3, ["TargetCast"] = true, ["Buff"] = self.TargetBuff2(Target,2586,10,"Missing",PlayerID),
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Debuffs") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Harvest Moon", ["ID"] = 24388, ["Range"] = 25, ["TargetCast"] = true, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and self.AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = Target.pos, ["AOERange"] = 5, ["MaxDistance"] = 25, ["LineWidth"] = 0, ["Angle"] = 0, },
		},

		{
			["Type"] = 1, ["Name"] = "Communio", ["ID"] = 24398, ["Range"] = 25, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[3] > 0 and GaugeData1[4] < 2, ["OtherCheck"] = (PlayerMoving == false),
		},
		{
			["Type"] = 1, ["Name"] = "Plentiful Harvest", ["ID"] = 24385, ["Range"] = 15, ["TargetCast"] = true, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and self.AOETimeout == false,
			["Buff"] = self.TargetBuff2(Player,2592,0,"Has",PlayerID,PartySize) or (self.TargetBuff2(Player,2599,-1,"Missing",PlayerID) and self.TargetBuff2(Player,2592,0,"Has",PlayerID)),
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Line", ["TargetPoint"] = Player.pos, ["AOERange"] = 15, ["MaxDistance"] = 15, ["LineWidth"] = 4, ["Angle"] = 0, },
		},
		{
			["Type"] = 1, ["Name"] = "Plentiful Harvest", ["ID"] = 24385, ["Range"] = 15, ["TargetCast"] = true,
			["Buff"] = self.TargetBuff2(Player,2599,-1,"Missing",PlayerID) and self.TargetBuff2(Player,2592,4,"Missing",PlayerID),
		},

		{
			["Type"] = 1, ["Name"] = "Grim Reaping", ["ID"] = 24397, ["Range"] = 8, ["TargetCast"] = true, ["AOECount"] = 3, ["Level"] = PlayerLevel >= 80,
			["Positional"] = "None", ["Buff"] = self.TargetBuff2(Player,2593,0,"Has",PlayerID),
			["OtherCheck"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and self.AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Cone", ["TargetPoint"] = Player.pos, ["AOERange"] = 8, ["MaxDistance"] = 8, ["LineWidth"] = 0, ["Angle"] = 180, },
			["GaugeCheck"] = GaugeData1[3] > 0 and (PlayerLevel < 90 or GaugeData1[4] ~= 1),
		},
		{
			["Type"] = 1, ["Name"] = "Void Reaping", ["ID"] = 24395, ["Range"] = 3, ["TargetCast"] = true, ["AOECount"] = 0, ["Level"] = PlayerLevel >= 80,
			["Positional"] = "None", ["Buff"] = self.TargetBuff2(Player,2593,0,"Has",PlayerID) and self.TargetBuff2(Player,2591,-1,"Missing",PlayerID),
			["GaugeCheck"] = GaugeData1[3] > 0 and (PlayerLevel < 90 or GaugeData1[4] ~= 1),
		},
		{
			["Type"] = 1, ["Name"] = "Cross Reaping", ["ID"] = 24396, ["Range"] = 3, ["TargetCast"] = true,
			["Buff"] = self.TargetBuff2(Player,2593,0,"Has",PlayerID) and self.TargetBuff2(Player,2590,-1,"Missing",PlayerID),
			["GaugeCheck"] = GaugeData1[3] > 0 and (PlayerLevel < 90 or GaugeData1[4] ~= 1),
		},
		-- Base
		{
			["Type"] = 1, ["Name"] = "Guilotine", ["ID"] = 24384, ["Range"] = 8, ["TargetCast"] = true, ["AOECount"] = 3, ["Level"] = PlayerLevel >= 70,
			["Positional"] = "None", ["Buff"] = self.TargetBuff2(Player,2587,0,"Has",PlayerID), ["OtherCheck"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and self.AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Cone", ["TargetPoint"] = Player.pos, ["AOERange"] = 8, ["MaxDistance"] = 8, ["LineWidth"] = 0, ["Angle"] = 180, },
		},
		{
			["Type"] = 1, ["Name"] = "Gibbet", ["ID"] = 24382, ["Range"] = 3, ["TargetCast"] = true, ["AOECount"] = 0, ["Level"] = PlayerLevel >= 70,
			["Positional"] = "None", ["Buff"] = self.TargetBuff2(Player,2587,0,"Has",PlayerID) and self.TargetBuff2(Player,2589,0,"Missing",PlayerID), ["OtherCheck"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Gallows", ["ID"] = 24383, ["Range"] = 3, ["TargetCast"] = true, ["Buff"] = self.TargetBuff2(Player,2587,0,"Has",PlayerID) and self.TargetBuff2(Player,2588,0,"Missing",PlayerID), ["Level"] = PlayerLevel >= 70,
		},
		{
			["Type"] = 1, ["Name"] = "Soul Slice", ["ID"] = 24380, ["Range"] = 3, ["TargetCast"] = true, ["Level"] = PlayerLevel >= 60, ["GaugeCheck"] = (GaugeData2[1] < 51),
		},
		{
			["Type"] = 2, ["Name"] = "Spinning Scythe", ["ID"] = 24376, ["ComboID"] = { [0] = true, [24376] = PlayerLevel < 45, [24375] = true, [24377] = true }, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and self.AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = Player.pos, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Nightmare Scythe", ["ID"] = 24377, ["ComboID"] = { [24376] = true }, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["Level"] = PlayerLevel >= 45,
			["Positional"] = "None", ["PBuff"] = {  }, ["TBuff"] = {  }, ["OtherCheck"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and self.AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = Player.pos, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 1, ["Name"] = "Slice", ["ID"] = 24373, ["ComboID"] = { [0] = true, [24375] = true, [24376] = true, [24377] = true, }, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Waxing Slice", ["ID"] = 24374, ["ComboID"] = { [24373] = true }, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Infernal Slice", ["ID"] = 24375, ["ComboID"] = { [24374] = true }, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Harpe", ["ID"] = 24386, ["Range"] = 25, ["MinRange"] = 3, ["TargetCast"] = true, ["OtherCheck"] = (PlayerMoving == false), ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Harpe") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Harpe", ["ID"] = 24386, ["Range"] = 25, ["MinRange"] = 3, ["TargetCast"] = true, ["Level"] = PlayerLevel >= 15, ["Buff"] = self.TargetBuff2(Player,2845,0,"Has",PlayerID), ["OtherCheck"] = (PlayerMoving == true),
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Harpe") ~= 3,
		},
		-- OGCD
		{
			["Type"] = 1, ["Name"] = "Lemure's Scythe", ["ID"] = 24400, ["Range"] = 8, ["TargetCast"] = true, ["AOECount"] = 3, ["Level"] = PlayerLevel >= 86, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and self.AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Cone", ["TargetPoint"] = Player.pos, ["AOERange"] = 8, ["MaxDistance"] = 8, ["LineWidth"] = 0, ["Angle"] = 180, },
		},
		{
			["Type"] = 1, ["Name"] = "Lemure's Slice", ["ID"] = 24399, ["Range"] = 3, ["TargetCast"] = true,
		},

		{
			["Type"] = 1, ["Name"] = "Gluttony", ["ID"] = 24393, ["Range"] = 25, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Grim Swathe", ["ID"] = 24392, ["Range"] = 8, ["TargetCast"] = true, ["AOECount"] = 3, ["Level"] = PlayerLevel >= 55, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and self.AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Cone", ["TargetPoint"] = Player.pos, ["AOERange"] = 8, ["MaxDistance"] = 8, ["LineWidth"] = 0, ["Angle"] = 180, }, ["OtherCheck"] = GluttonyHold == false,
		},
		{
			["Type"] = 1, ["Name"] = "Blood Stalk", ["ID"] = 24389, ["Range"] = 3, ["TargetCast"] = true, ["OtherCheck"] = GluttonyHold == false,
		},
		{
			["Type"] = 1, ["Name"] = "Enshroud", ["ID"] = 24394, ["Range"] = 3, ["TargetCast"] = false, ["GaugeCheck"] = GaugeData1[2] >= 50,
		},

		{
			["Type"] = 1, ["Name"] = "Arcane Circle", ["ID"] = 24405, ["Range"] = 15, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerInCombat == true,
			["AOECount"] = (PartySize/2), ["AOEType"] = { ["Filter"] = "PartySelf", ["Name"] = "Circle", ["TargetPoint"] = Player.pos, ["AOERange"] = 15, ["MaxDistance"] = 15, },
		},
		{
			["Type"] = 1, ["Name"] = "Arcane Crest", ["ID"] = 24404, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerHP < 60 and PlayerInCombat == true,
		},
		{
			["Type"] = 1, ["Name"] = "Bloodbath", ["ID"] = 7542, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerHP < 60 and PlayerInCombat == true,
		},

		{
			["Type"] = 1, ["Name"] = "Soulsow", ["ID"] = 24387, ["Range"] = 0, ["TargetCast"] = false, ["Buff"] = self.TargetBuff2(Player,2594,-1,"Missing",PlayerID), ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = Player.incombat == false,
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

    return SkillList
end

return Profile