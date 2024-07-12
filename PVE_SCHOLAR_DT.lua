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
        ["Setting"] = "Pet",
        ["Options"] = {
            { ["Name"] = "Pet", ["Tooltip"] = "Use Pet", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Pet", ["Tooltip"] = "Dont Use Pet", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
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
    local PartyAggroCount = Data.PartyAggroCount
    local HealTimeout = Data.HealTimeout

	local ShouldApplyBio = self.TargetBuff2(Target,{179,189,1895},3,"Missing",PlayerID)
	
    local AetherflowCD = self.GetActionCD(166,true)
	
	local AOEType = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 35, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, }
	local InTrashMobs = PartyAggroCount >= 2
	
	-- Avoid stacking fey illumination and expedient
	local HasPartyMit = self.TargetBuff2(Player,317,0,"Has",PlayerID) or self.TargetBuff2(Player,2711,0,"Has",PlayerID)

    
	--[[
        166	Aetherflow
        167	Energy Drain
        185	Adloquium
        186	Succor
        188	Sacred Soil
        189	Lustrate
        190	Physick
        802	Embrace
        803	Whispering Dawn
        805	Fey Illumination
        3583	Indomitability
        3584	Broil
        3585	Deployment Tactics
        3586	Emergency Tactics
        3587	Dissipation
        7434	Excogitation
        7435	Broil II
        7436	Chain Stratagem
        7437	Aetherpact
        7438	Fey Union
        7869	Dissolve Union
        16537	Whispering Dawn
        16538	Fey Illumination
        16539	Art of War
        16540	Biolysis
        16541	Broil III
        16542	Recitation
        16543	Fey Blessing
        16544	Fey Blessing
        16545	Summon Seraph
        16546	Consolation
        16547	Consolation
        16548	Seraphic Veil
        16550	Angel's Whisper
        16551	Seraphic Illumination
        17215	Summon Eos
        17864	Bio
        17865	Bio II
        17869	Ruin
        17870	Ruin II
        25865	Broil IV
        25866	Art of War II
        25867	Protraction
        25868	Expedient
        37012	Baneful Impaction
        37013	Concitation
        37014	Seraphism
        37015	Manifestation
        37016	Accession
        37037	Emergency Tactics
	]]--
	
	local SkillList = {
        
        -- Bigger Heals
        {
            ["Type"] = 3, ["Name"] = "Recitation", ["ID"] = 16542, ["Range"] = 30, ["TargetCast"] = false, ["HP"] = 99, ["PartyOnly"] = true,
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["OtherCheck"] = PlayerInCombat == true,
			["OtherActionCooldownCheck"] = { ["ID"] = 7434, ["Time"] = 10, }
        },
		{
			["Type"] = 3, ["Name"] = "Excogitation Tank", ["ID"] = 7434, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 99, ["PartyOnly"] = true, ["RequiredClassType"] = 1,
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["OtherCheck"] = PlayerInCombat == false or InTrashMobs,
			["Buff2"] = { ["Target"] = nil, ["BuffID"] = 1220, ["Time"] = -1, ["Type"] = "Missing", ["Owner"] = PlayerID, ["StackSize"] = nil, }
		},
		{
			["Type"] = 3, ["Name"] = "Protraction", ["ID"] = 25867, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 70, ["PartyOnly"] = true, ["RequiredClassType"] = 1,
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["OtherCheck"] = PlayerInCombat == true,
			["Buff2"] = { ["Target"] = nil, ["BuffID"] = 1220, ["Time"] = -1, ["Type"] = "Missing", ["Owner"] = PlayerID, ["StackSize"] = nil, }
		},
        {
            ["Type"] = 2, ["Name"] = "Fey Blessing", ["ID"] = 16543, ["Range"] = 20, ["TargetCast"] = false, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1,
            ["OtherCheck"] = CurrentPetPOS ~= nil and self.PartyBelowHP(20,70,nil,Data.EntityListSorted.PartySelf,CurrentPetData) >= (PartySize/2) and PlayerInCombat == true,
			["LastActionTimeout"] = "Indom", ["LastActionTime"] = 6000,
        },
        {
            ["Type"] = 2, ["Name"] = "Accession", ["ID"] = 37016, ["Range"] = 15, ["TargetCast"] = false, ["OtherCheck"] = self.PartyBelowHP(15,80,nil,Data.EntityListSorted.PartySelf) >= (PartySize/2) and PartySize > 1,
            ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1,
			["LastActionTimeout"] = "Indom", ["LastActionTime"] = 6000,
        },
        {
            ["Type"] = 2, ["Name"] = "Indomitability", ["ID"] = 3583, ["Range"] = 15, ["TargetCast"] = false, ["OtherCheck"] = self.PartyBelowHP(15,70,nil,Data.EntityListSorted.PartySelf) >= (PartySize/2) and PlayerInCombat == true and not InTrashMobs,
            ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, 
			["LastActionTimeout"] = "Indom", ["LastActionTime"] = 6000,
        },
        {
			["Type"] = 3, ["Name"] = "Sacred Soil", ["ID"] = 188, ["Range"] = 30, ["TargetCast"] = true,
            ["AOECount"] = (PartySize/2), ["AOEType"] = { ["Filter"] = "PartySelf", ["Name"] = "Circle", ["AOERange"] = 13, ["BelowHP"] = 70, ["MaxDistance"] = 30, },
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1,
			["OtherCheck"] = PlayerInCombat == true,
        },
		{
			["Type"] = 3, ["Name"] = "Lustrate", ["ID"] = 189, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 50, ["PartyOnly"] = false,
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["LastActionTimeout"] = "Lustrate", ["LastActionTime"] = 4000,
			["OtherCheck"] = PlayerInCombat == true,
		},
		{
			["Type"] = 3, ["Name"] = "Physick", ["ID"] = 190, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 60, ["PartyOnly"] = false, 
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["OtherCheck"] = PlayerLevel < 30,
		},
        {
            ["Type"] = 2, ["Name"] = "Fey Illumination", ["ID"] = 16538, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = self.PartyBelowHP(30,80,nil,Data.EntityListSorted.PartySelf,CurrentPetData) >= (PartySize/2) and PlayerInCombat == true,
            ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1,
			["Buff"] = not HasPartyMit,
			["LastActionTimeout"] = "Fey Illumination", ["LastActionTime"] = 6000,
        },
        {
            ["Type"] = 2, ["Name"] = "Whispering Dawn", ["ID"] = 16537, ["Range"] = 15, ["TargetCast"] = false, ["OtherCheck"] = self.PartyBelowHP(15,70,nil,Data.EntityListSorted.PartySelf,CurrentPetData) >= (PartySize/2) and PlayerInCombat == true,
            ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1,
        },
		-- AOE
        {
            ["Type"] = 1, ["Name"] = "Baneful Impaction", ["ID"] = 37012, ["Range"] = 25, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1 and self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
        },
        {
            ["Type"] = 2, ["Name"] = "Art of War", ["ID"] = 16539, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 2, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
            ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, }, ["Level"] = self.SkillAccessCheck(16539,25866,PlayerLevel), 
        },
        {
            ["Type"] = 2, ["Name"] = "Art of War II", ["ID"] = 25866, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 2, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1 and self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
            ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, }, ["Level"] = self.SkillAccessCheck(25866,nil,PlayerLevel), 
        },
        -- Smaller Heals
		{
			["Type"] = 3, ["Name"] = "Esuna", ["ID"] = 7568, ["Range"] = 30, ["TargetCast"] = true, ["PartyOnly"] = false, ["Dispellable"] = true, ["OtherCheck"] = PlayerMoving == false,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Esuna") == 1,
		},
		{
			["Type"] = 3, ["Name"] = "Physick", ["ID"] = 190, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 80, ["PartyOnly"] = false, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1,
			["Buff2"] = { ["Target"] = nil, ["BuffID"] = 1220, ["Time"] = -1, ["Type"] = "Missing", ["Owner"] = PlayerID, ["StackSize"] = nil, }, ["OtherCheck"] = PlayerLevel < 30,
		},
		{
			["Type"] = 3, ["Name"] = "Adloquium", ["ID"] = 185, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 80, ["PartyOnly"] = false, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1,
			["Buff2"] = { ["Target"] = nil, ["BuffID"] = {1220,297}, ["Time"] = -1, ["Type"] = "Missing", ["Owner"] = PlayerID, ["StackSize"] = nil, },
			["OtherCheck"] = PlayerLevel < 62,
		},
        {
            ["Type"] = 2, ["Name"] = "Consolation", ["ID"] = 16546, ["Range"] = 15, ["TargetCast"] = false, ["OtherCheck"] = self.PartyBelowHP(15,90,nil,Data.EntityListSorted.PartySelf) >= 1,
            ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1,
			["LastActionTimeout"] = "Consolation", ["LastActionTime"] = 6000,
        },
        {
            ["Type"] = 2, ["Name"] = "Concitation", ["ID"] = 37013, ["Range"] = 15, ["TargetCast"] = false, ["OtherCheck"] = self.PartyBelowHP(15,50,nil,Data.EntityListSorted.PartySelf) >= (PartySize/2) and PartySize > 1 and GaugeData1[1] == 0,
            ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1,
			["LastActionTimeout"] = "Indom", ["LastActionTime"] = 6000,
        },
        {
            ["Type"] = 2, ["Name"] = "Succor", ["ID"] = 186, ["Range"] = 15, ["TargetCast"] = false, ["OtherCheck"] = self.PartyBelowHP(15,50,nil,Data.EntityListSorted.PartySelf) >= (PartySize/2) and PartySize > 1 and (PlayerLevel < 52 or GaugeData1[1] == 0),
            ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1,
			["LastActionTimeout"] = "Indom", ["LastActionTime"] = 6000,
        },
        {
            ["Type"] = 3, ["Name"] = "Aetherpact Tank", ["ID"] = 7437, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 50, ["PartyOnly"] = true,
            ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["OtherCheck"] = PlayerInCombat == true, ["RequiredClassType2"] = "Tank",
			["Buff2"] = { ["Target"] = nil, ["BuffID"] = 1223, ["Time"] = -1, ["Type"] = "Missing", ["Owner"] = PlayerID, ["StackSize"] = nil, }
        },
        {
            ["Type"] = 3, ["Name"] = "Aetherpact Self", ["ID"] = 7437, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 50,
            ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["OtherCheck"] = PlayerInCombat == true and PartySize == 1, 
        },
        {
            ["Type"] = 2, ["Name"] = "Protraction Tank", ["ID"] = 25867, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 60, ["PartyOnly"] = true,
            ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["OtherCheck"] = PlayerInCombat == true, ["RequiredClassType2"] = "Tank",
        },
        {
            ["Type"] = 3, ["Name"] = "Protraction Self", ["ID"] = 25867, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 60, ["PartyOnly"] = true,
            ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["OtherCheck"] = PlayerInCombat == true and PartySize == 1,
        },
        {
            ["Type"] = 2, ["Name"] = "Expedient", ["ID"] = 25868, ["Range"] = 30, ["TargetCast"] = false,
			["OtherCheck"] = self.PartyBelowHP(30,70,nil,Data.EntityListSorted.PartySelf,CurrentPetData) >= (PartySize/2) and PlayerInCombat == true,
            ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1 and self.GetSettingsValue(ClassTypeID,"CDs") == 1,
			["Buff"] = not HasPartyMit,
			["LastActionTimeout"] = "Fey Illumination", ["LastActionTime"] = 6000,
        },
        {
            ["Type"] = 2, ["Name"] = "Dissipation", ["ID"] = 3587, ["Range"] = 30, ["TargetCast"] = false, ["GaugeCheck"] = GaugeData1[1] == 0, ["OtherCheck"] = AetherflowCD > 15 and PlayerInCombat == true,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["PartyOnly"] = true,
			["LastActionTimeout"] = "Aetherflow", ["LastActionTime"] = 5000,
        },
        {
            ["Type"] = 3, ["Name"] = "Excogitation Self", ["ID"] = 7434, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 99, 
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerInCombat == true and PartySize == 1,
        },
        {
            ["Type"] = 2, ["Name"] = "Summon Seraph", ["ID"] = 16545, ["Range"] = 30, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Pet") == 1,
            ["OtherCheck"] = CurrentPet ~= 8227 and PlayerInCombat == true and self.PartyBelowHP(35,80,nil,Data.EntityListSorted.PartySelf) >= (PartySize/2) and PlayerInCombat == true,
            ["LastActionTimeout"] = "PetSummon", ["LastActionTime"] = 5000, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Pet") == 1,
        },
        {
            ["Type"] = 2, ["Name"] = "Seraphism", ["ID"] = 37014, ["Range"] = 50, ["TargetCast"] = false, ["OtherCheck"] = self.PartyBelowHP(50,70,nil,Data.EntityListSorted.PartySelf,CurrentPetData) >= (PartySize/2) and PlayerInCombat == true,
            ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1,
			["LastActionTimeout"] = "PetSummon", ["LastActionTime"] = 5000, 
        },
        {
            ["Type"] = 2, ["Name"] = "Eos", ["ID"] = 17215, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = CurrentPet == 0,
            ["LastActionTimeout"] = "PetSummon", ["LastActionTime"] = 5000, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Pet") == 1,
        },
        {
            ["Type"] = 2, ["Name"] = "Aetherflow", ["ID"] = 166, ["Range"] = 15, ["TargetCast"] = false, ["OtherCheck"] = GaugeData1[1] == 0 or PlayerMP < 30,
			["LastActionTimeout"] = "Aetherflow", ["LastActionTime"] = 5000, 
        },

        -- Damage
		--[[
        {
            ["Type"] = 1, ["Name"] = "Energy Drain", ["ID"] = 167, ["Range"] = 25, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, ["OtherCheck"] = PlayerHP < 50,
        },
		--]]


        {
            ["Type"] = 1, ["Name"] = "Bio", ["ID"] = 17864, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(17864,17865,PlayerLevel), ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, ["Buff"] = ShouldApplyBio == true, ["DOTCheck"] = true,
        },
        {
            ["Type"] = 1, ["Name"] = "Bio II", ["ID"] = 17865, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(17865,16540,PlayerLevel), ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, ["Buff"] = ShouldApplyBio == true, ["DOTCheck"] = true,
        },
        {
            ["Type"] = 1, ["Name"] = "Biolysis", ["ID"] = 16540, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(16540,nil,PlayerLevel), ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, ["Buff"] = ShouldApplyBio == true, ["DOTCheck"] = true,
        },

        {
            ["Type"] = 1, ["Name"] = "Ruin", ["ID"] = 17869, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(17869,17870,PlayerLevel) == true and self.SkillAccessCheck(3584,nil,PlayerLevel) == false, 
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, ["OtherCheck"] = PlayerMoving == false,
        },
        {
            ["Type"] = 1, ["Name"] = "Ruin II", ["ID"] = 17870, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(17870,nil,PlayerLevel), 
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, ["OtherCheck"] = PlayerMoving == true,
        },

        {
            ["Type"] = 1, ["Name"] = "Broil", ["ID"] = 3584, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(3584,7435,PlayerLevel), 
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, ["OtherCheck"] = PlayerMoving == false,
        },
        {
            ["Type"] = 1, ["Name"] = "Broil II", ["ID"] = 7435, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(7435,16541,PlayerLevel), 
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, ["OtherCheck"] = PlayerMoving == false,
        },
        {
            ["Type"] = 1, ["Name"] = "Broil III", ["ID"] = 16541, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(16541,25865,PlayerLevel), 
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, ["OtherCheck"] = PlayerMoving == false,
        },
        {
            ["Type"] = 1, ["Name"] = "Broil IV", ["ID"] = 25865, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25865,nil,PlayerLevel), 
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, ["OtherCheck"] = PlayerMoving == false,
        },

        {
            ["Type"] = 1, ["Name"] = "Chain Stratagem", ["ID"] = 7436, ["Range"] = 30, ["TargetCast"] = true, ["OtherCheck"] = PlayerInCombat == true and TargetID ~= 0,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
        },
        {
            ["Type"] = 3, ["Name"] = "Deployment Tactics", ["ID"] = 3585, ["Range"] = 30, ["TargetCast"] = true, ["OtherCheck"] = PlayerInCombat == true,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["Buff2"] = { ["BuffID"] = {297}, ["Time"] = 3, ["Type"] = "Has", ["Owner"] = PlayerID, }
        },
        {
            ["Type"] = 2, ["Name"] = "Lucid Dreaming", ["ID"] = 7562, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true and PlayerMP < 85,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
        },
    }

	self.SendConsoleMessage(ClassTypeID.."PROFILE END",1)
    return SkillList
end

return Profile