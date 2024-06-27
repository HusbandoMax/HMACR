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
        ["Setting"] = "Cards",
        ["Options"] = {
            { ["Name"] = "Cards", ["Tooltip"] = "Cards ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Cards", ["Tooltip"] = "Cards OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
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

	
	local HasHoroscopeBuff = 0
	local HasHoroscopeHeliosBuff = 0
	local HasLightspeedBuff = 0
	for i,e in pairs(Player.buffs) do
		local BuffID = e.id
		if e.ownerid == PlayerID then
			if BuffID == 1890 then 
				HasHoroscopeBuff = e.duration
			elseif BuffID == 1891 then 
				HasHoroscopeHeliosBuff = e.duration
			elseif BuffID == 841 then 
				HasLightspeedBuff = true
			end
		end
	end

	local ShouldApplyCombust = self.TargetBuff2(Target,{838,843,1881,2041},3,"Missing",PlayerID)
    
    -- GaugeData 2>4
    -- 1 = Solar > The Bole, The Balance
    -- 2 = Lunar > The Arrow, The Ewer
    -- 3 = Celestial > The Spire, The Spear

    -- ID: 4401	GuageID: 1 Status: 913 The Balance -- Melee DPS/Tank
    -- ID: 4405	GuageID: 5 Status: 917 The Ewer -- Ranged/Healer
    -- ID: 4406	GuageID: 6 Status: 918 The Spire -- Ranged/Healer
    -- ID: 4404	GuageID: 2 Status: 914 The Bole -- Ranged/Healer
    -- ID: 4402	GuageID: 3 Status: 915 The Arrow -- Melee DPS/Tank
    -- ID: 4403	GuageID: 4 Status: 916 The Spear -- Melee DPS/Tank
    local GaugeHasSolarCard = GaugeData1[2] == 1 or GaugeData1[3] == 1 or GaugeData1[4] == 1
    local GaugeHasLunarCard = GaugeData1[2] == 2 or GaugeData1[3] == 2 or GaugeData1[4] == 2
    local GaugeHasCelestialCard = GaugeData1[2] == 3 or GaugeData1[3] == 3 or GaugeData1[4] == 3
    --d("GaugeHasSolarCard: "..tostring(GaugeHasSolarCard))
    --d("GaugeHasLunarCard: "..tostring(GaugeHasLunarCard))
    --d("GaugeHasCelestialCard: "..tostring(GaugeHasCelestialCard))

    local HasSolarCard = GaugeData1[1] == 1 or GaugeData1[1] == 2 --not self.TargetBuff2(Player,{913,914},0,"Missing",PlayerID)
    local HasLunarCard = GaugeData1[1] == 3 or GaugeData1[1] == 5 --not self.TargetBuff2(Player,{917,915},0,"Missing",PlayerID)
    local HasCelestialCard = GaugeData1[1] == 4 or GaugeData1[1] == 6 --not self.TargetBuff2(Player,{918,916},0,"Missing",PlayerID)
    --d("HasSolarCard: "..tostring(HasSolarCard))
    --d("HasLunarCard: "..tostring(HasLunarCard))
    --d("HasCelestialCard: "..tostring(HasCelestialCard))

    
    local ShouldRedraw = false
    if self.TargetBuff2(Player,2713,0,"Has",PlayerID) == true then
        --d("Can Redraw")
        if GaugeHasSolarCard == true and HasSolarCard == true then
            --d("Redraw Solar")
            ShouldRedraw = true
        elseif GaugeHasLunarCard == true and HasLunarCard == true then
            --d("Redraw Lunar")
            ShouldRedraw = true
        elseif GaugeHasCelestialCard == true and HasCelestialCard == true then
            --d("Redraw Celestial")
            ShouldRedraw = true
        end
    end
    --d("ShouldRedraw: "..tostring(ShouldRedraw))

	--[[
        3594	Benefic
        3595	Aspected Benefic
        3596	Malefic
        3598	Malefic II
        3599	Combust
        3600	Helios
        3601	Aspected Helios
        3603	Ascend
        3606	Lightspeed
        3608	Combust II
        3610	Benefic II
        3612	Synastry
        3613	Collective Unconscious
        3614	Essential Dignity
        3615	Gravity
        7439	Earthly Star
        7440	Stellar Burst
        7441	Stellar Explosion
        7442	Malefic III
        7444	Lord of Crowns
        7445	Lady of Crowns
        8324	Stellar Detonation
        16552	Divination
        16553	Celestial Opposition
        16554	Combust III
        16555	Malefic IV
        16556	Celestial Intersection
        16557	Horoscope
        16558	Horoscope
        16559	Neutral Sect
        25871	Fall Malefic
        25872	Gravity II
        25873	Exaltation
        25874	Macrocosmos
        25875	Microcosmos
        37017	Astral Draw
        37018	Umbral Draw
        37019	Play I
        37020	Play II
        37021	Play III
        37022	Minor Arcana
        37023	the Balance
        37024	the Arrow
        37025	the Spire
        37026	the Spear
        37027	the Bole
        37028	the Ewer
        37029	Oracle
        37030	Helios Conjunction
        37031	Sun Sign
	]]--

	local SkillList = {
        -- Draw Cards
        {
			["Type"] = 2, ["Name"] = "Astrodyne", ["ID"] = 25870, ["Range"] = 30, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true,
		},
        {
			["Type"] = 2, ["Name"] = "Draw", ["ID"] = 3590, ["Range"] = 30, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and HasSolarCard == false and HasLunarCard == false and HasCelestialCard == false and (GaugeData1[2] == 0 or GaugeData1[3] == 0 or GaugeData1[4] == 0),
		},
        {
			["Type"] = 2, ["Name"] = "Redraw", ["ID"] = 3593, ["Range"] = 30, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == true,
		},

        -- Play Cards (Party)

		{
			["Type"] = 3, ["Name"] = "The Balance", ["ID"] = 4401, ["Range"] = 30, ["TargetCast"] = true, ["PartyOnly"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == false and HasSolarCard == true, ["RequiredClassType2"] = "DPS - Melee",
		},
        {
			["Type"] = 3, ["Name"] = "The Balance", ["ID"] = 4401, ["Range"] = 30, ["TargetCast"] = true, ["PartyOnly"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == false and HasSolarCard == true, ["RequiredClassType2"] = "Tank",
		},
		{
			["Type"] = 3, ["Name"] = "The Arrow", ["ID"] = 4402, ["Range"] = 30, ["TargetCast"] = true, ["PartyOnly"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == false and HasLunarCard == true, ["RequiredClassType2"] = "DPS - Melee",
		},
        {
			["Type"] = 3, ["Name"] = "The Arrow", ["ID"] = 4402, ["Range"] = 30, ["TargetCast"] = true, ["PartyOnly"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == false and HasLunarCard == true, ["RequiredClassType2"] = "Tank",
		},
		{
			["Type"] = 3, ["Name"] = "The Spear", ["ID"] = 4403, ["Range"] = 30, ["TargetCast"] = true, ["PartyOnly"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == false and HasCelestialCard == true, ["RequiredClassType2"] = "DPS - Melee",
		},
        {
			["Type"] = 3, ["Name"] = "The Spear", ["ID"] = 4403, ["Range"] = 30, ["TargetCast"] = true, ["PartyOnly"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == false and HasCelestialCard == true, ["RequiredClassType2"] = "Tank",
		},

		{
			["Type"] = 3, ["Name"] = "The Ewer", ["ID"] = 4405, ["Range"] = 30, ["TargetCast"] = true, ["PartyOnly"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == false and HasLunarCard == true, ["RequiredClassType2"] = "DPS - Ranged",
		},
        {
			["Type"] = 3, ["Name"] = "The Ewer", ["ID"] = 4405, ["Range"] = 30, ["TargetCast"] = true, ["PartyOnly"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == false and HasLunarCard == true, ["RequiredClassType2"] = "Healer",
		},
		{
			["Type"] = 3, ["Name"] = "The Spire", ["ID"] = 4406, ["Range"] = 30, ["TargetCast"] = true, ["PartyOnly"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == false and HasCelestialCard == true, ["RequiredClassType2"] = "DPS - Ranged",
		},
        {
			["Type"] = 3, ["Name"] = "The Spire", ["ID"] = 4406, ["Range"] = 30, ["TargetCast"] = true, ["PartyOnly"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == false and HasCelestialCard == true, ["RequiredClassType2"] = "Healer",
		},
		{
			["Type"] = 3, ["Name"] = "The Bole", ["ID"] = 4404, ["Range"] = 30, ["TargetCast"] = true, ["PartyOnly"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == false and HasSolarCard == true, ["RequiredClassType2"] = "DPS - Ranged",
		},
        {
			["Type"] = 3, ["Name"] = "The Bole", ["ID"] = 4404, ["Range"] = 30, ["TargetCast"] = true, ["PartyOnly"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == false and HasSolarCard == true, ["RequiredClassType2"] = "Healer",
		},

        -- Play Cards (Self)
		{
			["Type"] = 2, ["Name"] = "The Balance", ["ID"] = 4401, ["Range"] = 30, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == false and HasSolarCard == true,
		},
        {
			["Type"] = 2, ["Name"] = "The Balance", ["ID"] = 4401, ["Range"] = 30, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == false and HasSolarCard == true,
		},
		{
			["Type"] = 2, ["Name"] = "The Arrow", ["ID"] = 4402, ["Range"] = 30, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == false and HasLunarCard == true,
		},
        {
			["Type"] = 2, ["Name"] = "The Arrow", ["ID"] = 4402, ["Range"] = 30, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == false and HasLunarCard == true,
		},
		{
			["Type"] = 2, ["Name"] = "The Spear", ["ID"] = 4403, ["Range"] = 30, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == false and HasCelestialCard == true,
		},
        {
			["Type"] = 2, ["Name"] = "The Spear", ["ID"] = 4403, ["Range"] = 30, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == false and HasCelestialCard == true,
		},

		{
			["Type"] = 2, ["Name"] = "The Ewer", ["ID"] = 4405, ["Range"] = 30, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == false and HasLunarCard == true,
		},
        {
			["Type"] = 2, ["Name"] = "The Ewer", ["ID"] = 4405, ["Range"] = 30, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == false and HasLunarCard == true,
		},
		{
			["Type"] = 2, ["Name"] = "The Spire", ["ID"] = 4406, ["Range"] = 30, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == false and HasCelestialCard == true,
		},
        {
			["Type"] = 2, ["Name"] = "The Spire", ["ID"] = 4406, ["Range"] = 30, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == false and HasCelestialCard == true,
		},
		{
			["Type"] = 2, ["Name"] = "The Bole", ["ID"] = 4404, ["Range"] = 30, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == false and HasSolarCard == true,
		},
        {
			["Type"] = 2, ["Name"] = "The Bole", ["ID"] = 4404, ["Range"] = 30, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Cards") == 1,
            ["OtherCheck"] = PlayerInCombat == true and ShouldRedraw == false and HasSolarCard == true,
		},

        -- Inital Use
        {
            ["Type"] = 2, ["Name"] = "Horoscope", ["ID"] = 16558, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true and HasHoroscopeBuff == 0 and HasHoroscopeHeliosBuff == 0,
            ["AOECount"] = (PartySize/2), ["AOEType"] = { ["BelowHP"] = 70, ["Filter"] = "PartySelf", ["Name"] = "Circle", ["TargetPoint"] = nil, ["AOERange"] = 10, ["MaxDistance"] = 30, ["LineWidth"] = 0, ["Angle"] = 0, },
        },
        -- Active HP Trigger
        {
            ["Type"] = 2, ["Name"] = "Horoscope", ["ID"] = 16558, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true and HasHoroscopeHeliosBuff ~= 0,
            ["AOECount"] = (PartySize/2), ["AOEType"] = { ["BelowHP"] = 75, ["Filter"] = "PartySelf", ["Name"] = "Circle", ["TargetPoint"] = nil, ["AOERange"] = 10, ["MaxDistance"] = 30, ["LineWidth"] = 0, ["Angle"] = 0, },
        },
        -- Time Trigger
        {
            ["Type"] = 2, ["Name"] = "Horoscope", ["ID"] = 16558, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true and HasHoroscopeHeliosBuff ~= 0 and HasHoroscopeHeliosBuff < 1,
        },
        -- Time Expire
        {
            ["Type"] = 2, ["Name"] = "Horoscope", ["ID"] = 16558, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true and HasHoroscopeBuff ~= 0 and HasHoroscopeBuff < 0.6,
        },

        -- Bigger Heals (Higher Prio)
		{
			["Type"] = 3, ["Name"] = "Benefic II", ["ID"] = 3610, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 60, ["PartyOnly"] = false, ["OtherCheck"] = PlayerMoving == false,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Heals") == 1,
		},

        {
            ["Type"] = 3, ["Name"] = "Essential Dignity", ["ID"] = 3614, ["Range"] = 30, ["TargetCast"] = true, ["OtherCheck"] = PlayerInCombat == true, 
            ["HP"] = 40, ["LastActionTimeout"] = "ASTEssentialDignity", ["LastActionTime"] = 500,
        },
        {
            ["Type"] = 3, ["Name"] = "Celestial Intersection", ["ID"] = 16556, ["Range"] = 30, ["TargetCast"] = true, ["OtherCheck"] = PlayerInCombat == true, 
            ["HP"] = 65, ["LastActionTimeout"] = "ASTCelestialIntersection", ["LastActionTime"] = 500,
        },
        
		{
			["Type"] = 2, ["Name"] = "Horoscope", ["ID"] = 16557, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true,
			["OtherCheck"] = self.PartyBelowHP(20,60,nil,Data.EntityListSorted.PartySelf) >= (PartySize/2) and PlayerInCombat == true and PlayerMoving == false,
		},
		{
			["Type"] = 2, ["Name"] = "Aspected Helios", ["ID"] = 3601, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true,
			["OtherCheck"] = self.PartyBelowHP(20,85,836,Data.EntityListSorted.PartySelf) >= (PartySize/2) and PlayerInCombat == true and PlayerMoving == false,
		},
		{
			["Type"] = 2, ["Name"] = "Helios", ["ID"] = 3600, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true,
			["OtherCheck"] = self.PartyBelowHP(15,75,nil,Data.EntityListSorted.PartySelf) >= (PartySize/2) and PlayerInCombat == true and PlayerMoving == false,
		},
		{
			["Type"] = 2, ["Name"] = "Collective Unconscious", ["ID"] = 3613, ["Range"] = 8, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true,
			["AOECount"] = (PartySize/2), ["AOEType"] = { ["BelowHP"] = 50, ["Filter"] = "PartySelf", ["Name"] = "Circle", ["TargetPoint"] = Player.pos, ["AOERange"] = 8, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Celestial Opposition", ["ID"] = 16553, ["Range"] = 8, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true,
			["AOECount"] = (PartySize/2), ["AOEType"] = { ["BelowHP"] = 60, ["Filter"] = "PartySelf", ["Name"] = "Circle", ["TargetPoint"] = Player.pos, ["AOERange"] = 8, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Lady of Crowns", ["ID"] = 7445, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true,
			["OtherCheck"] = self.PartyBelowHP(15,75,nil,Data.EntityListSorted.PartySelf) >= (PartySize/2) and PlayerInCombat == true,
		},

        -- Smaller Heals
		{
			["Type"] = 3, ["Name"] = "Esuna", ["ID"] = 7568, ["Range"] = 30, ["TargetCast"] = true, ["PartyOnly"] = false, ["Dispellable"] = true, ["OtherCheck"] = PlayerMoving == false,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Esuna") == 1,
		},

		{
			["Type"] = 3, ["Name"] = "Benefic II", ["ID"] = 3610, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 70, ["PartyOnly"] = false, ["OtherCheck"] = PlayerMoving == false,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Heals") == 1,
		},
		{
			["Type"] = 3, ["Name"] = "Benefic", ["ID"] = 3594, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 85, ["PartyOnly"] = false, ["OtherCheck"] = PlayerMoving == false,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Heals") == 1,
		},
		{
			["Type"] = 3, ["Name"] = "Aspected Benefic", ["ID"] = 3595, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 95, ["HPAbove"] = 85, ["PartyOnly"] = true,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["Buff2"] = { ["Target"] = nil, ["BuffID"] = {835}, ["Time"] = -1, ["Type"] = "Missing", ["Owner"] = PlayerID, ["StackSize"] = nil, }
		},

        {
            ["Type"] = 3, ["Name"] = "Synastry", ["ID"] = 3612, ["Range"] = 30, ["TargetCast"] = true, ["OtherCheck"] = PlayerInCombat == true, ["HP"] = 40, ["PartyOnly"] = true,
        },
        {
            ["Type"] = 3, ["Name"] = "Exaltation", ["ID"] = 25873, ["Range"] = 30, ["TargetCast"] = true, ["OtherCheck"] = PlayerInCombat == true, ["HP"] = 30, ["PartyOnly"] = true,
        },

        -- DOT
        {
			["Type"] = 1, ["Name"] = "Combust", ["ID"] = 3599, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(3599,3608,PlayerLevel),
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, ["Buff"] = ShouldApplyCombust == true, ["DOTCheck"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Combust II", ["ID"] = 3608, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(3608,16554,PlayerLevel),
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, ["Buff"] = ShouldApplyCombust == true, ["DOTCheck"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Combust III", ["ID"] = 16554, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(16554,nil,PlayerLevel),
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, ["Buff"] = ShouldApplyCombust == true, ["DOTCheck"] = true,
		},
        -- AOE DPS
        {
			["Type"] = 1, ["Name"] = "Gravity", ["ID"] = 3615, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(3615,25872,PlayerLevel), ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, 
            ["AOECount"] = 2, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
        },
        {
			["Type"] = 1, ["Name"] = "Gravity II", ["ID"] = 25872, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25872,nil,PlayerLevel), ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, 
            ["AOECount"] = 2, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
        },
        -- Single Target DPS
		{
			["Type"] = 1, ["Name"] = "Malefic", ["ID"] = 3596, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(3596,3598,PlayerLevel), ["OtherCheck"] = PlayerMoving == false,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Malefic II", ["ID"] = 3598, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(3598,7442,PlayerLevel), ["OtherCheck"] = PlayerMoving == false,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1,
		},
		{ 
			["Type"] = 1, ["Name"] = "Malefic III", ["ID"] = 7442, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(7442,16555,PlayerLevel), ["OtherCheck"] = PlayerMoving == false,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Malefic IV", ["ID"] = 16555, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(16555,25871,PlayerLevel), ["OtherCheck"] = PlayerMoving == false,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Fall Malefic", ["ID"] = 25871, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25871,nil,PlayerLevel), ["OtherCheck"] = PlayerMoving == false,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1,
		},

        {
			["Type"] = 2, ["Name"] = "Lord of Crowns", ["ID"] = 7444, ["Range"] = 20, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, 
            ["AOECount"] = 2, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 18, ["MaxDistance"] = 0, },
        },
        {
			["Type"] = 2, ["Name"] = "Macrocosmos", ["ID"] = 25874, ["Range"] = 20, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, 
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 18, ["MaxDistance"] = 0, },
        },
        {
			["Type"] = 2, ["Name"] = "Microcosmos", ["ID"] = 25875, ["Range"] = 20, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Heals") == 1, 
            ["OtherCheck"] = self.PartyBelowHP(15,75,nil,Data.EntityListSorted.PartySelf) >= (PartySize/2) and PlayerInCombat == true,
        },
        {
			["Type"] = 2, ["Name"] = "Microcosmos", ["ID"] = 25875, ["Range"] = 20, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Heals") == 1, 
            ["OtherCheck"] = self.TargetBuff2(Player,2718,2,"Missing",PlayerID),
        },

		{ -- Used as self placed for damage atm
			["Type"] = 2, ["Name"] = "Earthly Star", ["ID"] = 7439, ["Range"] = 18, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,  ["OtherCheck"] = PlayerMoving == false and PlayerInCombat == true,
			["AOECount"] = 1, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = Player.pos, ["AOERange"] = 18, ["MaxDistance"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Neutral Sect", ["ID"] = 16559, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true,
			["OtherCheck"] = self.PartyBelowHP(25,50,nil,Data.EntityListSorted.PartySelf) >= (PartySize/2) and PlayerInCombat == true,
		},

		{
			["Type"] = 2, ["Name"] = "Lightspeed", ["ID"] = 3606, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = self.PartyBelowHP(20,80,836,Data.EntityListSorted.PartySelf) >= (PartySize/2) and PlayerInCombat == true and PlayerMoving == true,
		},
        {
			["Type"] = 2, ["Name"] = "Divination", ["ID"] = 16552, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true,
		},
        {
			["Type"] = 2, ["Name"] = "Minor Arcana", ["ID"] = 7443, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true,
		},

        {
			["Type"] = 2, ["Name"] = "Thin Air", ["ID"] = 7430, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true and PlayerMP < 30,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
		},
		{
			["Type"] = 2, ["Name"] = "Lucid Dreaming", ["ID"] = 7562, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true and PlayerMP < 70,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
		},
		
	}

	self.SendConsoleMessage(ClassTypeID.."PROFILE END",1)
    return SkillList
end

return Profile