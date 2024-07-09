local Profile = {}

Profile.Settings = {
    {
        ["Setting"] = "CDs",
        ["Options"] = {
            { ["Name"] = "CDs", ["Tooltip"] = "CDs ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "CDs", ["Tooltip"] = "CDs OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "PaintOOC",
        ["Options"] = {
            { ["Name"] = "Paint OOC", ["Tooltip"] = "Paint OOC", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Paint OOC", ["Tooltip"] = "Dont Paint OOC", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "AOE",
        ["Options"] = {
            { ["Name"] = "AOE", ["Tooltip"] = "AOE ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "AOE", ["Tooltip"] = "AOE OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
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
        --34650	Fire in Red
        --34651	Aero in Green
        --34652	Water in Blue
        --34653	Blizzard in Cyan
        --34654	Stone in Yellow
        --34655	Thunder in Magenta
        --34656	Fire II in Red
        --34657	Aero II in Green
        --34658	Water II in Blue
        --34659	Blizzard II in Cyan
        --34660	Stone II in Yellow
        --34661	Thunder II in Magenta
        --34662	Holy in White
        34663	Comet in Black
        --34664	Pom Motif
        --34665	Wing Motif
        --34666	Claw Motif
        --34667	Maw Motif
        --34668	Hammer Motif
        --34669	Starry Sky Motif
        --34670	Pom Muse
        --34671	Winged Muse
        --34672	Clawed Muse
        --34673	Fanged Muse
        --34674	Striking Muse
        --34675	Starry Muse
        --34676	Mog of the Ages
        34677	Retribution of the Madeen
        34678	Hammer Stamp
        34679	Hammer Brush
        34680	Polishing Hammer
        34681	Star Prism
        34682	Star Prism
        --34683	Subtractive Palette
        34684	Smudge
        34685	Tempera Coat
        34686	Tempera Grassa
        34688	Rainbow Drip
        --34689	Creature Motif
       -- 34690	Weapon Motif
        --34691	Landscape Motif
        35347	Living Muse
        35348	Steel Muse
        35349	Scenic Muse
	]]--

	local SkillList = {

        -- Creature
		{
			["Type"] = 1, ["Name"] = "Mog of the Ages", ["ID"] = 34676, ["Range"] = 25, ["TargetCast"] = true,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, 
		},
		{
			["Type"] = 1, ["Name"] = "Pom Muse", ["ID"] = 34670, ["Range"] = 25, ["TargetCast"] = true,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, 
		},
		{
			["Type"] = 1, ["Name"] = "Winged Muse", ["ID"] = 34671, ["Range"] = 25, ["TargetCast"] = true,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, 
		},
		{
			["Type"] = 2, ["Name"] = "Creature - Wing Motif - OOC", ["ID"] = 34665, ["Range"] = 25, ["TargetCast"] = false, ["GaugeCheck"] = GaugeData1[3] == 0,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"PaintOOC") == 1, ["OtherCheck"] = PlayerInCombat == false,
		},
		{
			["Type"] = 2, ["Name"] = "Creature - Pom Motif - OOC", ["ID"] = 34664, ["Range"] = 25, ["TargetCast"] = false, ["GaugeCheck"] = GaugeData1[3] == 0,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"PaintOOC") == 1, ["OtherCheck"] = PlayerInCombat == false,
		},
		{
			["Type"] = 2, ["Name"] = "Creature - Wing Motif", ["ID"] = 34665, ["Range"] = 25, ["TargetCast"] = false, ["GaugeCheck"] = GaugeData1[3] == 0, ["OtherCheck"] = PlayerInCombat == true,
		},
		{
			["Type"] = 2, ["Name"] = "Creature - Pom Motif", ["ID"] = 34664, ["Range"] = 25, ["TargetCast"] = false, ["GaugeCheck"] = GaugeData1[3] == 0, ["OtherCheck"] = PlayerInCombat == true,
		},

        -- Weapon
		{
			["Type"] = 1, ["Name"] = "Hammer Stamp", ["ID"] = 34678, ["Range"] = 25, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Striking Muse", ["ID"] = 34674, ["Range"] = 25, ["TargetCast"] = false,
		},
		{
			["Type"] = 2, ["Name"] = "Weapon - Hammer Motif - OOC", ["ID"] = 34668, ["Range"] = 25, ["TargetCast"] = false, ["GaugeCheck"] = GaugeData1[5] == 0,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"PaintOOC") == 1, ["OtherCheck"] = PlayerInCombat == false,
		},
		{
			["Type"] = 2, ["Name"] = "Weapon - Hammer Motif", ["ID"] = 34668, ["Range"] = 25, ["TargetCast"] = false, ["GaugeCheck"] = GaugeData1[5] == 0, ["OtherCheck"] = PlayerInCombat == true,
		},

        -- Landscape
		{
			["Type"] = 1, ["Name"] = "Starry Muse", ["ID"] = 34675, ["Range"] = 25, ["TargetCast"] = false, ["Buff"] = self.TargetBuff2(Player,3674,-1,"Missing",PlayerID) == true,
		},
		{
			["Type"] = 2, ["Name"] = "Landscape - Starry Sky Motif - OOC", ["ID"] = 34669, ["Range"] = 25, ["TargetCast"] = false, ["GaugeCheck"] = GaugeData1[6] == 0,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"PaintOOC") == 1, ["OtherCheck"] = PlayerInCombat == false,
		},
		{
			["Type"] = 2, ["Name"] = "Landscape - Starry Sky Motif", ["ID"] = 34669, ["Range"] = 25, ["TargetCast"] = false, ["GaugeCheck"] = GaugeData1[6] == 0, ["OtherCheck"] = PlayerInCombat == true,
		},



		{
			["Type"] = 1, ["Name"] = "Holy in White - AOE", ["ID"] = 34662, ["Range"] = 25, ["TargetCast"] = true,
			["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 5, ["Angle"] = 90, },
		},
		{
			["Type"] = 1, ["Name"] = "Holy in White - Burn", ["ID"] = 34662, ["Range"] = 25, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[2] > 3,
		},
		{
			["Type"] = 1, ["Name"] = "Holy in White - Moving", ["ID"] = 34662, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = PlayerMoving == true, ["GaugeCheck"] = GaugeData1[2] > 2,
		},

		{
			["Type"] = 1, ["Name"] = "Subtractive Palette", ["ID"] = 34683, ["Range"] = 25, ["TargetCast"] = false, ["Buff"] = self.TargetBuff2(Player,3674,-1,"Missing",PlayerID) == true,
		},

        
        -- Sub AOE Combo
		{
			["Type"] = 2, ["Name"] = "Blizzard II in Cyan", ["ID"] = 34659, ["Range"] = 25, ["TargetCast"] = true,
			["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 5, ["Angle"] = 90, },
		},
		{
			["Type"] = 2, ["Name"] = "Stone II in Yellow", ["ID"] = 34660, ["Range"] = 25, ["TargetCast"] = true,
			["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 5, ["Angle"] = 90, },
		},
		{
			["Type"] = 2, ["Name"] = "Thunder II in Magenta", ["ID"] = 34661, ["Range"] = 25, ["TargetCast"] = true,
			["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 5, ["Angle"] = 90, },
		},

        -- Sub Single Target Combo
		{
			["Type"] = 1, ["Name"] = "Blizzard in Cyan", ["ID"] = 34653, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = PlayerMoving == false,
		},
		{
			["Type"] = 1, ["Name"] = "Stone in Yellow", ["ID"] = 34654, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = PlayerMoving == false,
		},
		{
			["Type"] = 1, ["Name"] = "Thunder in Magenta", ["ID"] = 34655, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = PlayerMoving == false,
		},

        -- AOE Combo
		{
			["Type"] = 2, ["Name"] = "Fire II in Red", ["ID"] = 34656, ["Range"] = 25, ["TargetCast"] = true,
			["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 5, ["Angle"] = 90, },
		},
		{
			["Type"] = 2, ["Name"] = "Aero II in Green", ["ID"] = 34657, ["Range"] = 25, ["TargetCast"] = true,
			["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 5, ["Angle"] = 90, },
		},
		{
			["Type"] = 2, ["Name"] = "Water II in Blue", ["ID"] = 34658, ["Range"] = 25, ["TargetCast"] = true,
			["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 5, ["Angle"] = 90, },
		},

        -- Single Target Combo
		{
			["Type"] = 1, ["Name"] = "Fire in Red", ["ID"] = 34650, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = PlayerMoving == false,
		},
		{
			["Type"] = 1, ["Name"] = "Aero in Green", ["ID"] = 34651, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = PlayerMoving == false,
		},
		{
			["Type"] = 1, ["Name"] = "Water in Blue", ["ID"] = 34652, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = PlayerMoving == false,
		},

	}

	self.SendConsoleMessage(ClassTypeID.."PROFILE END",1)
    return SkillList
end

return Profile