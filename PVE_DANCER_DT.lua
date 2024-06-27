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
        ["Setting"] = "Partner",
        ["Options"] = {
            { ["Name"] = "Partner", ["Tooltip"] = "Dance Partner Auto", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Partner", ["Tooltip"] = "Dance Partner OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "Standard",
        ["Options"] = {
            { ["Name"] = "Standard", ["Tooltip"] = "Standard Step ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Standard", ["Tooltip"] = "Standard Step OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "Technical",
        ["Options"] = {
            { ["Name"] = "Technical", ["Tooltip"] = "Technical Step ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Technical", ["Tooltip"] = "Technical Step OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
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
    local AOETimeout = Data.AOETimeout
    local JumpTimeout = Data.JumpTimeout
    local CastTimeout = Data.CastTimeout

	local HasDancePartnerBuff = self.TargetBuff2(Player,1823,0,"Has",PlayerID)

	-- Standard
	-----------
	--[[
	Order = 3,4,5,6
	7 = Current Step
	8 = Fans
	Red = 1
	Blue = 2
	Green = 3
	Yellow = 4
	]]--

	--[[
		15989	Cascade
		15990	Fountain
		15991	Reverse Cascade
		15992	Fountainfall
		15993	Windmill
		15994	Bladeshower
		15995	Rising Windmill
		15996	Bloodshower
		15997	Standard Step
		15998	Technical Step
		15999	Emboite
		16000	Entrechat
		16001	Jete
		16002	Pirouette
		16003	Standard Finish
		16004	Technical Finish
		16005	Saber Dance
		16006	Closed Position
		16007	Fan Dance
		16008	Fan Dance II
		16009	Fan Dance III
		16010	En Avant
		16011	Devilment
		16012	Shield Samba
		16013	Flourish
		16014	Improvisation
		16015	Curing Waltz
		16191	Single Standard Finish
		16192	Double Standard Finish
		16193	Single Technical Finish
		16194	Double Technical Finish
		16195	Triple Technical Finish
		16196	Quadruple Technical Finish
		18073	Ending
		25789	Improvised Finish
		25790	Tillana
		25791	Fan Dance IV
		25792	Starfall Dance
		33215	Single Technical Finish
		33216	Double Technical Finish
		33217	Triple Technical Finish
		33218	Quadruple Technical Finish
		36983	Last Dance
		36984	Finishing Move
		36985	Dance of the Dawn
	]]--

	local SkillList = {
        {
			["Type"] = 2, ["Name"] = "Tillana", ["ID"] = 25790, ["Range"] = 25, ["TargetCast"] = false, ["AOECount"] = 1, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, ["LineWidth"] = 25, ["Angle"] = 180, },
		},

		{
			["Type"] = 2, ["Name"] = "Emboite", ["ID"] = 15999, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["OtherCheck"] = PlayerInCombat == true and GaugeData1[3] ~= 0 and GaugeData1[3+GaugeData1[7]] == 1 and GaugeData1[7] ~= 4,
		},
		{
			["Type"] = 2, ["Name"] = "Entrechat", ["ID"] = 16000, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["OtherCheck"] = PlayerInCombat == true and GaugeData1[3] ~= 0 and GaugeData1[3+GaugeData1[7]] == 2 and GaugeData1[7] ~= 4,
		},
		{
			["Type"] = 2, ["Name"] = "Jete", ["ID"] = 16001, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["OtherCheck"] = PlayerInCombat == true and GaugeData1[3] ~= 0 and GaugeData1[3+GaugeData1[7]] == 3 and GaugeData1[7] ~= 4,
		},
		{
			["Type"] = 2, ["Name"] = "Pirouette", ["ID"] = 16002, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["OtherCheck"] = PlayerInCombat == true and GaugeData1[3] ~= 0 and GaugeData1[3+GaugeData1[7]] == 4 and GaugeData1[7] ~= 4,
		},

		{
			["Type"] = 2, ["Name"] = "Double Standard Finish", ["ID"] = 16192, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["OtherCheck"] = PlayerInCombat == true and GaugeData1[7] == 2, ["Buff"] = self.TargetBuff2(Player,1818,0,"Has",PlayerID),
			["AOECount"] = 1, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 15, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},

		{
			["Type"] = 2, ["Name"] = "Quadruple Technical Finish", ["ID"] = 16196, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["OtherCheck"] = PlayerInCombat == true and GaugeData1[7] == 4, ["Buff"] = self.TargetBuff2(Player,1819,0,"Has",PlayerID),
			["AOECount"] = 1, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 15, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},


		-- Fans
		{
			["Type"] = 2, ["Name"] = "Fan Dance II", ["ID"] = 16008, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 2, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},

		-- Steps
		{
			["Type"] = 2, ["Name"] = "Standard Step", ["ID"] = 15997, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Standard") == 1, ["OtherCheck"] = PlayerInCombat == true and GaugeData1[3] == 0, ["LastActionTimeout"] = "DancerSteps", ["LastActionTime"] = 2000,
			["AOECount"] = 1, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 15, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Technical Step", ["ID"] = 15998, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Technical") == 1, ["OtherCheck"] = PlayerInCombat == true and GaugeData1[3] == 0, ["LastActionTimeout"] = "DancerSteps", ["LastActionTime"] = 2000,
			["AOECount"] = 1, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 15, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},

		-- AOE Combo
		{
			["Type"] = 2, ["Name"] = "Rising Windmill", ["ID"] = 15995, ["Range"] = 0, ["TargetCast"] = false,["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Bloodshower", ["ID"] = 15996, ["Range"] = 0, ["TargetCast"] = false,["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},

		{
			["Type"] = 2, ["Name"] = "Windmill", ["ID"] = 15993, ["Range"] = 0, ["TargetCast"] = false, ["ComboID"] = { [0] = true, [15993] = PlayerLevel < 25, [15994] = true, [15989] = true, [15990] = true, },["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 2, ["Name"] = "Bladeshower", ["ID"] = 15994, ["Range"] = 0, ["TargetCast"] = false, ["ComboID"] = { [15993] = true, [15989] = true, [15990] = true, },["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, },
		},


		{
			["Type"] = 2, ["Name"] = "Peloton", ["ID"] = 7557, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Peloton") == 1, ["OtherCheck"] = PlayerMoving == true and PlayerInCombat == false, ["Buff"] = self.TargetBuff2(Player,1199,3,"Missing") == true,
		},
        
        
		{
			["Type"] = 1, ["Name"] = "Saber Dance", ["ID"] = 16005, ["Range"] = 25, ["TargetCast"] = true, ["AOECount"] = 2, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, ["LineWidth"] = 25, ["Angle"] = 180, },
		},
		{
			["Type"] = 1, ["Name"] = "Starfall Dance", ["ID"] = 25792, ["Range"] = 25, ["TargetCast"] = true, ["AOECount"] = 1, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Line", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 25, ["MaxDistance"] = 25, ["LineWidth"] = 4, ["Angle"] = 180, },
		},
		-- Fans
		{
			["Type"] = 1, ["Name"] = "Fan Dance IV", ["ID"] = 25791, ["Range"] = 15, ["TargetCast"] = true, ["AOECount"] = 1, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Cone", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 15, ["MaxDistance"] = 15, ["LineWidth"] = 0, ["Angle"] = 180, },
		},
		{
			["Type"] = 1, ["Name"] = "Fan Dance III", ["ID"] = 16009, ["Range"] = 25, ["TargetCast"] = true, ["AOECount"] = 1, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 1, ["Name"] = "Fan Dance", ["ID"] = 16007, ["Range"] = 25, ["TargetCast"] = true,
		},

		-- Single Target Combo
		{
			["Type"] = 1, ["Name"] = "Reverse Cascade", ["ID"] = 15991, ["Range"] = 25, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Fountainfall", ["ID"] = 15992, ["Range"] = 25, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Cascade", ["ID"] = 15989, ["Range"] = 25, ["TargetCast"] = true, ["ComboID"] = { [0] = true, [15989] = PlayerLevel < 2, [15990] = true, [15993] = true, [15994] = true,},
		},
		{
			["Type"] = 1, ["Name"] = "Fountain", ["ID"] = 15990, ["Range"] = 25, ["TargetCast"] = true, ["ComboID"] = { [15989] = true, [15993] = true, [15994] = true,},
		},


		{
			["Type"] = 1, ["Name"] = "Flourish", ["ID"] = 16013, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerInCombat == true,
		},
		{
			["Type"] = 1, ["Name"] = "Devilment", ["ID"] = 16011, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = PlayerInCombat == true,
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
    
	if self.GetSettingsValue(ClassTypeID,"Partner") == 1 then
		if HasDancePartnerBuff == false then
			for i,e in pairs(Data.EntityListSorted.Party) do
				--d(e.name)
				--d(HusbandoMax.API.ClassType[e.job])
				if HusbandoMax.API.ClassType[e.job].Type == 2 and self.TargetBuff(e,1824,-1) == false then
					local ClosedPosition = ActionList:Get(1,16006)
					if (ClosedPosition and ClosedPosition:IsReady(e.id)) then
						ClosedPosition:Cast(e.id)
						self.SendConsoleMessage("Casting Closed Position On: "..e.name,2)
						return true
					end
					break
				end
			end
		end
	end

	self.SendConsoleMessage(ClassTypeID.."PROFILE END",1)
    return SkillList
end

return Profile