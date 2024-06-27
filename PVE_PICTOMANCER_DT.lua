local Profile = {}

Profile.Settings = {
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
    local CurrentPet = Data.CurrentPet
    local CurrentPetData = Data.CurrentPetData
    local CurrentPetPOS = Data.CurrentPetPOS
    local LastActivePetTime = Data.LastActivePetTime

	--[[
        34650	Fire in Red
        34651	Aero in Green
        34652	Water in Blue
        34653	Blizzard in Cyan
        34654	Stone in Yellow
        34655	Thunder in Magenta
        34656	Fire II in Red
        34657	Aero II in Green
        34658	Water II in Blue
        34659	Blizzard II in Cyan
        34660	Stone II in Yellow
        34661	Thunder II in Magenta
        34662	Holy in White
        34663	Comet in Black
        34664	Pom Motif
        34665	Wing Motif
        34666	Claw Motif
        34667	Maw Motif
        34668	Hammer Motif
        34669	Starry Sky Motif
        34670	Pom Muse
        34671	Winged Muse
        34672	Clawed Muse
        34673	Fanged Muse
        34674	Striking Muse
        34675	Starry Muse
        34676	Mog of the Ages
        34677	Retribution of the Madeen
        34678	Hammer Stamp
        34679	Hammer Brush
        34680	Polishing Hammer
        34681	Star Prism
        34682	Star Prism
        34683	Subtractive Palette
        34684	Smudge
        34685	Tempera Coat
        34686	Tempera Grassa
        34688	Rainbow Drip
        34689	Creature Motif
        34690	Weapon Motif
        34691	Landscape Motif
        35347	Living Muse
        35348	Steel Muse
        35349	Scenic Muse
	]]--

	local SkillList = {
			
	}

	self.SendConsoleMessage(ClassTypeID.."PROFILE END",1)
    return SkillList
end

return Profile