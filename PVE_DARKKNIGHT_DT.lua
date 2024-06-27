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
        ["Setting"] = "LivingDead",
        ["Options"] = {
            { ["Name"] = "Living Dead", ["Tooltip"] = "Living Dead On", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Living Dead", ["Tooltip"] = "Living Dead Off", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "Jumps",
        ["Options"] = {
            { ["Name"] = "Jumps > 5", ["Tooltip"] = "Plunge > 5y", ["Colour"] = { ["r"] = 1, ["g"] = 0.6, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Jumps > 10", ["Tooltip"] = "Plunge > 10y", ["Colour"] = { ["r"] = 1, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Jumps > 15", ["Tooltip"] = "Plunge > 15y", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Jumps Off", ["Tooltip"] = "Plunge Off", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
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
    local TargetHP = Data.TargetHP
    local TargetInCombat = Data.TargetInCombat
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
		3617	Hard Slash
		3621	Unleash
		3623	Syphon Strike
		3624	Unmend
		3625	Blood Weapon
		3629	Grit
		3632	Souleater
		3634	Dark Mind
		3636	Shadow Wall
		3638	Living Dead
		3639	Salted Earth
		3641	Abyssal Drain
		3643	Carve and Spit
		7390	Delirium
		7391	Quietus
		7392	Bloodspiller
		7393	The Blackest Night
		16466	Flood of Darkness
		16467	Edge of Darkness
		16468	Stalwart Soul
		16469	Flood of Shadow
		16470	Edge of Shadow
		16471	Dark Missionary
		16472	Living Shadow
		25754	Oblation
		25755	Salt and Darkness
		25756	Salt and Darkness
		25757	Shadowbringer
		32067	Release Grit
		36926	Shadowstride
		36927	Shadowed Vigil
		36928	Scarlet Delirium
		36929	Comeuppance
		36930	Torcleaver
		36931	Impalement
		36932	Disesteem
	]]--

	local SkillList = {
		{
			["Type"] = 2, ["Name"] = "Grit", ["ID"] = 3629, ["Range"] = 10, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Tank") == 1, ["Buff"] = self.TargetBuff2(Player,743,-1,"Missing",PlayerID),
		},
		{
			["Type"] = 2, ["Name"] = "Grit", ["ID"] = 3629, ["Range"] = 10, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Tank") == 2, ["Buff"] = self.TargetBuff2(Player,743,0,"Has",PlayerID),
		},
		{
			["Type"] = 2, ["Name"] = "Living Dead", ["ID"] = 3629, ["Range"] = 10, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"LIVINGDEAD") == 1, ["OtherCheck"] = PlayerHP < 10 and PlayerInCombat == true,
		},


		{
			["Type"] = 1, ["Name"] = "Shadowbringer", ["ID"] = 25757, ["Range"] = 10, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Carve and Spit", ["ID"] = 3643, ["Range"] = 3, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Flood of Shadow", ["ID"] = 16469, ["Range"] = 0, ["TargetCast"] = true, ["AOECount"] = 3, ["OtherCheck"] = PlayerInCombat == true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Line", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 3, ["Angle"] = 0, }, ["GaugeCheck"] = GaugeData1[2] <= 29999,
		},
		{
			["Type"] = 1, ["Name"] = "Edge of Shadow", ["ID"] = 16470, ["Range"] = 3, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[2] <= 29999,
		},
		{
			["Type"] = 1, ["Name"] = "Bloodspiller", ["ID"] = 7392, ["Range"] = 3, ["TargetCast"] = true,
		},

		--AOE STuff
		{
			["Type"] = 2, ["Name"] = "Quietus", ["ID"] = 7391, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Unleash", ["ID"] = 3621, ["ComboIDNOT"] = { [3621] = PlayerLevel >= 72, }, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Stalwart", ["ID"] = 16468, ["ComboID"] = { [3621] = true, }, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},

		--Single Target
		{
			["Type"] = 1, ["Name"] = "Hard Slash", ["ID"] = 3617, ["ComboIDNOT"] = { [3617] = PlayerLevel >= 2, [3623] = PlayerLevel >= 26, }, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Syphon Strike", ["ID"] = 3623, ["ComboID"] = { [3617] = true }, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Soul Eater", ["ID"] = 3632, ["ComboID"] = { [3623] = true }, ["Range"] = 3, ["TargetCast"] = true,
		},

		{
			["Type"] = 1, ["Name"] = "Unmend", ["ID"] = 3624, ["Range"] = 20, ["TargetCast"] = true, ["OtherCheck"] = TargetDistance > 3,
		},
		{
			["Type"] = 1, ["Name"] = "Plunge", ["ID"] = 3640, ["Range"] = 20, ["TargetCast"] = true, ["SettingValue"] = JumpTimeout == false and self.GetSettingsValue(ClassTypeID,"Jumps") ~= 4,
			["OtherCheck"] = (self.GetSettingsValue(ClassTypeID,"Jumps") == 1 and TargetDistance > 5) or (self.GetSettingsValue(ClassTypeID,"Jumps") == 2 and TargetDistance > 10) or (self.GetSettingsValue(ClassTypeID,"Jumps") == 3 and TargetDistance > 15),
		},
		-- OGCD
		{
			["Type"] = 1, ["Name"] = "Abyssal Drain", ["ID"] = 3641, ["Range"] = 20, ["TargetCast"] = true, ["AOECount"] = 3, ["OtherCheck"] = PlayerInCombat == true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 1, ["Name"] = "Living Shadow", ["ID"] =16472, ["Range"] = 10, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Salt and Darkness", ["ID"] = 25755, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Salted Earth", ["ID"] = 3639, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 1, ["OtherCheck"] = PlayerInCombat == true and PlayerMoving == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = Player .pos, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 1, ["Name"] = "Blood Weapon", ["ID"] = 3625, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["GaugeCheck"] = GaugeData1[1] <= 90,
		},
		{
			["Type"] = 1, ["Name"] = "Delirium", ["ID"] = 7390, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Oblation", ["ID"] = 25754, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,["OtherCheck"] = PlayerHP < 65 and PlayerInCombat == true,
		},
		{
			["Type"] = 1, ["Name"] = "Shadow Wall", ["ID"] = 3636, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,["OtherCheck"] = PlayerHP < 45 and PlayerInCombat == true,
		},
		{
			["Type"] = 1, ["Name"] = "Dark Mind", ["ID"] = 3634, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,["OtherCheck"] = PlayerHP < 25 and PlayerInCombat == true,
		},

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
			["Type"] = 1, ["Name"] = "Reprisal", ["ID"] = 7535, ["Range"] = 5, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Rampart", ["ID"] = 7531, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerHP < 75 and PlayerInCombat == true,
		},
	}

	self.SendConsoleMessage(ClassTypeID.."PROFILE END",1)
    return SkillList
end

return Profile