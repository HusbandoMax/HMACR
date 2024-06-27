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
	
	--[[
        34606	Steel Fangs
		34607	Dread Fangs
		34608	Hunter's Sting
		34609	Swiftskin's Sting
		34610	Flanksting Strike
		34611	Flanksbane Fang
		34612	Hindsting Strike
		34613	Hindsbane Fang
		34614	Steel Maw
		34615	Dread Maw
		34616	Hunter's Bite
		34617	Swiftskin's Bite
		34618	Jagged Maw
		34619	Bloodied Maw
		34620	Dreadwinder
		34621	Hunter's Coil
		34622	Swiftskin's Coil
		34623	Pit of Dread
		34624	Hunter's Den
		34625	Swiftskin's Den
		34626	Reawaken
		34627	First Generation
		34628	Second Generation
		34629	Third Generation
		34630	Fourth Generation
		34631	Ouroboros
		34632	Writhing Snap
		34633	Uncoiled Fury
		34634	Death Rattle
		34635	Last Lash
		34636	Twinfang Bite
		34637	Twinblood Bite
		34638	Twinfang Thresh
		34639	Twinblood Thresh
		34640	First Legacy
		34641	Second Legacy
		34642	Third Legacy
		34643	Fourth Legacy
		34644	Uncoiled Twinfang
		34645	Uncoiled Twinblood
		34646	Slither
		34647	Serpent's Ire
		35920	Serpent's Tail
		35921	Twinfang
		35922	Twinblood
	]]--

	local SkillList = {


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
	self.SendConsoleMessage(ClassTypeID.."PROFILE END",1)

    return SkillList
end

return Profile