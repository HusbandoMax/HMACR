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
        ["Setting"] = "Meditation",
        ["Options"] = {
            { ["Name"] = "Meditation", ["Tooltip"] = "Meditation ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Meditation", ["Tooltip"] = "Meditation OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
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

	--local HasKardiaBuff = false
	local CurrentForm = 1
	for i,e in pairs(Player.buffs) do
		local BuffID = e.id
		if e.ownerid == PlayerID then
			if BuffID == 108 then -- Raptor
                CurrentForm = 2
            elseif BuffID == 109 then -- Coeurl
                CurrentForm = 3
            elseif BuffID == 107 then -- Opo-opo
                CurrentForm = 4
            elseif BuffID == 2513 then -- Formless Fist
                CurrentForm = 5
            elseif BuffID == 110 then -- Perfect Balance
                CurrentForm = 6
            end
		end
	end

	self.SendConsoleMessage("CurrentForm: "..tostring(CurrentForm),3)

	local SkillList = {
		{
			["Type"] = 2, ["Name"] = "Meditation", ["ID"] = 3546, ["Range"] = 10, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Meditation") == 1, ["OtherCheck"] = PlayerInCombat == false,
		},
		-- Opo-opo
		{
			["Type"] = 2, ["Name"] = "Shadow of the Destroyer", ["ID"] = 25767, ["Range"] = 3, ["Level"] = PlayerLevel >= 82, ["TargetCast"] = false, ["OtherCheck"] = (CurrentForm == 4 or CurrentForm == 5) or (CurrentForm == 6 and GaugeData1[5] == 2 and GaugeData1[6] == 0 and GaugeData1[2] ~= 3 and GaugeData1[3] ~= 3 and GaugeData1[4] ~= 3), ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 160, },
		},
		-- Coeurl
		{
			["Type"] = 2, ["Name"] = "Rockbreaker", ["ID"] = 70, ["Range"] = 3, ["Level"] = PlayerLevel >= 30, ["TargetCast"] = false, ["OtherCheck"] = (CurrentForm == 3 or CurrentForm == 5) or (CurrentForm == 6 and GaugeData1[5] == 2 and GaugeData1[6] == 0 and GaugeData1[2] ~= 1 and GaugeData1[3] ~= 1 and GaugeData1[4] ~= 1), ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 160, },
		},
		-- Raptor
		{
			["Type"] = 2, ["Name"] = "Four-point Fury", ["ID"] = 16473, ["Range"] = 3, ["Level"] = PlayerLevel >= 45, ["TargetCast"] = false, ["OtherCheck"] = (CurrentForm == 2 or CurrentForm == 5) or (CurrentForm == 6 and GaugeData1[5] == 2 and GaugeData1[6] == 0 and GaugeData1[2] ~= 2 and GaugeData1[3] ~= 2 and GaugeData1[4] ~= 2), ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 160, },
		},
		{
			["Type"] = 2, ["Name"] = "Shadow of the Destroyer", ["ID"] = 25767, ["Range"] = 3, ["Level"] = PlayerLevel >= 82, ["TargetCast"] = false, ["OtherCheck"] = CurrentForm == 1, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false,
			["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 160, },
		},
		-- Disciplined Fist 3001
		-- Leaden Fist 1861
		-- Demolish 246
		-- if BuffID == 108 then CurrentForm = 2 end -- Raptor
		-- if BuffID == 109 then CurrentForm = 3 end -- Coeurl
		-- if BuffID == 107 then CurrentForm = 4 end -- Opo-opo
		-- if BuffID == 2513 then CurrentForm = 5 end -- Formless Fist
		-- if BuffID == 210 then CurrentForm = 6 end -- Perfect Balance

		{
			["Type"] = 1, ["Name"] = "Howling Fist", ["ID"] = 25763, ["Range"] = 10, ["TargetCast"] = true,  ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["Level"] = self.SkillAccessCheck(25763,16474,PlayerLevel),
			["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Line", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 10, ["MaxDistance"] = 10, ["LineWidth"] = 2, ["Angle"] = 160, },
		},
		{
			["Type"] = 1, ["Name"] = "Enlightenment", ["ID"] = 16474, ["Range"] = 10, ["TargetCast"] = true,  ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["Level"] = self.SkillAccessCheck(16474,nil,PlayerLevel),
			["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Line", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 10, ["MaxDistance"] = 10, ["LineWidth"] = 2, ["Angle"] = 160, },
		},
		{
			["Type"] = 1, ["Name"] = "Steel Peak", ["ID"] = 25761, ["Range"] = 3, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25761,3547,PlayerLevel),
		},
		{
			["Type"] = 1, ["Name"] = "The Forbidden Chakra", ["ID"] = 3546, ["Range"] = 3, ["TargetCast"] = true, -- Meditation ID
		},
		{
			["Type"] = 1, ["Name"] = "The Forbidden Chakra", ["ID"] = 3547, ["Range"] = 3, ["TargetCast"] = true,
		},


		--{
		--	["Type"] = 1, ["Name"] = "Perfect Balance", ["ID"] = 69, ["Range"] = 3, ["Level"] = PlayerLevel >= 50, ["TargetCast"] = false, ["OtherCheck"] = CurrentForm ~= 5 and CurrentForm ~= 6,
		--},

		-- Elixir > Lunar
		{
			["Type"] = 1, ["Name"] = "Dragon Kick", ["ID"] = 74, ["Range"] = 3, ["Level"] = PlayerLevel >= 52, ["TargetCast"] = true, ["OtherCheck"] = (CurrentForm == 6 and GaugeData1[5] == 0 and (GaugeData1[2] == 0 or GaugeData1[3] == 0 or GaugeData1[4] == 0)), ["Buff"] = self.TargetBuff2(Player,1861,6,"Missing",PlayerID),
		},
		{
			["Type"] = 1, ["Name"] = "Bootshine", ["ID"] = 53, ["Range"] = 3, ["Level"] = PlayerLevel >= 1, ["TargetCast"] = true, ["OtherCheck"] = (CurrentForm == 6 and GaugeData1[5] == 0 and (GaugeData1[2] == 0 or GaugeData1[3] == 0 or GaugeData1[4] == 0)),
		},

		-- In Correct Form
		{
			["Type"] = 1, ["Name"] = "Dragon Kick", ["ID"] = 74, ["Range"] = 3, ["Level"] = PlayerLevel >= 52, ["TargetCast"] = true, ["OtherCheck"] = (CurrentForm == 4 or CurrentForm == 5) or (CurrentForm == 6 and GaugeData1[5] == 2 and GaugeData1[6] == 0 and GaugeData1[2] ~= 3 and GaugeData1[3] ~= 3 and GaugeData1[4] ~= 3), ["Buff"] = self.TargetBuff2(Player,1861,6,"Missing",PlayerID),
		},
		{
			["Type"] = 1, ["Name"] = "Bootshine", ["ID"] = 53, ["Range"] = 3, ["Level"] = PlayerLevel >= 1, ["TargetCast"] = true, ["OtherCheck"] = (CurrentForm == 4 or CurrentForm == 5) or (CurrentForm == 6 and GaugeData1[5] == 2 and GaugeData1[6] == 0 and GaugeData1[2] ~= 3 and GaugeData1[3] ~= 3 and GaugeData1[4] ~= 3),
		},
		{
			["Type"] = 1, ["Name"] = "Demolish", ["ID"] = 66, ["Range"] = 3, ["Level"] = PlayerLevel >= 30, ["TargetCast"] = true, ["OtherCheck"] = (CurrentForm == 3 or CurrentForm == 5) or (CurrentForm == 6 and GaugeData1[5] == 2 and GaugeData1[6] == 0 and GaugeData1[2] ~= 1 and GaugeData1[3] ~= 1 and GaugeData1[4] ~= 1), ["Buff"] = self.TargetBuff2(Target,246,6,"Missing",PlayerID),
		},
		{
			["Type"] = 1, ["Name"] = "Snap Punch", ["ID"] = 56, ["Range"] = 3, ["Level"] = PlayerLevel >= 6, ["TargetCast"] = true, ["OtherCheck"] = (CurrentForm == 3 or CurrentForm == 5) or (CurrentForm == 6 and GaugeData1[5] == 2 and GaugeData1[6] == 0 and GaugeData1[2] ~= 1 and GaugeData1[3] ~= 1 and GaugeData1[4] ~= 1),
		},
		{
			["Type"] = 1, ["Name"] = "Twin Snakes", ["ID"] = 61, ["Range"] = 3, ["Level"] = PlayerLevel >= 18, ["TargetCast"] = true, ["OtherCheck"] = (CurrentForm == 2 or CurrentForm == 5) or (CurrentForm == 6 and GaugeData1[5] == 2 and GaugeData1[6] == 0 and GaugeData1[2] ~= 2 and GaugeData1[3] ~= 2 and GaugeData1[4] ~= 2), ["Buff"] = self.TargetBuff2(Player,3001,6,"Missing",PlayerID),
		},
		{
			["Type"] = 1, ["Name"] = "True Strike", ["ID"] = 54, ["Range"] = 3, ["Level"] = PlayerLevel >= 4, ["TargetCast"] = true, ["OtherCheck"] = (CurrentForm == 2 or CurrentForm == 5) or (CurrentForm == 6 and GaugeData1[5] == 2 and GaugeData1[6] == 0 and GaugeData1[2] ~= 2 and GaugeData1[3] ~= 2 and GaugeData1[4] ~= 2),
		},
		-- No Form
		{
			["Type"] = 1, ["Name"] = "Form Shift", ["ID"] = 4262, ["Range"] = 3, ["Level"] = PlayerLevel >= 52, ["TargetCast"] = false, ["OtherCheck"] = CurrentForm == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Dragon Kick", ["ID"] = 74, ["Range"] = 3, ["Level"] = PlayerLevel >= 90, ["TargetCast"] = true, ["OtherCheck"] = CurrentForm == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Bootshine", ["ID"] = 53, ["Range"] = 3, ["Level"] = PlayerLevel >= 1, ["TargetCast"] = true, ["OtherCheck"] = CurrentForm == 1,
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