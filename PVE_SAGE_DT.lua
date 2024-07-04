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
        ["Setting"] = "Raise",
        ["Options"] = {
            { ["Name"] = "Raise", ["Tooltip"] = "Raise ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Raise", ["Tooltip"] = "Raise OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "DPS",
        ["Options"] = {
            { ["Name"] = "DPS", ["Tooltip"] = "DPS ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "DPS", ["Tooltip"] = "DPS OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "Heals",
        ["Options"] = {
            { ["Name"] = "Heals", ["Tooltip"] = "Heals ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Heals", ["Tooltip"] = "Heals OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "Esuna",
        ["Options"] = {
            { ["Name"] = "Esuna", ["Tooltip"] = "Esuna ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Esuna", ["Tooltip"] = "Esuna OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
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
        ["Setting"] = "HealType",
        ["Options"] = {
            { ["Name"] = "Party", ["Tooltip"] = "Heal Party", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Ally", ["Tooltip"] = "Heal Ally", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "NPCs",
        ["Options"] = {
            { ["Name"] = "Heal NPCs", ["Tooltip"] = "Heal NPCs", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Heal NPCs", ["Tooltip"] = "Don't Heal NPCs", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "Kardia",
        ["Options"] = {
            { ["Name"] = "Kardia Self", ["Tooltip"] = "Kardia On Self", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Kardia Tank", ["Tooltip"] = "Kardia On Current Tank", ["Colour"] = { ["r"] = 0.45, ["g"] = 0.8, ["b"] = 1, ["a"] = 1 }, },
            { ["Name"] = "Kardia Any", ["Tooltip"] = "Kardia Randomly Selects Party", ["Colour"] = { ["r"] = 1, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Kardia Off", ["Tooltip"] = "Kardia Disabled", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
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
    local HealTimeout = Data.HealTimeout


	--[1] = "Kardia Self",
	--[2] = "Kardia Tank",
	--[3] = "Kardia Any",
	--[4] = "Kardia Off",
	local JobToStance = {
		[1] = { [79] = true, [393] = true, [2843] = true, }, -- Iron Will
		[3] = { [91] = true, [1396] = true, [3124] = true, }, -- Defiance

		[19] = { [79] = true, [393] = true, [2843] = true, }, -- Iron Will
		[21] = { [91] = true, [1396] = true, [3124] = true, }, -- Defiance
		[32] = { [743] = true, [1397] = true, }, -- Grit
		[37] = { [1833] = true, [392] = true, }, -- Royal Guard
	}

	local HasKardiaBuff = false
	local HasKardionBuff = false
	local HasEukrasiaBuff = false
	local HasSwiftcastBuff = false
	for i,e in pairs(Player.buffs) do
		local BuffID = e.id
		if e.ownerid == PlayerID then
			if BuffID == 2604 then 
                HasKardiaBuff = true
            elseif BuffID == 2605 then 
                HasKardionBuff = true
            elseif BuffID == 2606 then 
                HasEukrasiaBuff = true
            elseif BuffID == 167 then 
                HasSwiftcastBuff = true 
            end
		end
	end

	local EukrasianDosisBuff = 0
	if table.valid(Target) == true then
		TargetID = Target.id
		TargetDistance = Target.distance2d
		TargetHP = Target.hp.percent
		for i,e in pairs(Target.buffs) do
			local BuffID = e.id
			if e.ownerid == PlayerID then
				if BuffID == 2614 then 
                    EukrasianDosisBuff = e.duration
                elseif BuffID == 2615 then 
                    EukrasianDosisBuff = e.duration
                elseif BuffID == 2616 then 
                    EukrasianDosisBuff = e.duration 
                end
			end
		end
	end

	--[[
        24283	Dosis
		24284	Diagnosis
		24285	Kardia
		24286	Prognosis
		24287	Egeiro
		24288	Physis
		24289	Phlegma
		24290	Eukrasia
		24291	Eukrasian Diagnosis
		24292	Eukrasian Prognosis
		24293	Eukrasian Dosis
		24294	Soteria
		24295	Icarus
		24296	Druochole
		24297	Dyskrasia
		24298	Kerachole
		24299	Ixochole
		24300	Zoe
		24301	Pepsis
		24302	Physis II
		24303	Taurochole
		24304	Toxikon
		24305	Haima
		24306	Dosis II
		24307	Phlegma II
		24308	Eukrasian Dosis II
		24309	Rhizomata
		24310	Holos
		24311	Panhaima
		24312	Dosis III
		24313	Phlegma III
		24314	Eukrasian Dosis III
		24315	Dyskrasia II
		24316	Toxikon II
		24317	Krasis
		24318	Pneuma
		27524	Pneuma
		28119	Kardia
		37032	Eukrasian Dyskrasia
		37033	Psyche
		37034	Eukrasian Prognosis II
		37035	Philosophia
		37036	Eudaimonia
	]]--

	local SkillList = {
        -- Bigger Heals
		{
			["Type"] = 3, ["Name"] = "Eukrasian Diagnosis", ["ID"] = 24291, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 60, ["PartyOnly"] = false,
			["Buff"] = HasEukrasiaBuff == true, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["OtherCheck"] = PlayerInCombat == true,
		},
		{
			["Type"] = 3, ["Name"] = "Diagnosis", ["ID"] = 24284, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 60, ["PartyOnly"] = false,
			["Buff"] = HasEukrasiaBuff == false, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["OtherCheck"] = PlayerInCombat == true and PlayerMoving == false,
		},
        
		{
			["Type"] = 3, ["Name"] = "Taurochole", ["ID"] = 24303, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 40, ["PartyOnly"] = true, ["RequiredClassType"] = 1,
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["OtherCheck"] = PlayerInCombat == true and GaugeData1[5] == 3 and PlayerMP < 50,
		},
		{
			["Type"] = 3, ["Name"] = "Taurochole", ["ID"] = 24303, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 75, ["PartyOnly"] = true,
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["OtherCheck"] = PlayerInCombat == true,
		},
		{
			["Type"] = 3, ["Name"] = "Haima", ["ID"] = 24305, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 55, ["PartyOnly"] = true, ["RequiredClassType"] = 1,
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["OtherCheck"] = PlayerInCombat == true,
		},
		{
			["Type"] = 3, ["Name"] = "Druochole", ["ID"] = 24296, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 55, ["PartyOnly"] = false,
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["OtherCheck"] = PlayerInCombat == true, ["LastActionTimeout"] = "Druochole", ["LastActionTime"] = 1000,
		},

		{
			["Type"] = 3, ["Name"] = "Esuna", ["ID"] = 7568, ["Range"] = 30, ["TargetCast"] = true, ["PartyOnly"] = false, ["Dispellable"] = true, ["OtherCheck"] = PlayerMoving == false,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Esuna") == 1,
		},

        -- Smaller Heals
		--{
		--	["Type"] = 3, ["Name"] = "Eukrasia", ["ID"] = 24290, ["Range"] = 0, ["TargetCast"] = false, ["HP"] = 95, ["HPAbove"] = 80, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = false,
		--	["OtherCheck"] = PlayerInCombat == true, ["Buff"] = HasEukrasiaBuff == false,
		--},
		{
			["Type"] = 3, ["Name"] = "Eukrasian Diagnosis", ["ID"] = 24291, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 85, ["PartyOnly"] = false,
			["Buff"] = HasEukrasiaBuff == true, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["OtherCheck"] = PlayerInCombat == true,
		},
		{
			["Type"] = 3, ["Name"] = "Diagnosis", ["ID"] = 24284, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 75, ["PartyOnly"] = false,
			["Buff"] = HasEukrasiaBuff == false, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["OtherCheck"] = PlayerMoving == false,
		},

        -- Other

		{
			["Type"] = 2, ["Name"] = "Rhizomata", ["ID"] = 24309, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true and (GaugeData1[5] < 2 or PlayerMP < 20),
		},
		{
			["Type"] = 2, ["Name"] = "Thin Air", ["ID"] = 7430, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true and PlayerMP < 30,
		},
		{
			["Type"] = 2, ["Name"] = "Lucid Dreaming", ["ID"] = 7562, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true and PlayerMP < 70,
		},

		{
			["Type"] = 2, ["Name"] = "Dyskrasia", ["ID"] = 24297, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 2, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1 and self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "DyskrasiaII", ["ID"] = 24315, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 2, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1 and self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},

		--{
		--	["Type"] = 2, ["Name"] = "Eukrasia", ["ID"] = 24290, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true,
		--	["OtherCheck"] = self.PartyBelowHP(15,70) >= (PartySize/2) and PlayerInCombat == true and PlayerMoving == false, ["Buff"] = self.PartyBelowHP(15,85,2609) >= (PartySize/2) and HasEukrasiaBuff == false,
		--},
		{
			["Type"] = 2, ["Name"] = "Eukrasian Prognosis", ["ID"] = 24292, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true,
			["OtherCheck"] = self.PartyBelowHP(15,70) >= (PartySize/2) and PlayerInCombat == true and PlayerMoving == false, ["Buff"] = self.PartyBelowHP(15,70) >= (PartySize/2) and HasEukrasiaBuff == true,
		},

		{
			["Type"] = 2, ["Name"] = "Prognosis", ["ID"] = 24286, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true,
			["OtherCheck"] = self.PartyBelowHP(15,70) >= (PartySize/2) and PlayerInCombat == true and PlayerMoving == false, ["Buff"] = HasEukrasiaBuff == false,
		},
		{
			["Type"] = 2, ["Name"] = "Eukrasian Prognosis", ["ID"] = 24292, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true,
			["OtherCheck"] = self.PartyBelowHP(15,70) >= (PartySize/2) and PlayerInCombat == true and PlayerMoving == false, ["Buff"] = HasEukrasiaBuff == true,
		},

		{
			["Type"] = 2, ["Name"] = "Holos", ["ID"] = 24310, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true,
			["OtherCheck"] = self.PartyBelowHP(15,80,nil,Data.EntityListSorted.PartySelf) >= (PartySize/2) and PlayerInCombat == true,
		},

		{
			["Type"] = 2, ["Name"] = "Physis II", ["ID"] = 24302, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true, ["OtherCheck"] = PlayerInCombat == true,
			["AOECount"] = (PartySize/2), ["AOEType"] = { ["BelowHP"] = 50, ["Filter"] = "PartySelf", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 15, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},

		{
			["Type"] = 2, ["Name"] = "Kerachole", ["ID"] = 24298, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true, ["OtherCheck"] = PlayerInCombat == true,
			["AOECount"] = (PartySize/2), ["AOEType"] = { ["BelowHP"] = 65, ["Filter"] = "PartySelf", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 15, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Kerachole", ["ID"] = 24298, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true, ["OtherCheck"] = PlayerInCombat == true and PlayerMP < 50,
		},
		{
			["Type"] = 2, ["Name"] = "Ixochole", ["ID"] = 24299, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true, ["OtherCheck"] = PlayerInCombat == true,
			["AOECount"] = (PartySize/2), ["AOEType"] = { ["BelowHP"] = 65, ["Filter"] = "PartySelf", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 15, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},

		
		{
			["Type"] = 2, ["Name"] = "Soteria", ["ID"] = 24294, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1,
			["PartyOnly"] = true, ["OtherCheck"] = PlayerInCombat == true and (self.PartyBelowHP(60,85,2607) > 0 or self.PartyBelowHP(60,70,2609) > 0),
		},
		{
			["Type"] = 2, ["Name"] = "Pepsis", ["ID"] = 24301, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1,
			["PartyOnly"] = true, ["OtherCheck"] = PlayerInCombat == true and (self.PartyBelowHP(15,65,2607) > 0 or self.PartyBelowHP(15,70,2609) > 0),
		},
		{
			["Type"] = 2, ["Name"] = "Zoe", ["ID"] = 24300, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1,
			["PartyOnly"] = true, ["OtherCheck"] = PlayerInCombat == true and self.PartyBelowHP(40,35) > 0,
		},
        -- DPS
		{
			["Type"] = 1, ["Name"] = "Toxikon", ["ID"] = 24304, ["Range"] = 25, ["TargetCast"] = true, ["AOECount"] = 2, ["OtherCheck"] = PlayerInCombat == true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1 and self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 1, ["Name"] = "Toxikon II", ["ID"] = 24316, ["Range"] = 25, ["TargetCast"] = true, ["AOECount"] = 2, ["OtherCheck"] = PlayerInCombat == true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1 and self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, ["LineWidth"] = 0, ["Angle"] = 0, },
		},

		{
			["Type"] = 1, ["Name"] = "Phlegma", ["ID"] = 24304, ["Range"] = 6, ["TargetCast"] = true, ["AOECount"] = 2, ["OtherCheck"] = PlayerInCombat == true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 6, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 1, ["Name"] = "Phlegma II", ["ID"] = 24307, ["Range"] = 6, ["TargetCast"] = true, ["AOECount"] = 2, ["OtherCheck"] = PlayerInCombat == true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 6, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 1, ["Name"] = "Phlegma III", ["ID"] = 24313, ["Range"] = 6, ["TargetCast"] = true, ["AOECount"] = 2, ["OtherCheck"] = PlayerInCombat == true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 6, ["LineWidth"] = 0, ["Angle"] = 0, },
		},

		{
			["Type"] = 1, ["Name"] = "Eukrasia", ["ID"] = 24290, ["Range"] = 25, ["TargetCast"] = false, ["Level"] = PlayerLevel >= 30,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, ["Buff"] = HasEukrasiaBuff == false and EukrasianDosisBuff < 3,
		},

		{
			["Type"] = 1, ["Name"] = "Eukrasian Dosis", ["ID"] = 24293, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = PlayerLevel < 46,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, ["Buff"] = HasEukrasiaBuff == true and EukrasianDosisBuff < 3,
		},
		{
			["Type"] = 1, ["Name"] = "Eukrasian Dosis II", ["ID"] = 24308, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = PlayerLevel < 72,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, ["Buff"] = HasEukrasiaBuff == true and EukrasianDosisBuff < 3,
		},
		{
			["Type"] = 1, ["Name"] = "Eukrasian Dosis III", ["ID"] = 24314, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = PlayerLevel >= 72,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, ["Buff"] = HasEukrasiaBuff == true and EukrasianDosisBuff < 3,
		},

		{
			["Type"] = 1, ["Name"] = "Dosis", ["ID"] = 24283, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = PlayerLevel < 72, ["OtherCheck"] = PlayerMoving == false,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Dosis II", ["ID"] = 24306, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = PlayerLevel < 82, ["OtherCheck"] = PlayerMoving == false,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Dosis III", ["ID"] = 24312, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = PlayerLevel >= 82, ["OtherCheck"] = PlayerMoving == false,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1,
		},
	}

    
	if self.GetSettingsValue(ClassTypeID,"Kardia") == 1 or (self.GetSettingsValue(ClassTypeID,"Kardia") ~= 4 and  PartySize == 1) then
		if HasKardiaBuff == false and HasKardionBuff == false then
			local Kardia = ActionList:Get(1,24285)
			if (Kardia and Kardia:IsReady(Player.id)) then
				Kardia:Cast(Player.id)
				self.SendConsoleMessage("Casting Kardia On: "..Player.name,2)
				return true
			end
		end
	elseif self.GetSettingsValue(ClassTypeID,"Kardia") == 2 then
		if HasKardiaBuff == false then
			for i,e in pairs(Data.EntityListSorted.Party) do
				--d(e.name)
				--d(HusbandoMax.API.ClassType[e.job])
				if HusbandoMax.API.ClassType[e.job].Type == 1 and JobToStance[e.job] ~= nil and self.TargetBuff(e,JobToStance[e.job],-1) then
					local Kardia = ActionList:Get(1,24285)
					if (Kardia and Kardia:IsReady(e.id)) then
						Kardia:Cast(e.id)
						self.SendConsoleMessage("Casting Kardia On: "..e.name,2)
						return true
					end
					break
				end
			end
		end
	elseif self.GetSettingsValue(ClassTypeID,"Kardia") == 3 then
		if HasKardiaBuff == false then
			for i,e in pairs(Data.EntityListSorted.Party) do
				local Kardia = ActionList:Get(1,24285)
				if (Kardia and Kardia:IsReady(e.id)) then
					Kardia:Cast(e.id)
					self.SendConsoleMessage("Casting Kardia On: "..e.name,2)
					return true
				end
				break
			end
		end
	end

	self.SendConsoleMessage(ClassTypeID.."PROFILE END",1)
    return SkillList
end

return Profile