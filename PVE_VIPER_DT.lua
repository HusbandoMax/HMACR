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
    {
        ["Setting"] = "Jumps",
        ["Options"] = {
            { ["Name"] = "Jumps > 5", ["Tooltip"] = "Plunge > 5y", ["Colour"] = { ["r"] = 1, ["g"] = 0.6, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Jumps > 10", ["Tooltip"] = "Plunge > 10y", ["Colour"] = { ["r"] = 1, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Jumps > 15", ["Tooltip"] = "Plunge > 15y", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Jumps Off", ["Tooltip"] = "Plunge Off", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
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
    local PositionToTarget = Data.PositionToTarget
	
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

	d(GaugeData1)
	d(GaugeData2)
	local EndCombo = { -- Buff Target > Combo
		[34609] = "-- Flanksting Strike	 	[3645] Flankstung Venom		> Steel/Dread > Swiftskin Sting > Hindsbane Fang", -- Flanksting Strike	 	[3645] Flankstung Venom		> Steel/Dread > Swiftskin Sting > Hindsbane Fang
		[34612] = "-- Hindsting Strike		[3647] Hindstung Venom		> Steel/Dread > Hunter's Sting > Flanksting Strike", -- Hindsting Strike		[3647] Hindstung Venom		> Steel/Dread > Hunter's Sting > Flanksting Strike
		[34611] = "-- Flanksbane Fang		[3646] Flanksbane Venom		> Steel/Dread > Swiftskin Sting > Hindsting Strike", -- Flanksbane Fang		[3646] Flanksbane Venom		> Steel/Dread > Swiftskin Sting > Hindsting Strike
		[34613] = "-- Hindsbane Fang		[3648] Hindsbane Venom		> Steel/Dread > Hunter's Sting > Flanksbane Fang", -- Hindsbane Fang		[3648] Hindsbane Venom		> Steel/Dread > Hunter's Sting > Flanksbane Fang
	}
	
	local NextCombo = {
		[3645] = 34612, 
		[3647] = 34611, 
		[3646] = 34613, 
		[3648] = 34609, 
	}

	local NextComboUsed = 34609
	for i,e in pairs(NextCombo) do
		local HasBuff = self.TargetBuff2(Player,i,0,"Has",PlayerID)
		d("Checking: "..i.." - "..tostring(HasBuff))
		if HasBuff then
			NextComboUsed = e
			break
		end
	end

	local Stage2Buff = {
		[3668] = { ["Name"] = "Hunter's Instinct", ["Time"] = 0, ["Action"] = 34609 },
		[3669] = { ["Name"] = "Swiftscaled", ["Time"] = 0, ["Action"] = 34608 },
	}
	
	local BestAct = 34609
	local BestBuff = 3668
	local BestBuffTime = math.huge
	for i,e in pairs(Player.buffs) do
		if Stage2Buff[e.id] ~= nil then
			Stage2Buff[e.id].Time = e.duration
		end
	end

	for i,e in pairs(Stage2Buff) do
		if e.Time < BestBuffTime then
			BestBuff = i
			BestBuffTime = e.Time
			BestAct = e.Action
		end
	end

	d("BestBuff: "..BestBuff)
	d("BestAct: "..BestAct)
	d("BestBuff: "..tostring(Stage2Buff[BestBuff]).." - "..tostring(BestBuffTime))

	if PlayerLevel < 20 then
		NextComboUsed = 3645
	elseif PlayerLevel < 30 then
		NextComboUsed = BestAct
	end

	d("NextComboUsed: "..tostring(NextComboUsed))
	d("EndCombo: "..tostring(EndCombo[NextComboUsed]))

	local SkillList = {

		{		
			["Type"] = 1, ["Name"] = "Death Rattle", ["ID"] = 34634, ["Range"] = 3, ["TargetCast"] = true,
		},
		{		
			["Type"] = 2, ["Name"] = "Last Lash", ["ID"] = 34635, ["Range"] = 3, ["TargetCast"] = false,
		},

		{
			["Type"] = 2, ["Name"] = "Twinfang Thresh", ["ID"] = 34638, ["Range"] = 3, ["TargetCast"] = false,
			["Buff"] = self.TargetBuff2(Player,3659,0,"Has",PlayerID),
		},
		{
			["Type"] = 2, ["Name"] = "Twinblood Thresh", ["ID"] = 34639, ["Range"] = 3, ["TargetCast"] = false,
			["Buff"] = self.TargetBuff2(Player,3660,0,"Has",PlayerID),
		},
		{		
			["Type"] = 1, ["Name"] = "Twinfang Bite", ["ID"] = 34636, ["Range"] = 3, ["TargetCast"] = true,
			["Buff"] = self.TargetBuff2(Player,3657,0,"Has",PlayerID),
		},
		{
			["Type"] = 1, ["Name"] = "Twinblood Bite", ["ID"] = 34637, ["Range"] = 3, ["TargetCast"] = true,
			["Buff"] = self.TargetBuff2(Player,3658,0,"Has",PlayerID),
		},
		
		{
			["Type"] = 2, ["Name"] = "Hunter's Den", ["ID"] = 34624, ["Range"] = 3, ["TargetCast"] = false, 
		},
		{
			["Type"] = 2, ["Name"] = "Swiftskin's Den", ["ID"] = 34625, ["Range"] = 3, ["TargetCast"] = false, 
		},

		{
			["Type"] = 1, ["Name"] = "Hunter's Coil", ["ID"] = 34621, ["Range"] = 3, ["TargetCast"] = true, 
			["OtherCheck"] = (GaugeData1[3] == 1 and (PositionToTarget == "Flank" or PositionToTarget == "Front")) or GaugeData1[3] ~= 1
		},
		{
			["Type"] = 1, ["Name"] = "Swiftskin's Coil", ["ID"] = 34622, ["Range"] = 3, ["TargetCast"] = true, 
			["OtherCheck"] = (GaugeData1[3] == 1 and (PositionToTarget == "Rear" or PositionToTarget == "Front")) or GaugeData1[3] ~= 1
		},

		{
			["Type"] = 2, ["Name"] = "Pit of Dread", ["ID"] = 34623, ["Range"] = 3, ["TargetCast"] = false, ["GaugeCheck"] = GaugeData1[3] == 0, 
			["ComboIDNOT"] = { [34609] = true, [34608] = true, [34607] = true, [34606] = true, [34616] = true, [34617] = true, [34615] = true, [34614] = true, },
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0,  },
		},
		{
			["Type"] = 1, ["Name"] = "Dreadwinder", ["ID"] = 34620, ["Range"] = 3, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[3] == 0, 
			["ComboIDNOT"] = { [34609] = true, [34608] = true, [34607] = true, [34606] = true, [34616] = true, [34617] = true, [34615] = true, [34614] = true, },
		},

		

		-- AOE Combo
		{
			["Type"] = 2, ["Name"] = "Bloodied Maw", ["ID"] = 34619, ["Range"] = 5, ["TargetCast"] = false, 
			["Buff"] = self.TargetBuff2(Player,3649,-1,"Missing",PlayerID),
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0,  },
		},
		{
			["Type"] = 2, ["Name"] = "Jagged Maw", ["ID"] = 34618, ["Range"] = 5, ["TargetCast"] = false, 
			["Buff"] = self.TargetBuff2(Player,3650,-1,"Missing",PlayerID),
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0,  },
		},
		
		{
			["Type"] = 2, ["Name"] = "Hunter's Bite", ["ID"] = 34616, ["Range"] = 5, ["TargetCast"] = false, 
			["Buff"] = BestBuff == 3668 or self.SkillAccessCheck(34617,nil,PlayerLevel) == false,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0,  },
		},
		{
			["Type"] = 2, ["Name"] = "Swiftskin's Bite", ["ID"] = 34617, ["Range"] = 5, ["TargetCast"] = false, 
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0,  },
		},
		
		{
			["Type"] = 2, ["Name"] = "Dread Maw", ["ID"] = 34615, ["Range"] = 5, ["TargetCast"] = false, ["Buff"] = (self.EnemyWithBuff2(PlayerPOS,5,3667,20,"Missing",PlayerID) > 2), ["GaugeCheck"] = GaugeData1[3] == 0,
			["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0,  },
			["ComboIDNOT"] = { [34615] = PlayerLevel >= 40, [34614] = PlayerLevel >= 40, }, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
		},
		{
			["Type"] = 2, ["Name"] = "Steel Maw", ["ID"] = 34614, ["Range"] = 5, ["TargetCast"] = false, ["GaugeCheck"] = GaugeData1[3] == 0,
			["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0,  },
			["ComboIDNOT"] = { [34615] = PlayerLevel >= 40, [34614] = PlayerLevel >= 40, }, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
		},

		-- Flanksting Strike	[3645] Flankstung Venom		> Steel/Dread > Swiftskin Sting > Hindsbane Fang
		{
			["Type"] = 1, ["Name"] = "Swiftskin Sting", ["ID"] = 34609, ["ComboID"] = { [34607] = true, [34606] = true, }, ["Range"] = 3, ["TargetCast"] = true, ["Buff"] = NextComboUsed == 34609
		},
		{
			["Type"] = 1, ["Name"] = "Hindsbane Fang", ["ID"] = 34613, ["ComboID"] = { [34609] = true, [34606] = true, }, ["Range"] = 3, ["TargetCast"] = true, ["Buff"] = NextComboUsed == 34609
		},
		
		-- Hindsting Strike		[3647] Hindstung Venom		> Steel/Dread > Hunter's Sting > Flanksting Strike
		{
			["Type"] = 1, ["Name"] = "Hunter's Sting", ["ID"] = 34608, ["ComboID"] = { [34607] = true, [34606] = true, }, ["Range"] = 3, ["TargetCast"] = true, ["Buff"] = NextComboUsed == 34612
		},
		{
			["Type"] = 1, ["Name"] = "Flanksting Strike", ["ID"] = 34610, ["ComboID"] = { [34608] = true, }, ["Range"] = 3, ["TargetCast"] = true, ["Buff"] = NextComboUsed == 34612
		},

		-- Flanksbane Fang		[3646] Flanksbane Venom		> Steel/Dread > Swiftskin Sting > Hindsting Strike
		{
			["Type"] = 1, ["Name"] = "Swiftskin Sting", ["ID"] = 34609, ["ComboID"] = { [34607] = true, [34606] = true, }, ["Range"] = 3, ["TargetCast"] = true, ["Buff"] = NextComboUsed == 34611
		},
		{
			["Type"] = 1, ["Name"] = "Hindsting Strike", ["ID"] = 34612, ["ComboID"] = { [34609] = true, }, ["Range"] = 3, ["TargetCast"] = true, ["Buff"] = NextComboUsed == 34611
		},

		-- Hindsbane Fang		[3648] Hindsbane Venom		> Steel/Dread > Hunter's Sting > Flanksbane Fang
		{
			["Type"] = 1, ["Name"] = "Hunter's Sting", ["ID"] = 34608, ["ComboID"] = { [34607] = true, [34606] = true, }, ["Range"] = 3, ["TargetCast"] = true, ["Buff"] = NextComboUsed == 34613
		},
		{
			["Type"] = 1, ["Name"] = "Flanksbane Fang", ["ID"] = 34611, ["ComboID"] = { [34608] = true, }, ["Range"] = 3, ["TargetCast"] = true, ["Buff"] = NextComboUsed == 34613
		},
		
		-- Combo Starter
		{
			["Type"] = 1, ["Name"] = "Dread Fangs", ["ID"] = 34607, ["Range"] = 3, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[3] == 0,
			["Buff"] = self.TargetBuff2(Target,3667,20,"Missing",PlayerID),
		},
		{
			["Type"] = 1, ["Name"] = "Steel Fangs", ["ID"] = 34606, ["Range"] = 3, ["TargetCast"] = true, ["GaugeCheck"] = GaugeData1[3] == 0,
		},
			
		{
			["Type"] = 1, ["Name"] = "Slither", ["ID"] = 34646, ["Range"] = 20, ["TargetCast"] = true, ["SettingValue"] = JumpTimeout == false and self.GetSettingsValue(ClassTypeID,"Jumps") ~= 4,
			["OtherCheck"] = (self.GetSettingsValue(ClassTypeID,"Jumps") == 1 and TargetDistance > 5) or (self.GetSettingsValue(ClassTypeID,"Jumps") == 2 and TargetDistance > 10) or (self.GetSettingsValue(ClassTypeID,"Jumps") == 3 and TargetDistance > 15),
		},
		{
			["Type"] = 1, ["Name"] = "Writhing Snap", ["ID"] = 34632, ["Range"] = 20, ["TargetCast"] = true, ["OtherCheck"] = GaugeData1[3] == 0,
		},
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