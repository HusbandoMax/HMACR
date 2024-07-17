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

	--[[
		119     Stone                CNJ WHM
		120     Cure                 CNJ WHM
		121     Aero                 CNJ WHM
		124     Medica               CNJ WHM
		125     Raise                CNJ WHM
		127     Stone II             CNJ WHM
		131     Cure III             WHM
		132     Aero II              CNJ WHM
		133     Medica II            CNJ WHM
		135     Cure II              CNJ WHM
		136     Presence of Mind     WHM
		137     Regen                WHM
		139     Holy                 WHM
		140     Benediction          WHM
		3568    Stone III            WHM
		3569    Asylum               WHM
		3570    Tetragrammaton       WHM
		3571    Assize               WHM
		7430    Thin Air             WHM
		7431    Stone IV             WHM
		7432    Divine Benison       WHM
		7433    Plenary Indulgence   WHM
		16531   Afflatus Solace      WHM
		16532   Dia                  WHM
		16533   Glare                WHM
		16534   Afflatus Rapture     WHM
		16535   Afflatus Misery      WHM
		16536   Temperance           WHM
		25859   Glare III            WHM
		25860   Holy III             WHM
		25861   Aquaveil             WHM
		25862   Liturgy of the Bell  WHM
		25863   Liturgy of the Bell  WHM
		25864   Liturgy of the Bell  WHM
		28509   Liturgy of the Bell  WHM
		37008   Aetherial Shift      WHM
		37009   Glare IV             WHM
		37010   Medica III           WHM
		37011   Divine Caress        WHM
	]]--

	local SkillList = {
        {
			["Type"] = 2, ["Name"] = "Holy", ["ID"] = 139, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["OtherCheck"] = PlayerMoving == false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1 and self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 8, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Holy III", ["ID"] = 25860, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["OtherCheck"] = PlayerMoving == false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1 and self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 8, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},

		{
			["Type"] = 2, ["Name"] = "Assize", ["ID"] = 3571, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1 and self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["PartyOnly"] = true, ["OtherCheck"] = PlayerInCombat == true,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 15, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},


		{
			["Type"] = 2, ["Name"] = "Presence of Mind", ["ID"] = 136, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true, ["OtherCheck"] = PlayerInCombat == true,
			["AOECount"] = (PartySize/2), ["AOEType"] = { ["BelowHP"] = 60, ["Filter"] = "PartySelf", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 30, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Temperance", ["ID"] = 16536, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true, ["OtherCheck"] = PlayerInCombat == true,
			["AOECount"] = (PartySize/2), ["AOEType"] = { ["BelowHP"] = 60, ["Filter"] = "PartySelf", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 30, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},

		{
			["Type"] = 2, ["Name"] = "Medica III", ["ID"] = 37010, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true,
			["OtherCheck"] = self.PartyBelowHP(20,80,150,Data.EntityListSorted.PartySelf) >= (PartySize/2) and PlayerInCombat == true and PlayerMoving == false,
		},
		{
			["Type"] = 2, ["Name"] = "Medica II", ["ID"] = 133, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true,
			["OtherCheck"] = self.PartyBelowHP(20,80,150,Data.EntityListSorted.PartySelf) >= (PartySize/2) and PlayerInCombat == true and PlayerMoving == false,
		},
		{
			["Type"] = 2, ["Name"] = "Medica", ["ID"] = 124, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true,
			["OtherCheck"] = self.PartyBelowHP(15,80,nil,Data.EntityListSorted.PartySelf) >= (PartySize/2) and PlayerInCombat == true and PlayerMoving == false,
		},
		{
			["Type"] = 2, ["Name"] = "Assize", ["ID"] = 3571, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true,
			["OtherCheck"] = self.PartyBelowHP(15,70,nil,Data.EntityListSorted.PartySelf) >= (PartySize/2) and PlayerInCombat == true,
		},
		{
			["Type"] = 2, ["Name"] = "Afflatus Rapture", ["ID"] = 16534, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true,
			["OtherCheck"] = self.PartyBelowHP(20,70,nil,Data.EntityListSorted.PartySelf) >= (PartySize/2) and PlayerInCombat == true,
		},

		{
			["Type"] = 2, ["Name"] = "Thin Air", ["ID"] = 7430, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true and PlayerMP < 30,
		},
		{
			["Type"] = 2, ["Name"] = "Lucid Dreaming", ["ID"] = 7562, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true and PlayerMP < 70,
		},
        
		{
			["Type"] = 3, ["Name"] = "Benediction", ["ID"] = 140, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 15, ["PartyOnly"] = false,
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1,
		},
		{
			["Type"] = 3, ["Name"] = "Tetragrammation", ["ID"] = 3570, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 15, ["PartyOnly"] = false,
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["LastActionTimeout"] = "Tetragrammation", ["LastActionTime"] = 1000,
		},
		{
			["Type"] = 3, ["Name"] = "Afflatus Solace", ["ID"] = 16531, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 50, ["PartyOnly"] = false,
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1,
		},


		{
			["Type"] = 3, ["Name"] = "Cure III", ["ID"] = 131, ["Range"] = 30, ["TargetCast"] = true, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true, ["OtherCheck"] = PlayerMoving == false,
			["AOECount"] = 3, ["AOEType"] = { ["BelowHP"] = 75, ["Filter"] = "PartySelf", ["Name"] = "Circle", ["TargetPoint"] = nil, ["AOERange"] = 10, ["MaxDistance"] = 30, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 3, ["Name"] = "Asylum", ["ID"] = 3569, ["Range"] = 30, ["TargetCast"] = true, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true,
			["AOECount"] = (PartySize/2), ["AOEType"] = { ["BelowHP"] = 75, ["Filter"] = "PartySelf", ["Name"] = "Circle", ["TargetPoint"] = nil, ["AOERange"] = 10, ["MaxDistance"] = 30, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 3, ["Name"] = "Liturgy of the Bell", ["ID"] = 25862, ["Range"] = 30, ["TargetCast"] = true, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["PartyOnly"] = true,
			["AOECount"] = (PartySize/2), ["AOEType"] = { ["BelowHP"] = 60, ["Filter"] = "PartySelf", ["Name"] = "Circle", ["TargetPoint"] = nil, ["AOERange"] = 10, ["MaxDistance"] = 30, ["LineWidth"] = 0, ["Angle"] = 0, },
		},


		{
			["Type"] = 3, ["Name"] = "Aquaveil", ["ID"] = 25861, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 70, ["PartyOnly"] = true, ["RequiredClassType"] = 1,
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["OtherCheck"] = PlayerInCombat == true,
		},
		{
			["Type"] = 3, ["Name"] = "Aquaveil", ["ID"] = 25861, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 40, ["PartyOnly"] = true,
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["OtherCheck"] = PlayerInCombat == true,
		},
		{
			["Type"] = 3, ["Name"] = "Cure II", ["ID"] = 135, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 60, ["PartyOnly"] = false, ["OtherCheck"] = PlayerMoving == false,
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1,
		},
	

		{
			["Type"] = 3, ["Name"] = "Esuna", ["ID"] = 7568, ["Range"] = 30, ["TargetCast"] = true, ["PartyOnly"] = false, ["Dispellable"] = true, ["OtherCheck"] = PlayerMoving == false,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Esuna") == 1,
		},

		{
			["Type"] = 3, ["Name"] = "Cure II", ["ID"] = 135, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 70, ["PartyOnly"] = false, ["OtherCheck"] = PlayerMoving == false,
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1,
		},
		{
			["Type"] = 3, ["Name"] = "Cure", ["ID"] = 120, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 80, ["PartyOnly"] = false, ["OtherCheck"] = PlayerMoving == false,
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1,
		},
		{
			["Type"] = 3, ["Name"] = "Regen", ["ID"] = 137, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 95, ["HPAbove"] = 85, ["PartyOnly"] = true,
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1, ["Buff2"] = { ["Target"] = nil, ["BuffID"] = {158}, ["Time"] = -1, ["Type"] = "Missing", ["Owner"] = PlayerID, ["StackSize"] = nil, }
		},
		{
			["Type"] = 3, ["Name"] = "Divine Benison", ["ID"] = 7432, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 80, ["PartyOnly"] = true, ["RequiredClassType"] = 1, ["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Heals") == 1,
			["Buff2"] = { ["Target"] = nil, ["BuffID"] = {1218}, ["Time"] = -1, ["Type"] = "Missing", ["Owner"] = PlayerID, ["StackSize"] = nil, }
		},

		{
			["Type"] = 1, ["Name"] = "Afflatus Misery", ["ID"] = 16535, ["Range"] = 25, ["TargetCast"] = true, ["AOECount"] = 4, ["OtherCheck"] = PlayerInCombat == true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1,
			["AOECount"] = 4, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 1, ["Name"] = "Dia", ["ID"] = 16532, ["Range"] = 25, ["TargetCast"] = true, ["DOTCheck"] = true,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, ["Buff"] = self.TargetBuff2(Target,1871,3,"Missing",PlayerID) == true,
		},
		{
			["Type"] = 1, ["Name"] = "Aero II", ["ID"] = 132, ["Range"] = 25, ["TargetCast"] = true, ["DOTCheck"] = true,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, ["Buff"] = self.TargetBuff2(Target,144,3,"Missing",PlayerID) == true,
		},
		{
			["Type"] = 1, ["Name"] = "Aero", ["ID"] = 121, ["Range"] = 25, ["TargetCast"] = true, ["DOTCheck"] = true,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1, ["Buff"] = self.TargetBuff2(Target,143,3,"Missing",PlayerID) == true,
		},
		{
			["Type"] = 1, ["Name"] = "Glare IV", ["ID"] = 37009, ["Proc"] = true, ["Range"] = 25, ["TargetCast"] = true,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1 and AOETimeout == false,
		},
		{
			["Type"] = 1, ["Name"] = "Glare III", ["ID"] = 25859, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = PlayerMoving == false,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Glare", ["ID"] = 16533, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = PlayerMoving == false,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Stone IV", ["ID"] = 7431, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = PlayerMoving == false,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1,
		},
		{ 
			["Type"] = 1, ["Name"] = "Stone III", ["ID"] = 3568, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = PlayerMoving == false,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1,
		},

		{
			["Type"] = 1, ["Name"] = "Stone II", ["ID"] = 127, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = PlayerMoving == false,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Stone", ["ID"] = 119, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = PlayerMoving == false,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DPS") == 1,
		},
	}

	self.SendConsoleMessage(ClassTypeID.."PROFILE END",1)
    return SkillList
end

return Profile