local Profile = {}

Profile.Settings = {
    --{
    --    ["Setting"] = "AOE",
    --    ["Options"] = {
    --        { ["Name"] = "AOE", ["Tooltip"] = "AOE ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
    --        { ["Name"] = "AOE", ["Tooltip"] = "AOE OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
    --    },
    --},
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
			["Type"] = 1, ["Name"] = "Water II In Blue", ["ID"] = 46761, ["Range"] = 25, ["TargetCast"] = true, ["AOECount"] = 2, ["SettingValue"] = AOETimeout == false, ["Proc"] = true,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, ["LineWidth"] = 0, ["Angle"] = 0, },
			--["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
		},
		{
			["Type"] = 1, ["Name"] = "Aero II In Green", ["ID"] = 46760, ["Range"] = 25, ["TargetCast"] = true, ["AOECount"] = 2, ["SettingValue"] = AOETimeout == false, ["Proc"] = true,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, ["LineWidth"] = 0, ["Angle"] = 0, },
			--["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
		},
		{
			["Type"] = 1, ["Name"] = "Fire II In Red", ["ID"] = 46759, ["Range"] = 25, ["TargetCast"] = true, ["AOECount"] = 2, ["SettingValue"] = AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, ["LineWidth"] = 0, ["Angle"] = 0, },
			--["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
		},

		--Single Target
		{
			["Type"] = 1, ["Name"] = "Water In Blue", ["ID"] = 46758, ["Range"] = 25, ["TargetCast"] = true, ["Proc"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Aero In Green", ["ID"] = 46757, ["Range"] = 25, ["TargetCast"] = true, ["Proc"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Fire In Red", ["ID"] = 46756, ["Range"] = 25, ["TargetCast"] = true,
		},


		{
			["Type"] = 1, ["Name"] = "Butterfly Motif", ["ID"] = 46763, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 2, ["SettingValue"] = AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 8, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},

		{
			["Type"] = 2, ["Name"] = "Aqua Vite", ["ID"] = 46762, ["Range"] = 20, ["TargetCast"] = false, ["OtherCheck"] = PlayerHP < 50,
		},
		
	}


	self.SendConsoleMessage(ClassTypeID.."PROFILE END",1)
    return SkillList
end

return Profile