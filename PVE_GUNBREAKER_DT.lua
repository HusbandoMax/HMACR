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
        ["Setting"] = "Superbolide",
        ["Options"] = {
            { ["Name"] = "Superbolide", ["Tooltip"] = "Superbolide On", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Superbolide", ["Tooltip"] = "Superbolide Off", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "Jumps",
        ["Options"] = {
            { ["Name"] = "Jumps > 5", ["Tooltip"] = "Trajectory > 5y", ["Colour"] = { ["r"] = 1, ["g"] = 0.6, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Jumps > 10", ["Tooltip"] = "Trajectory > 10y", ["Colour"] = { ["r"] = 1, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Jumps > 15", ["Tooltip"] = "Trajectory > 15y", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Jumps Off", ["Tooltip"] = "Trajectory Off", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "DDBurn",
        ["Options"] = {
            { ["Name"] = "DD AOE", ["Tooltip"] = "Double Down/Bow Shock AOE Save", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "DD Burn", ["Tooltip"] = "Double Down/Bow Shock Burn", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "Interrupts",
        ["Options"] = {
            { ["Name"] = "Interrupts", ["Tooltip"] = "Interrupts On", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Interrupts", ["Tooltip"] = "Interrupts Off", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
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
		16137	Keen Edge
		16138	No Mercy
		16139	Brutal Shell
		16140	Camouflage
		16141	Demon Slice
		16142	Royal Guard
		16143	Lightning Shot
		16144	Danger Zone
		16145	Solid Barrel
		16146	Gnashing Fang
		16147	Savage Claw
		16148	Nebula
		16149	Demon Slaughter
		16150	Wicked Talon
		16151	Aurora
		16152	Superbolide
		16153	Sonic Break
		16155	Continuation
		16156	Jugular Rip
		16157	Abdomen Tear
		16158	Eye Gouge
		16159	Bow Shock
		16160	Heart of Light
		16161	Heart of Stone
		16162	Burst Strike
		16163	Fated Circle
		16164	Bloodfest
		16165	Blasting Zone
		25758	Heart of Corundum
		25759	Hypervelocity
		25760	Double Down
		32068	Release Royal Guard
		36934	Trajectory
		36935	Great Nebula
		36936	Fated Brand
		36937	Reign of Beasts
		36938	Noble Blood
		36939	Lion Heart
	]]--
	local Bloodfest = ActionList:Get(1,16164)
	local NoMercy = ActionList:Get(1,16138)
	local GnashingFang = ActionList:Get(1,16146)

	local MaxCartridges = PlayerLevel >= 88 and 3 or 2

	local SkillList = {
		{
			["Type"] = 2, ["Name"] = "Royal Guard", ["ID"] = 16142, ["Range"] = 10, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Tank") == 1, ["Buff"] = self.TargetBuff2(Player,1833,-1,"Missing",PlayerID),
		},
		{
			["Type"] = 2, ["Name"] = "Royal Guard", ["ID"] = 16142, ["Range"] = 10, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Tank") == 2, ["Buff"] = self.TargetBuff2(Player,1833,0,"Has",PlayerID),
		},
		{
			["Type"] = 2, ["Name"] = "Superbolide", ["ID"] = 16152, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Superbolide") == 1, ["OtherCheck"] = PlayerHP < 15 and PlayerInCombat == true,
		},

		{
			["Type"] = 1, ["Name"] = "Lighting Shot", ["ID"] = 16143, ["Range"] = 20, ["TargetCast"] = true, ["OtherCheck"] = TargetDistance > 3,
		},
		{
			["Type"] = 1, ["Name"] = "Trajectory", ["ID"] = 36934, ["Range"] = 20, ["TargetCast"] = true,  ["SettingValue"] = JumpTimeout == false and self.GetSettingsValue(ClassTypeID,"Jumps") ~= 4,
			["OtherCheck"] = (self.GetSettingsValue(ClassTypeID,"Jumps") == 1 and TargetDistance > 5) or (self.GetSettingsValue(ClassTypeID,"Jumps") == 2 and TargetDistance > 10) or (self.GetSettingsValue(ClassTypeID,"Jumps") == 3 and TargetDistance > 15),
		},

		{
			["Type"] = 2, ["Name"] = "Double Down", ["ID"] = 25760, ["Range"] = 0, ["TargetCast"] = false, ["GaugeCheck"] = GaugeData1[1] >= 2, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DDBurn") == 1,
            ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Bow Shock", ["ID"] = 16159, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DDBurn") == 1,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},

		{
			["Type"] = 2, ["Name"] = "Double Down Burn", ["ID"] = 25760, ["Range"] = 0, ["TargetCast"] = false, ["GaugeCheck"] = GaugeData1[1] >= 2, ["AOECount"] = 1, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DDBurn") == 2 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
			["Buff"] = self.TargetBuff2(Player,1831,0,"Has",PlayerID),
		},
		{
			["Type"] = 2, ["Name"] = "Bow Shock Burn", ["ID"] = 16159, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 1, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DDBurn") == 2 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
			["Buff"] = self.TargetBuff2(Player,1831,0,"Has",PlayerID),
		},
		{
			["Type"] = 1, ["Name"] = "Sonic Break", ["ID"] = 16153, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 2, ["Name"] = "Fated Circle", ["ID"] = 16163, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, }, ["GaugeCheck"] = GaugeData1[1] >= 2,
		},
		--[[ Finish Lion Heart combo if already started --]]
		{
			["Type"] = 1, ["Name"] = "Noble Blood", ["ID"] = 36938, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Lion Heart", ["ID"] = 36939, ["Range"] = 3, ["TargetCast"] = true,
		},
		--[[ Prefer starting GF to starting Lion Heart -- ]]
		{
			["Type"] = 1, ["Name"] = "Gnashing Fang", ["ID"] = 16146, ["Range"] = 3, ["TargetCast"] = true, ["OtherCheck"] = NoMercy.isoncd and NoMercy.cd < 40, 
		},
		{
			["Type"] = 1, ["Name"] = "Burst Strike", ["ID"] = 16162, ["Range"] = 3, ["TargetCast"] = true, ["GaugeCheck"] = (GaugeData1[1] >= MaxCartridges and Bloodfest.cd > 20) or not Bloodfest.isoncd or Bloodfest.cd > 100,
		},
		{
			["Type"] = 1, ["Name"] = "Jugular Rip", ["ID"] = 16156, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Savage Claw", ["ID"] = 16147, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Abdomen Tear", ["ID"] = 16157, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Wicked talon", ["ID"] = 16150, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Eye Gouge", ["ID"] = 16158, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Hypervelocity", ["ID"] = 25759, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Reign of Beasts", ["ID"] = 36937, ["Range"] = 3, ["TargetCast"] = true, ["OtherCheck"] = GnashingFang.isoncd
		},

        -- AOE
		{
			["Type"] = 2, ["Name"] = "Demon Slice", ["ID"] = 16141, ["ComboIDNOT"] = { [16141] = PlayerLevel >= 40, }, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Demon Slaughter", ["ID"] = 16149, ["ComboID"] = { [16141] = true, }, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},

        -- Single Target
		{
			["Type"] = 1, ["Name"] = "Keen Edge", ["ID"] = 16137, ["ComboIDNOT"] = { [16137] = PlayerLevel >= 4, [16139] = PlayerLevel >= 2, }, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Brutal Shell", ["ID"] = 16139, ["ComboID"] = { [16137] = true }, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Solid Barrel", ["ID"] = 16145, ["ComboID"] = { [16139] = true }, ["Range"] = 3, ["TargetCast"] = true,
		},
		-- OGCD
		{
			["Type"] = 1, ["Name"] = "Bloodfest", ["ID"] = 16164, ["Range"] = 25, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["GaugeCheck"] = GaugeData1[1] < 1,
		},
		{
			["Type"] = 1, ["Name"] = "Danger Zone", ["ID"] = 16144, ["Range"] = 3, ["TargetCast"] = true,
			["OtherCheck"] = NoMercy.isoncd and NoMercy.cd < 40,
		},
		{
			["Type"] = 1, ["Name"] = "Blasting Zone", ["ID"] = 16165, ["Range"] = 3, ["TargetCast"] = true,
			["OtherCheck"] = NoMercy.isoncd and NoMercy.cd < 40,
		},
		{
			["Type"] = 1, ["Name"] = "No Mercy", ["ID"] = 16138, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerInCombat == true,
		},
		{
			["Type"] = 1, ["Name"] = "Camouflage", ["ID"] = 16140, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerHP < 80 and PlayerInCombat == true,
		},
		{
			["Type"] = 1, ["Name"] = "Heart of Light", ["ID"] = 16160, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerHP < 75 and PlayerInCombat == true,
		},
		{
			["Type"] = 1, ["Name"] = "Nebula", ["ID"] = 16148, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerHP < 50 and PlayerInCombat == true,
		},
		{
			["Type"] = 1, ["Name"] = "Aurora", ["ID"] = 16151, ["Range"] = 0, ["TargetCast"] = false, ["Buff"] = self.TargetBuff2(Player,1835,0,"Missing",PlayerID), ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerHP < 65 and PlayerInCombat == true,
		},
		{
			["Type"] = 1, ["Name"] = "Heart of Stone", ["ID"] = 16161, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerHP < 70 and PlayerInCombat == true,
		},
		{
			["Type"] = 1, ["Name"] = "Heart of Corundum", ["ID"] = 25758, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerHP < 35 and PlayerInCombat == true,
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