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
        ["Setting"] = "DOTs",
        ["Options"] = {
            { ["Name"] = "DOTs", ["Tooltip"] = "DOTs ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "DOTs", ["Tooltip"] = "DOTs OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
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
        ["Setting"] = "ApexArrow",
        ["Options"] = {
            { ["Name"] = "Apex AOE", ["Tooltip"] = "On >= 3", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Apex Burn", ["Tooltip"] = "Allows Single Target Use", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
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
        ["Setting"] = "Paean",
        ["Options"] = {
            { ["Name"] = "Paean", ["Tooltip"] = "Uses Paean On Self", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Paean", ["Tooltip"] = "Paean OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "Peloton",
        ["Options"] = {
            { ["Name"] = "Peloton", ["Tooltip"] = "Peloton ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Peloton", ["Tooltip"] = "Peloton OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
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
    local PHasDispellableDebuff = Data.PHasDispellableDebuff
    local AOETimeout = Data.AOETimeout
    local JumpTimeout = Data.JumpTimeout
    local CastTimeout = Data.CastTimeout



	local Current = GaugeData1[1]
	local Time = GaugeData1[3]

	-- Optimal Song Order
	local OptimalSongOrder = {
		{ ["Song"] = "Minuet", ["PriorSongExpire"] = 0, },
		{ ["Song"] = "Ballad", ["PriorSongExpire"] = 4000, },
		{ ["Song"] = "Paeon", ["PriorSongExpire"] = 12000, },
	}

	local GaugeState = self.GetBardGaugeState(Current)
	local NextAction = nil
	local allActive = true  -- Assume all songs are active initially
	for _, songData in ipairs(OptimalSongOrder) do
		local song = songData.Song
		local timeLeft = songData.PriorSongExpire
		-- Check if any song is not active
		if GaugeState[song] ~= true then
			allActive = false
		end
		-- Check if the song is not active and the remaining time passes
		if GaugeState[song] ~= true and timeLeft >= Time then
			NextAction = song
		end
		if GaugeState[song] ~= true then break end
	end
	-- Check if all songs are active and time is under 3 seconds (3000 milliseconds)
	if allActive == true and Time <= 6000 then
		NextAction = "Finale"
	end

    local SkillList = {
        {
            ["Type"] = 2, ["Name"] = "Peloton", ["ID"] = 7557, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Peloton") == 1, ["OtherCheck"] = PlayerMoving == true and PlayerInCombat == false, ["Buff"] = self.TargetBuff2(Player,1199,3,"Missing") == true,
        },

        {
            ["Type"] = 1, ["Name"] = "Refulgent Arrow", ["ID"] = 7409, ["Range"] = 25, ["Level"] = PlayerLevel >= 70,  ["TargetCast"] = true, ["Buff"] = self.TargetBuff2(Target,128,0,"Has",PlayerID),
        },
        {
            ["Type"] = 1, ["Name"] = "Straight Shot", ["ID"] = 98, ["Range"] = 25, ["Level"] = PlayerLevel < 70,  ["TargetCast"] = true, ["Buff"] = self.TargetBuff2(Target,128,0,"Has",PlayerID),
        },

        {
            ["Type"] = 1, ["Name"] = "Shadowbite", ["ID"] = 16494, ["Range"] = 25, ["TargetCast"] = true, ["AOECount"] = 2, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
            ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Line", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 25, ["LineWidth"] = 5, },
        },
        {
            ["Type"] = 1, ["Name"] = "Refulgent Arrow", ["ID"] = 7409, ["Range"] = 25, ["TargetCast"] = true,
        },
        {
            ["Type"] = 1, ["Name"] = "Straight Shot", ["ID"] = 98, ["Range"] = 25, ["TargetCast"] = true,
        },
        {
            ["Type"] = 1, ["Name"] = "Iron Jaws", ["ID"] = 3560, ["Level"] = PlayerLevel >= 64, ["Range"] = 25, ["TargetCast"] = true,
            ["Buff"] = (self.TargetBuff2(Target,1200,0,"Has",PlayerID) and self.TargetBuff2(Target,1201,0,"Has",PlayerID)) and (self.TargetBuff2(Target,1200,3,"Missing",PlayerID) or self.TargetBuff2(Target,1201,3,"Missing",PlayerID)),
            --["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DOTs") == 1,
        },
        {
            ["Type"] = 1, ["Name"] = "Iron Jaws", ["ID"] = 3560, ["Level"] = PlayerLevel >= 56 and PlayerLevel < 64, ["Range"] = 25, ["TargetCast"] = true,
            ["Buff"] = (self.TargetBuff2(Target,124,0,"Has",PlayerID) and self.TargetBuff2(Target,129,0,"Has",PlayerID)) and (self.TargetBuff2(Target,124,3,"Missing",PlayerID) or self.TargetBuff2(Target,129,3,"Missing",PlayerID)),
            --["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DOTs") == 1,
        },

        {
            ["Type"] = 1, ["Name"] = "Apex Arrow", ["ID"] = 16496, ["Range"] = 25, ["Level"] = PlayerLevel < 86, ["TargetCast"] = true, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"ApexArrow") == 1,
            ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Line", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 25, ["MaxDistance"] = 25, ["LineWidth"] = 4,},
        },
        {
            ["Type"] = 1, ["Name"] = "Apex Arrow", ["ID"] = 16496, ["Range"] = 25, ["Level"] = PlayerLevel < 86, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[4] >= 20, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"ApexArrow") == 2,
        },
        {
            ["Type"] = 1, ["Name"] = "Apex Arrow", ["ID"] = 16496, ["Range"] = 25, ["Level"] = PlayerLevel >= 86, ["TargetCast"] = true, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"ApexArrow") == 1,
            ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Line", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 25, ["MaxDistance"] = 25, ["LineWidth"] = 4,}, ["GaugeCheck"] = GaugeData1[4] >= 80,
        },
        {
            ["Type"] = 1, ["Name"] = "Apex Arrow", ["ID"] = 16496, ["Range"] = 25, ["Level"] = PlayerLevel >= 86, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"ApexArrow") == 2, ["GaugeCheck"] = GaugeData1[4] >= 80,
        },
        {
            ["Type"] = 1, ["Name"] = "Blast Arrow", ["ID"] = 25784, ["Range"] = 25, ["TargetCast"] = true,
        },

        {
            ["Type"] = 1, ["Name"] = "Ladonsbite", ["ID"] = 25783, ["Range"] = 12, ["TargetCast"] = true, ["AOECount"] = 2, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
            ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Cone", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 12, ["MaxDistance"] = 12, ["Angle"] = 90, },
        },
        {
            ["Type"] = 1, ["Name"] = "Quick Nock", ["ID"] = 106, ["Range"] = 12, ["TargetCast"] = true, ["AOECount"] = 2, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
            ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Cone", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 12, ["MaxDistance"] = 12, ["Angle"] = 90, },
        },

        {
            ["Type"] = 1, ["Name"] = "Caustic Bite", ["ID"] = 7406, ["Range"] = 25, ["TargetCast"] = true, ["Buff"] = self.TargetBuff2(Target,1200,0,"Missing",PlayerID),
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DOTs") == 1,
        },
        {
            ["Type"] = 1, ["Name"] = "Stormbite", ["ID"] = 7407, ["Range"] = 25, ["TargetCast"] = true, ["Buff"] = self.TargetBuff2(Target,1201,0,"Missing",PlayerID),
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DOTs") == 1,
        },
        {
            ["Type"] = 1, ["Name"] = "Venomous Bite", ["ID"] = 124, ["Range"] = 25, ["TargetCast"] = true, ["Buff"] = self.TargetBuff2(Target,124,0,"Missing",PlayerID),
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DOTs") == 1,
        },
        {
            ["Type"] = 1, ["Name"] = "Windbite", ["ID"] = 129, ["Range"] = 25, ["TargetCast"] = true, ["Buff"] = self.TargetBuff2(Target,129,0,"Missing",PlayerID),
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DOTs") == 1,
        },
        {
            ["Type"] = 1, ["Name"] = "Heavy Shot", ["ID"] = 97, ["Level"] = PlayerLevel < 76, ["Range"] = 25, ["TargetCast"] = true,
            --["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Debuffs") == 1,
        },
        {
            ["Type"] = 1, ["Name"] = "Burst Shot", ["ID"] = 16495, ["Range"] = 25, ["TargetCast"] = true,
            --["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Debuffs") == 1,
        },

        {
            ["Type"] = 1, ["Name"] = "Rain of Death", ["ID"] = 117, ["Range"] = 25, ["TargetCast"] = true, ["AOECount"] = 2, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
            ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 8, ["MaxDistance"] = 25,},
        },
        {
            ["Type"] = 1, ["Name"] = "Bloodletter", ["ID"] = 110, ["Range"] = 25, ["TargetCast"] = true,
        },
        {
            ["Type"] = 1, ["Name"] = "Empyreal Arrow", ["ID"] = 3558, ["Range"] = 25, ["TargetCast"] = true,
        },
        {
            ["Type"] = 1, ["Name"] = "Sidewinder", ["ID"] = 3562, ["Range"] = 25, ["TargetCast"] = true,
        },

        {
            ["Type"] = 1, ["Name"] = "Pitch Perfect", ["ID"] = 7404, ["Range"] = 25, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[2] == 3 or GaugeData1[3] < 4000,
        },

        {
            ["Type"] = 1, ["Name"] = "The Wanderers Minuet", ["ID"] = 3559, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = PlayerLevel < 90, ["GaugeCheck"] = GaugeData1[3] == 0, ["LastActionTimeout"] = "BardSong", ["LastActionTime"] = 2000,
        },

        {
            ["Type"] = 1, ["Name"] = "Mages Ballad", ["ID"] = 114, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = PlayerLevel < 90, ["GaugeCheck"] = GaugeData1[3] == 0, ["LastActionTimeout"] = "BardSong", ["LastActionTime"] = 2000,
        },

        {
            ["Type"] = 1, ["Name"] = "Army's Paeon", ["ID"] = 116, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = PlayerLevel < 90, ["GaugeCheck"] = GaugeData1[3] == 0, ["LastActionTimeout"] = "BardSong", ["LastActionTime"] = 2000,
        },

        {
            ["Type"] = 1, ["Name"] = "The Wanderers Minuet", ["ID"] = 3559, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = PlayerLevel >= 90, ["GaugeCheck"] = NextAction == "Minuet", ["LastActionTimeout"] = "BardSong", ["LastActionTime"] = 2000,
        },

        {
            ["Type"] = 1, ["Name"] = "Mages Ballad", ["ID"] = 114, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = PlayerLevel >= 90, ["GaugeCheck"] = NextAction == "Ballad", ["LastActionTimeout"] = "BardSong", ["LastActionTime"] = 2000,
        },

        {
            ["Type"] = 1, ["Name"] = "Army's Paeon", ["ID"] = 116, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = PlayerLevel >= 90, ["GaugeCheck"] = NextAction == "Paeon", ["LastActionTimeout"] = "BardSong", ["LastActionTime"] = 2000,
        },

        {
            ["Type"] = 1, ["Name"] = "Raging Strikes", ["ID"] = 101, ["Range"] = 0, ["TargetCast"] = false, ["Level"] = PlayerLevel < 50, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerInCombat == true,
            ["Buff"] = self.TargetBuff2(Player,125,0,"Missing",PlayerID),
        },

        {
            ["Type"] = 1, ["Name"] = "Raging Strikes", ["ID"] = 101, ["Range"] = 0, ["TargetCast"] = false, ["Level"] = PlayerLevel >= 50, ["GaugeCheck"] = NextAction == "Finale", ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerInCombat == true,
            ["Buff"] = self.TargetBuff2(Player,125,0,"Missing",PlayerID),
        },
        {
            ["Type"] = 1, ["Name"] = "Battle Voice", ["ID"] = 118, ["Range"] = 25, ["TargetCast"] = false, ["GaugeCheck"] = PlayerLevel < 50 or NextAction == "Finale", ["Buff"] = self.TargetBuff2(Player,125,0,"Has",PlayerID),
        },
        {
            ["Type"] = 1, ["Name"] = "Radiant Finale", ["ID"] = 25785, ["Range"] = 20, ["TargetCast"] = false, ["GaugeCheck"] = NextAction == "Finale", ["OtherCheck"] = PlayerInCombat == true, ["Buff"] = self.TargetBuff2(Player,125,0,"Has",PlayerID),
        },

        {
            ["Type"] = 1, ["Name"] = "Barrage", ["ID"] = 107, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerInCombat == true,
            ["Buff"] = self.TargetBuff2(Player,128,0,"Missing",PlayerID),
        },

        {
            ["Type"] = 1, ["Name"] = "The Warden's Paean", ["ID"] = 107, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Paean") == 1, ["OtherCheck"] = PlayerInCombat == true,
            ["Buff"] = PHasDispellableDebuff,
        },

        -- Shared CDS
        {
            ["Type"] = 1, ["Name"] = "Head Graze", ["ID"] = 7551, ["Range"] = 25, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Interrupts") == 1, 
            ["OtherCheck"] = PlayerInCombat == true and TargetCastingInterruptible == true,
        },
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