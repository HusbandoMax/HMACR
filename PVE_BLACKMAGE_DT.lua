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
        ["Setting"] = "LeyLines",
        ["Options"] = {
            { ["Name"] = "Ley Lines", ["Tooltip"] = "Ley Lines ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Ley Lines", ["Tooltip"] = "Ley Lines OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
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

    --[[
        GaugeData1 Shit
        [1] = 3 Bliz Umbral Heart Stacks
        [2] =  -3 Bliz Umbral Ice Stacks + Fire Astral Fire Stacks
        [3] = 1 Active Both stances
        [4] = Time
        [5] = 
    ]]
    d(GaugeData1)
    local HasTripleCast = self.TargetBuff2(Player,1211,0,"Has",PlayerID)
    local HasFirestarterCast = self.TargetBuff2(Player,165,0,"Has",PlayerID)
    local HasThundercloudCast = self.TargetBuff2(Player,164,0,"Has",PlayerID)

    --[[
        141     Fire                    THM BLM
        142     Blizzard                THM BLM
        144     Thunder                 THM BLM
        147     Fire II                 THM BLM
        149     Transpose               THM BLM
        152     Fire III                THM BLM
        153     Thunder III             BLM
        154     Blizzard III            BLM
        155     Aetherial Manipulation  THM BLM
        156     Scathe                  THM BLM
        157     Manaward                THM BLM
        158     Manafont                BLM
        159     Freeze                  BLM
        162     Flare                   BLM
        3573    Ley Lines               BLM
        3576    Blizzard IV             BLM
        3577    Fire IV                 BLM
        7419    Between the Lines       BLM
        7420    Thunder IV              BLM
        7421    Triplecast              BLM
        7422    Foul                    BLM
        7447    Thunder II              THM BLM
        16505   Despair                 BLM
        16506   Umbral Soul             BLM
        16507   Xenoglossy              BLM
        25793   Blizzard II             THM BLM
        25794   High Fire II            BLM
        25795   High Blizzard II        BLM
        25796   Amplifier               BLM
        25797   Paradox                 BLM
        36986   High Thunder            BLM
        36987   High Thunder II         BLM
        36988   Retrace                 BLM
        36989   Flare Star              BLM
    ]]

	local SkillList = {
		
        -- OOC Start
        --[[
        Bliz III If < 35 Bliz
        Bliz IV  If < 58 Else Fire III
        ]]--

		{
			["Type"] = 1, ["Name"] = "Despair", ["ID"] = 16505, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(16505,nil,PlayerLevel) == true, 
            ["OtherCheck"] = PlayerMoving == false and PlayerMP < 16, ["GaugeCheck"] = GaugeData1[2] > 0,
		},


        -- Start Bliz
		{
			["Type"] = 1, ["Name"] = "Blizzard II 1", ["ID"] = 25793, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25793,25795,PlayerLevel) == true, 
            ["OtherCheck"] = (PlayerMoving == false or HasTripleCast == true), ["GaugeCheck"] = (GaugeData1[2] == 0 and PlayerMP < 90) or (GaugeData1[2] > 0 and PlayerMP < 16),
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
		},
		{
			["Type"] = 1, ["Name"] = "High Blizzard II 1", ["ID"] = 25795, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25795,nil,PlayerLevel) == true, 
            ["OtherCheck"] = (PlayerMoving == false or HasTripleCast == true), ["GaugeCheck"] = GaugeData1[2] == 0 or (GaugeData1[2] > 0 and PlayerMP < 16),
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
		},
		{
			["Type"] = 1, ["Name"] = "Blizzard 1", ["ID"] = 142, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(142,154,PlayerLevel), 
            ["OtherCheck"] = (PlayerMoving == false or HasTripleCast == true), ["GaugeCheck"] = (GaugeData1[2] == 0 and PlayerMP < 90) or (GaugeData1[2] > 0 and PlayerMP < 16),
		},
		{
			["Type"] = 1, ["Name"] = "Blizzard III 1", ["ID"] = 154, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(154,nil,PlayerLevel), 
            ["OtherCheck"] = (PlayerMoving == false or HasTripleCast == true), ["GaugeCheck"] = GaugeData1[2] == 0 or (GaugeData1[2] > 0 and PlayerMP < 16),
		},
        -- Bliz Build MP
		{
			["Type"] = 1, ["Name"] = "Freeze", ["ID"] = 159, ["Range"] = 25, ["TargetCast"] = true, self.SkillAccessCheck(159,nil,PlayerLevel) == true and self.SkillAccessCheck(3576,nil,PlayerLevel) == false, 
            ["OtherCheck"] = (PlayerMoving == false or HasTripleCast == true), ["GaugeCheck"] = GaugeData1[2] < 0 and GaugeData1[1] == 0,
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
		},
		{
			["Type"] = 1, ["Name"] = "Blizzard II - 2", ["ID"] = 25793, ["Range"] = 25, ["TargetCast"] = true, self.SkillAccessCheck(25793,25795,PlayerLevel) == true and self.SkillAccessCheck(3576,nil,PlayerLevel) == false, 
            ["OtherCheck"] = (PlayerMoving == false or HasTripleCast == true), ["GaugeCheck"] = GaugeData1[2] < 0 and PlayerMP < 90,
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
		},
		{
			["Type"] = 1, ["Name"] = "High Blizzard II - 2", ["ID"] = 25795, ["Range"] = 25, ["TargetCast"] = true, self.SkillAccessCheck(25795,nil,PlayerLevel) == true and self.SkillAccessCheck(3576,nil,PlayerLevel) == false, 
            ["OtherCheck"] = (PlayerMoving == false or HasTripleCast == true), ["GaugeCheck"] = GaugeData1[2] < 0 and PlayerMP < 90,
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
		},
		{
			["Type"] = 1, ["Name"] = "Blizzard - 2", ["ID"] = 142, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(142,154,PlayerLevel), 
            ["OtherCheck"] = (PlayerMoving == false or HasTripleCast == true) and PlayerMP < 90, ["GaugeCheck"] = GaugeData1[2] < 0,
		},
		{
			["Type"] = 1, ["Name"] = "Blizzard III - 2", ["ID"] = 154, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(154,3576,PlayerLevel), 
            ["OtherCheck"] = (PlayerMoving == false or HasTripleCast == true) and PlayerMP < 90, ["GaugeCheck"] = GaugeData1[2] < 0,
		},
		{
			["Type"] = 1, ["Name"] = "Blizzard IV", ["ID"] = 3576, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(3576,nil,PlayerLevel), 
            ["OtherCheck"] = (PlayerMoving == false or HasTripleCast == true), ["GaugeCheck"] = GaugeData1[2] < 0 and GaugeData1[1] == 0,
		},
		{
			["Type"] = 1, ["Name"] = "Paradox", ["ID"] = 25797, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25797,nil,PlayerLevel), 
            ["OtherCheck"] = (PlayerMoving == false or HasTripleCast == true), ["GaugeCheck"] = GaugeData1[2] < 0 and GaugeData1[1] == 3,
		},
        
        -- Dots
		{
			["Type"] = 1, ["Name"] = "Thunder IV", ["ID"] = 7420, ["Range"] = 25, ["TargetCast"] = true, ["Buff"] = (self.EnemyWithBuff2(TargetPOS,5,{161,162,163,1210},4,"Missing",PlayerID) > 1),
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false and self.GetSettingsValue(ClassTypeID,"DOTs") == 1, ["Level"] = self.SkillAccessCheck(7420,nil,PlayerLevel), 
            ["LastActionTimeout"] = "BLMThunder", ["LastActionTime"] = 3500, ["GaugeCheck"] = GaugeData1[2] > 0, ["OtherCheck"] = (PlayerMoving == false or HasThundercloudCast == true),
		},
		{
			["Type"] = 1, ["Name"] = "Thunder", ["ID"] = 144, ["Range"] = 25, ["TargetCast"] = true, ["Buff"] = self.TargetBuff2(Target,{161,162,163,1210},6,"Missing",PlayerID),
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DOTs") == 1, ["DOTCheck"] = true, ["Level"] = self.SkillAccessCheck(144,nil,PlayerLevel), 
            ["LastActionTimeout"] = "BLMThunder", ["LastActionTime"] = 3500, ["GaugeCheck"] = GaugeData1[2] > 0, ["OtherCheck"] = (PlayerMoving == false or HasThundercloudCast == true),
		},
		{
			["Type"] = 1, ["Name"] = "Thunder II", ["ID"] = 7447, ["Range"] = 25, ["TargetCast"] = true, ["Buff"] = self.TargetBuff2(Target,{161,162,163,1210},6,"Missing",PlayerID),
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DOTs") == 1, ["DOTCheck"] = true, ["Level"] = self.SkillAccessCheck(7447,nil,PlayerLevel), 
            ["LastActionTimeout"] = "BLMThunder", ["LastActionTime"] = 3500, ["GaugeCheck"] = GaugeData1[2] > 0, ["OtherCheck"] = (PlayerMoving == false or HasThundercloudCast == true),
		},
		{
			["Type"] = 1, ["Name"] = "Thunder III", ["ID"] = 153, ["Range"] = 25, ["TargetCast"] = true, ["Buff"] = self.TargetBuff2(Target,{161,162,163,1210},6,"Missing",PlayerID),
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"DOTs") == 1, ["DOTCheck"] = true, ["Level"] = self.SkillAccessCheck(153,nil,PlayerLevel), 
            ["LastActionTimeout"] = "BLMThunder", ["LastActionTime"] = 3500, ["GaugeCheck"] = GaugeData1[2] > 0, ["OtherCheck"] = (PlayerMoving == false or HasThundercloudCast == true),
		},


        -- Fire Swap
		{
			["Type"] = 1, ["Name"] = "Fire II - 1", ["ID"] = 147, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(147,25794,PlayerLevel) == true, 
            ["OtherCheck"] = (PlayerMoving == false or HasTripleCast == true) and PlayerMP == 100, ["GaugeCheck"] = GaugeData1[2] <= 0 and (GaugeData1[1] == 3 or (self.SkillAccessCheck(3576,nil,PlayerLevel) == false and PlayerMP == 100)),
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
		},
		{
			["Type"] = 1, ["Name"] = "High Fire II - 1", ["ID"] = 25794, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25794,nil,PlayerLevel) == true, 
            ["OtherCheck"] = (PlayerMoving == false or HasTripleCast == true) and PlayerMP == 100, ["GaugeCheck"] = GaugeData1[2] < 0 and (GaugeData1[1] == 3 or (self.SkillAccessCheck(3576,nil,PlayerLevel) == false and PlayerMP == 100)),
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
		},
		{
			["Type"] = 1, ["Name"] = "Fire III - 1", ["ID"] = 152, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(152,nil,PlayerLevel), 
            ["OtherCheck"] = (PlayerMoving == false or HasTripleCast == true or HasFirestarterCast == true) and PlayerMP == 100, ["GaugeCheck"] = GaugeData1[2] < 0 and (GaugeData1[1] == 3 or (self.SkillAccessCheck(3576,nil,PlayerLevel) == false and PlayerMP == 100)),
		},
		{
			["Type"] = 1, ["Name"] = "Fire - 1", ["ID"] = 141, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(141,152,PlayerLevel) and self.SkillAccessCheck(3576,nil,PlayerLevel) == false, 
            ["OtherCheck"] = (PlayerMoving == false or HasTripleCast == true) and PlayerMP == 100, ["GaugeCheck"] = GaugeData1[2] <= 0,
		},
		{
			["Type"] = 1, ["Name"] = "Fire III - 2", ["ID"] = 152, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(152,nil,PlayerLevel) and self.SkillAccessCheck(3576,nil,PlayerLevel) == false, 
            ["OtherCheck"] = (PlayerMoving == false or HasTripleCast == true or HasFirestarterCast == true) and PlayerMP == 100, ["GaugeCheck"] = GaugeData1[2] < 0,
		},

        -- Fire Burn
		{
			["Type"] = 1, ["Name"] = "Fire II - 2", ["ID"] = 147, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(147,25794,PlayerLevel) == true, 
            ["OtherCheck"] = (PlayerMoving == false or HasTripleCast == true), ["GaugeCheck"] = GaugeData1[2] > 0,
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
		},
		{
			["Type"] = 1, ["Name"] = "High Fire II - 2", ["ID"] = 25794, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25794,nil,PlayerLevel) == true, 
            ["OtherCheck"] = (PlayerMoving == false or HasTripleCast == true), ["GaugeCheck"] = GaugeData1[2] > 0,
            ["AOECount"] = 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
		},
		{
			["Type"] = 1, ["Name"] = "Fire - 2", ["ID"] = 141, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(141,152,PlayerLevel), 
            ["OtherCheck"] = (PlayerMoving == false or HasTripleCast == true), ["GaugeCheck"] = GaugeData1[2] > 0,
		},
		{
			["Type"] = 1, ["Name"] = "Foul", ["ID"] = 7422, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(7422,nil,PlayerLevel), ["GaugeCheck"] = GaugeData1[2] > 0,
            ["AOECount"] = 2, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 25, },
		},
		{
			["Type"] = 1, ["Name"] = "Xenoglossy", ["ID"] = 16507, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(16507,nil,PlayerLevel), 
            ["GaugeCheck"] = GaugeData1[2] > 0,
		},

		{
			["Type"] = 1, ["Name"] = "Fire IV", ["ID"] = 3577, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(3577,nil,PlayerLevel), 
            ["OtherCheck"] = PlayerMoving == false, ["GaugeCheck"] = GaugeData1[2] > 0,
		},
        -- Fire Time Reset
		{
			["Type"] = 1, ["Name"] = "Fire - 3", ["ID"] = 141, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25797,nil,PlayerLevel) == false, 
            ["OtherCheck"] = PlayerMoving == false, ["GaugeCheck"] = GaugeData1[2] > 0,
		},
		{
			["Type"] = 1, ["Name"] = "Paradox", ["ID"] = 25797, ["Range"] = 25, ["TargetCast"] = true, ["Level"] = self.SkillAccessCheck(25797,nil,PlayerLevel) == true, 
            ["OtherCheck"] = PlayerMoving == false, ["GaugeCheck"] = GaugeData1[2] > 0,
		},

		{
			["Type"] = 1, ["Name"] = "Scathe", ["ID"] = 156, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = PlayerMoving == true and HasTripleCast == false,
		},

		{
			["Type"] = 2, ["Name"] = "Sharpcast", ["ID"] = 3574, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = TargetID ~= 0 and PlayerInCombat == true and GaugeData1[2] > 0 and HasThundercloudCast == false and HasFirestarterCast == false,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["LastActionTimeout"] = "BLMSharpcast", ["LastActionTime"] = 3000,
		},
        {
			["Type"] = 2, ["Name"] = "Manafont", ["ID"] = 158, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = TargetID ~= 0 and PlayerInCombat == true and GaugeData1[2] > 0 and PlayerMP < 50,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
		},
		{
			["Type"] = 2, ["Name"] = "Manaward", ["ID"] = 157, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = TargetID ~= 0 and PlayerInCombat == true and PlayerHP < 40,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
		},
		{
			["Type"] = 2, ["Name"] = "Amplifier", ["ID"] = 25796, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = TargetID ~= 0 and PlayerInCombat == true and GaugeData1[5] == 0,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
		},
		{
			["Type"] = 2, ["Name"] = "Triplecast", ["ID"] = 7421, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = TargetID ~= 0 and PlayerInCombat == true and HasTripleCast == false and PlayerMoving == true,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["LastActionTimeout"] = "BLMTriplecast", ["LastActionTime"] = 3000,
		},

		{
			["Type"] = 2, ["Name"] = "Ley Lines", ["ID"] = 3573, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = TargetID ~= 0 and PlayerInCombat == true and PlayerMoving == false,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"LeyLines") == 1,
		},

		{
			["Type"] = 2, ["Name"] = "Umbral Soul", ["ID"] = 16506, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = TargetID == 0 and PlayerInCombat == true and PlayerMoving == false,
            ["GaugeCheck"] = GaugeData1[2] < 0 and GaugeData1[1] < 3,
		},

        {
			["Type"] = 1, ["Name"] = "Addle", ["ID"] = 7560, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = PlayerInCombat == true, 
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
        },

        {
			["Type"] = 2, ["Name"] = "Lucid Dreaming", ["ID"] = 7562, ["Range"] = 25, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true and PlayerMP < 70, 
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1,
        },
	}

	self.SendConsoleMessage(ClassTypeID.."PROFILE END",1)
    return SkillList
end

return Profile