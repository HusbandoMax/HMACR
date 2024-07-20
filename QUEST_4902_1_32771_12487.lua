local Profile = {}

Profile.Settings = {
    {
        ["Setting"] = "Jumps",
        ["Options"] = {
            { ["Name"] = "Jumps Off", ["Tooltip"] = "Jump Off", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Jumps > 5", ["Tooltip"] = "Jump > 5y", ["Colour"] = { ["r"] = 1, ["g"] = 0.6, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Jumps > 10", ["Tooltip"] = "Jump > 10y", ["Colour"] = { ["r"] = 1, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Jumps > 15", ["Tooltip"] = "Jump > 15y", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
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


	local SkillList = {
		--AOE STuff
		{
			["Type"] = 2, ["Name"] = "Turali Fervor", ["ID"] = 37128, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["SettingValue"] = AOETimeout == false, ["Proc"] = true,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Turali of Tural", ["ID"] = 37127, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["SettingValue"] = AOETimeout == false, ["Proc"] = true,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Turali Judgment", ["ID"] = 37126, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["SettingValue"] = AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},

		--Single Target
		{
			["Type"] = 1, ["Name"] = "Tail of the Br'aax", ["ID"] = 37122, ["Range"] = 3, ["TargetCast"] = true, ["Proc"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Fangs of the Br'aax", ["ID"] = 37121, ["Range"] = 3, ["TargetCast"] = true, ["Proc"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Claw of the Br'aax", ["ID"] = 37120, ["Range"] = 3, ["TargetCast"] = true,
		},


		{
			["Type"] = 1, ["Name"] = "Dawnlit Conviction", ["ID"] = 37129, ["Range"] = 10, ["TargetCast"] = true, 
		},
		{
			["Type"] = 1, ["Name"] = "Run of the Rroneek", ["ID"] = 37123, ["Range"] = 20, ["TargetCast"] = true, ["SettingValue"] = JumpTimeout == false and self.GetSettingsValue(ClassTypeID,"Jumps") ~= 1,
			["OtherCheck"] = (self.GetSettingsValue(ClassTypeID,"Jumps") == 2 and TargetDistance > 5) or (self.GetSettingsValue(ClassTypeID,"Jumps") == 3 and TargetDistance > 10) or (self.GetSettingsValue(ClassTypeID,"Jumps") == 4 and TargetDistance > 15),
		},
		{
			["Type"] = 1, ["Name"] = "Beak of the Luwatena", ["ID"] = 37125, ["Range"] = 20, ["TargetCast"] = true, ["OtherCheck"] = TargetDistance > 3,
		},

		{
			["Type"] = 2, ["Name"] = "Luwatena Pulse", ["ID"] = 37124, ["Range"] = 20, ["TargetCast"] = false, ["OtherCheck"] = PlayerHP < 50,
		},
		
	}

	self.SendConsoleMessage(ClassTypeID.."PROFILE END",1)
    return SkillList
end

return Profile