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
		--Single Target
		{
			["Type"] = 1, ["Name"] = "Rage of Halone", ["ID"] = 26251, ["Range"] = 3, ["TargetCast"] = true, ["Proc"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Riot Blade", ["ID"] = 26250, ["Range"] = 3, ["TargetCast"] = true, ["Proc"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "FastBlade", ["ID"] = 26249, ["Range"] = 3, ["TargetCast"] = true,
		},


		{
			["Type"] = 2, ["Name"] = "Fight or Flight", ["ID"] = 26252, ["Range"] = 20, ["TargetCast"] = false, ["OtherCheck"] = TargetID ~= nil and PlayerInCombat == true,
		},
		{
			["Type"] = 2, ["Name"] = "Rampart", ["ID"] = 26253, ["Range"] = 20, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true,
		},
		{
			["Type"] = 2, ["Name"] = "MedicalKit", ["ID"] = 27315, ["Range"] = 20, ["TargetCast"] = false, ["OtherCheck"] = PlayerHP < 60,
		},
		
	}


	self.SendConsoleMessage(ClassTypeID.."PROFILE END",1)
    return SkillList
end

return Profile