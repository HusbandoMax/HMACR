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
		["Setting"] = "Hallowed",
		["Options"] = {
			{ ["Name"] = "Hallowed", ["Tooltip"] = "Hallowed Ground On", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Hallowed", ["Tooltip"] = "Hallowed Ground Off", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
		},
	},
	{
		["Setting"] = "GaugeHold",
		["Options"] = {
			{ ["Name"] = "Gauge Hold", ["Tooltip"] = "Gauge Use All", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Gauge Hold", ["Tooltip"] = "Gauge Hold 50", ["Colour"] = { ["r"] = 1, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Gauge Hold", ["Tooltip"] = "Gauge Hold All", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
		},
	},
	{
		["Setting"] = "Heals",
		["Options"] = {
			{ ["Name"] = "Clem Off", ["Tooltip"] = "Off", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Clem Party", ["Tooltip"] = "Party", ["Colour"] = { ["r"] = 0.8, ["g"] = 0.8, ["b"] = 1, ["a"] = 1 }, },
			{ ["Name"] = "Clem Self", ["Tooltip"] = "Self", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
		},
	},
	{
		["Setting"] = "Jumps",
		["Options"] = {
			{ ["Name"] = "Jumps > 5", ["Tooltip"] = "Intervene > 5y", ["Colour"] = { ["r"] = 1, ["g"] = 0.6, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Jumps > 10", ["Tooltip"] = "Intervene > 10y", ["Colour"] = { ["r"] = 1, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Jumps > 15", ["Tooltip"] = "Intervene > 15y", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Jumps Off", ["Tooltip"] = "Intervene Off", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
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

	local SkillList = {
		{
			["Type"] = 3, ["Name"] = "Clemency", ["ID"] = 3541, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 50, ["PartyOnly"] = true,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Heals") ~= 1, ["OtherCheck"] = PlayerMoving == false,
		},
		
		{
			["Type"] = 2, ["Name"] = "Iron Will", ["ID"] = 28, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Tank") == 1, ["Buff"] = self.TargetBuff2(Player,79,-1,"Missing",PlayerID),
		},
		{
			["Type"] = 2, ["Name"] = "Iron Will", ["ID"] = 28, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Tank") == 2, ["Buff"] = self.TargetBuff2(Player,79,0,"Has",PlayerID),
		},
		{
			["Type"] = 2, ["Name"] = "Hallowed Ground", ["ID"] = 30, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Hallow") == 1, ["OtherCheck"] = PlayerHP < 15 and PlayerInCombat == true,
		},

		{
			["Type"] = 2, ["Name"] = "Holy Circle", ["ID"] = 16458, ["Range"] = 0, ["TargetCast"] = false, ["Buff"] = self.TargetBuff2(Player,2673,0,"Has",PlayerID,0), ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and self.AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = Player.pos, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Total Eclipse", ["ID"] = 7381, ["ComboIDNOT"] = { [7381] = PlayerLevel >= 40, }, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["OtherCheck"] = PlayerInCombat == true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and self.AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = Player.pos, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Prominence", ["ID"] = 16457, ["ComboID"] = { [7381] = true }, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["OtherCheck"] = PlayerInCombat == true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and self.AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = Player.pos, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},

		{
			["Type"] = 1, ["Name"] = "Shield Lob", ["ID"] = 24, ["Range"] = 20, ["TargetCast"] = true, ["OtherCheck"] = TargetDistance > 3,
		},
		{
			["Type"] = 1, ["Name"] = "Intervene", ["ID"] = 16461, ["Range"] = 20, ["TargetCast"] = true, ["SettingValue"] = self.JumpTimeout == false and self.GetSettingsValue(ClassTypeID,"Jumps") ~= 4,
			["OtherCheck"] = (self.GetSettingsValue(ClassTypeID,"Jumps") == 1 and TargetDistance > 5) or (self.GetSettingsValue(ClassTypeID,"Jumps") == 2 and TargetDistance > 10) or (self.GetSettingsValue(ClassTypeID,"Jumps") == 3 and TargetDistance > 15),
		},
		{
			["Type"] = 1, ["Name"] = "Blade of Truth", ["ID"] = 25749, ["Range"] = 25, ["TargetCast"] = true, ["Buff"] = self.TargetBuff2(Player,1368,0,"Has",PlayerID,1),
		},
		{
			["Type"] = 1, ["Name"] = "Blade of Valor", ["ID"] = 25750, ["Range"] = 25, ["TargetCast"] = true, ["Buff"] = self.TargetBuff2(Player,1368,0,"Has",PlayerID,1),
		},
		{
			["Type"] = 1, ["Name"] = "Confiteor", ["ID"] = 16459, ["Range"] = 25, ["TargetCast"] = true, ["Buff"] = self.TargetBuff2(Player,1368,0,"Has",PlayerID,1),
		},
		{
			["Type"] = 1, ["Name"] = "Goring Blade", ["ID"] = 3538, ["Range"] = 3, ["TargetCast"] = true,
		},		
		{
			["Type"] = 1, ["Name"] = "Holy Spirit", ["ID"] = 7384, ["Range"] = 25, ["TargetCast"] = true, ["Buff"] = self.TargetBuff2(Player,2673,0,"Has",PlayerID,0),
		},
		{
			["Type"] = 1, ["Name"] = "Blade of Faith", ["ID"] = 25748, ["Range"] = 25, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Atonement", ["ID"] = 16460, ["Range"] = 3, ["TargetCast"] = true, ["Buff"] = self.TargetBuff2(Player,1902,0,"Has",PlayerID),
		},

		{
			["Type"] = 1, ["Name"] = "Fast Blade", ["ID"] = 9, ["ComboIDNOT"] = { [9] = PlayerLevel >= 4, [15] = PlayerLevel >= 26, }, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Riot Blade", ["ID"] = 15, ["ComboID"] = { [9] = true }, ["Range"] = 3, ["TargetCast"] = true,
		},

		{
			["Type"] = 1, ["Name"] = "Royal Authority", ["ID"] = 3539, ["ComboID"] = { [15] = true }, ["Range"] = 3, ["TargetCast"] = true, ["LastActionTimeout"] = "PLDReq", ["LastActionTime"] = 2000,
		},
		{
			["Type"] = 1, ["Name"] = "Rage of Halone", ["ID"] = 21, ["ComboID"] = { [15] = true }, ["Range"] = 3, ["TargetCast"] = true, ["LastActionTimeout"] = "PLDReq", ["LastActionTime"] = 2000,
		},

		-- OGCD
		{
			["Type"] = 1, ["Name"] = "Spirits Within", ["ID"] = 29, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Expiacion", ["ID"] = 25747, ["Range"] = 3, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Circle of Scorn", ["ID"] = 23, ["Range"] = 0, ["TargetCast"] = false, ["OtherCheck"] = TargetDistance < 5 and PlayerInCombat == true,
		},
		{
			["Type"] = 1, ["Name"] = "Requiescat", ["ID"] = 7383, ["Range"] = 3, ["TargetCast"] = true, ["Buff"] = self.TargetBuff2(Player,76,0,"Missing",PlayerID) and self.TargetBuff2(Player,1902,0,"Missing",PlayerID), ["LastActionTimeout"] = "PLDReq", ["LastActionTime"] = 2000,
		},
		{
			["Type"] = 1, ["Name"] = "Fight or Flight", ["ID"] = 20, ["Range"] = 0, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true, ["LastActionTimeout"] = "PLDReq", ["LastActionTime"] = 2000, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
		},		
		{
			["Type"] = 1, ["Name"] = "Sentinel", ["ID"] = 17, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerHP < 50 and PlayerInCombat == true,
		},
		{
			["Type"] = 1, ["Name"] = "Sheltron", ["ID"] = 3542, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1 and (self.GetSettingsValue(ClassTypeID,"GaugeHold") == 1 or (self.GetSettingsValue(ClassTypeID,"GaugeHold") == 2 and GaugeData2[1] == 100)), ["OtherCheck"] = PlayerInCombat == true,
		},
		{
			["Type"] = 1, ["Name"] = "Holy Sheltron", ["ID"] = 25746, ["Range"] = 0, ["TargetCast"] = false, ["Buff"] = self.TargetBuff2(Player,2676,0,"Missing",PlayerID), ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1 and (self.GetSettingsValue(ClassTypeID,"GaugeHold") == 1 or (self.GetSettingsValue(ClassTypeID,"GaugeHold") == 2 and GaugeData2[1] == 100)), ["OtherCheck"] = PlayerInCombat == true,
		},
		{
			["Type"] = 1, ["Name"] = "Bulwark", ["ID"] = 22, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerHP < 80 and PlayerInCombat == true,
		},
		{
			["Type"] = 1, ["Name"] = "Divine Veil", ["ID"] = 3540, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerHP < 60 and PlayerInCombat == true,
		},
		-- Need to look at Divine Veil al lower level to see if a change needs to be done for that.

		-- Shared CDS
		{
			["Type"] = 1, ["Name"] = "Provoke", ["ID"] = 7533, ["Range"] = 25, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"ProvokePull") == 2, 
			["OtherCheck"] = Player.incombat == false and table.valid(Target) == true and Target.incombat == false,
		},
		{
			["Type"] = 1, ["Name"] = "Interject", ["ID"] = 7538, ["Range"] = 3, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Interrupts") == 1, 
			["OtherCheck"] = PlayerInCombat == true and table.valid(Target) == true and Target.castinginfo.channelingid ~= 0 and Target.castinginfo.castinginterruptible == true,
		},
		{
			["Type"] = 1, ["Name"] = "Reprisal", ["ID"] = 7535, ["Range"] = 5, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Rampart", ["ID"] = 7531, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerHP < 70 and PlayerInCombat == true,
		},
	}

	--d(SkillList)

    return SkillList
end

return Profile