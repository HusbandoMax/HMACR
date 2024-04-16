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
        ["Setting"] = "CDs",
        ["Options"] = {
            { ["Name"] = "CDs", ["Tooltip"] = "CDs ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "CDs", ["Tooltip"] = "CDs OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "Peloton",
        ["Options"] = {
            { ["Name"] = "Peloton", ["Tooltip"] = "Peloton ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Peloton", ["Tooltip"] = "Peloton OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "Interrupts",
        ["Options"] = {
            { ["Name"] = "Interrupts", ["Tooltip"] = "Interrupts On", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Interrupts", ["Tooltip"] = "Interrupts Off", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
}

function Profile:SkillTable(Data,Target,ClassTypeID)
	self.SendConsoleMessage(ClassTypeID.."PROFILE",1)

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
    local LastCastTime = Data.LastCastTime
    local LastCombo = Data.LastCombo
    local CurrentChannel = Data.CurrentChannel
    local GaugeData1 = Data.GaugeData1
    local GaugeData2 = Data.GaugeData2

	local HasReassembleBuff = self.TargetBuff2(Player,851,0,"Has",PlayerID)
	local HasFlamethrowerBuff = self.TargetBuff2(Player,1205,0,"Has",PlayerID)

	local ImportantOGCDClose = false
	local Drill = ActionList:Get(1,16498) -- Drill
	if Drill.usable == true and (Drill.isoncd == false or (Drill.isoncd == true and Drill.cdmax - Drill.cd < 8)) then ImportantOGCDClose = true end
	local AirAnchor = ActionList:Get(1,16500) -- Air Anchor
	if AirAnchor.usable == true and (AirAnchor.isoncd == false or (AirAnchor.isoncd == true and AirAnchor.cdmax - AirAnchor.cd < 8)) then ImportantOGCDClose = true end
	local Chainsaw = ActionList:Get(1,25788) -- Chainsaw
	if Chainsaw.usable == true and (Chainsaw.isoncd == false or (Chainsaw.isoncd == true and Chainsaw.cdmax - Chainsaw.cd < 8)) then ImportantOGCDClose = true end
	local Bioblaster = ActionList:Get(1,16499) -- Bioblaster
	if Bioblaster.usable == true and (Bioblaster.isoncd == false or (Bioblaster.isoncd == true and Bioblaster.cdmax - Bioblaster.cd < 8)) then ImportantOGCDClose = true end
	local Hotshot = ActionList:Get(1,2878) -- Hotshot
	if Hotshot.usable == true and PlayerLevel < 58 and (Hotshot.isoncd == false or (Hotshot.isoncd == true and Hotshot.cdmax - Hotshot.cd < 8)) then ImportantOGCDClose = true end

	self.SendConsoleMessage("ImportantOGCDClose: "..tostring(ImportantOGCDClose),3)

	local OGCDTime = ActionList:Get(1,2866).cd
	self.SendConsoleMessage("OGCDTime: "..tostring(OGCDTime),3)

	local SkillList = {
		{
			["Type"] = 2, ["Name"] = "Flamethrower", ["ID"] = 7418, ["Range"] = 25, ["TargetCast"] = false, ["Buff"] = HasReassembleBuff == false and LastCast ~= 2876 and CurrentCast ~= 2876, ["OtherCheck"] = PlayerMoving == false and PlayerInCombat == true and GaugeData1[3] == 0 and GaugeData1[1] < 40, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and self.AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Cone", ["TargetPoint"] = Player.pos, ["AOERange"] = 12, ["MaxDistance"] = 12, ["Angle"] = 90, },
		},
		{
			["Type"] = 2, ["Name"] = "Peloton", ["ID"] = 7557, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Peloton") == 1, ["OtherCheck"] = PlayerMoving == true and Player.incombat == false, ["Buff"] = self.TargetBuff2(Player,1199,3,"Missing") == true,
		},

		{
			["Type"] = 1, ["Name"] = "Wildfire", ["ID"] = 2878, ["Range"] = 25, ["TargetCast"] = true, ["Charges"] = 0, ["OtherCheck"] = (GaugeData1[1] >= 50 or GaugeData1[3] > 7000) and ImportantOGCDClose == false,
		},

		{
			["Type"] = 1, ["Name"] = "Hypercharge", ["ID"] = 17209, ["Range"] = 25, ["TargetCast"] = false, ["OGCDLimited"] = OGCDTime ~= 0 and OGCDTime < 1.8, ["OtherCheck"] = GaugeData1[1] >= 50 and ImportantOGCDClose == false,
		},
		{
			["Type"] = 1, ["Name"] = "Automaton Queen", ["ID"] = 16501, ["Range"] = 25, ["TargetCast"] = false,
		},
		--{ Auto Use At Timer Maybe Setting For Low HP?
		--	["Type"] = 1, ["Name"] = "Queen Overdrive", ["ID"] = 16502, ["Range"] = 25, ["TargetCast"] = false, ["OtherCheck"] = GaugeData1[3] < 1000,
		--},

		-- Big PP Attacks

		-- Low Level Burn
		{
			["Type"] = 1, ["Name"] = "Hotshot", ["ID"] = 2878, ["Range"] = 25, ["Level"] = PlayerLevel >= 4 and PlayerLevel < 10, ["TargetCast"] = true, ["OtherCheck"] = GaugeData1[3] == 0,
		},
		-- Low Level Hotshot
		{
			["Type"] = 1, ["Name"] = "Reassemble", ["ID"] = 2876, ["Range"] = 25, ["Level"] = PlayerLevel >= 10 and PlayerLevel < 58, ["TargetCast"] = false, ["OGCDLimited"] = OGCDTime > 1.73, ["OtherActionCooldownCheck"] = { ["ID"] = 2878, ["Time"] = 4, }, ["OtherCheck"] = GaugeData1[3] == 0 and LastCast ~= 2876 and CurrentCast ~= 2876,
		},
		{
			["Type"] = 1, ["Name"] = "Hotshot", ["ID"] = 2878, ["Range"] = 25, ["Level"] = PlayerLevel >= 10 and PlayerLevel < 58, ["TargetCast"] = true, ["Buff"] = HasReassembleBuff, ["OtherCheck"] = GaugeData1[3] == 0,
		},
		-- Mid Level Drill
		{
			["Type"] = 1, ["Name"] = "Reassemble", ["ID"] = 2876, ["Range"] = 25, ["Level"] = PlayerLevel >= 58 and PlayerLevel < 76, ["TargetCast"] = false, ["OGCDLimited"] = OGCDTime > 1.73, ["OtherActionCooldownCheck"] = { ["ID"] = 16498, ["Time"] = 4, }, ["OtherCheck"] = GaugeData1[3] == 0 and LastCast ~= 2876 and CurrentCast ~= 2876,
		},
		{
			["Type"] = 1, ["Name"] = "Drill", ["ID"] = 16498, ["Range"] = 25, ["Level"] = PlayerLevel >= 58 and PlayerLevel < 76, ["TargetCast"] = true, ["Buff"] = HasReassembleBuff, ["OtherCheck"] = GaugeData1[3] == 0,
		},
		{
			["Type"] = 1, ["Name"] = "Drill", ["ID"] = 16498, ["Range"] = 25, ["Level"] = PlayerLevel >= 58 and PlayerLevel < 76, ["TargetCast"] = true, ["Buff"] = HasReassembleBuff == false and LastCast ~= 2876 and CurrentCast ~= 2876, ["OtherActionCooldownCheck2"] = { ["ID"] = 2876, ["Time"] = 22, },
		},
		-- High Level Air Anchor
		{
			["Type"] = 1, ["Name"] = "Reassemble", ["ID"] = 2876, ["Range"] = 25, ["Level"] = PlayerLevel >= 76 and PlayerLevel < 90, ["TargetCast"] = false, ["OGCDLimited"] = OGCDTime > 1.73, ["OtherActionCooldownCheck"] = { ["ID"] = 16500, ["Time"] = 4, }, ["OtherCheck"] = GaugeData1[3] == 0 and LastCast ~= 2876 and CurrentCast ~= 2876,
		},
		{
			["Type"] = 1, ["Name"] = "Air Anchor", ["ID"] = 16500, ["Range"] = 25, ["Level"] = PlayerLevel >= 76 and PlayerLevel < 90, ["TargetCast"] = true, ["Buff"] = HasReassembleBuff, ["OtherCheck"] = GaugeData1[3] == 0,
		},
		-- Final Chainsaw
		{
			["Type"] = 1, ["Name"] = "Reassemble", ["ID"] = 2876, ["Range"] = 25, ["Level"] = PlayerLevel >= 90, ["TargetCast"] = false, ["OGCDLimited"] = OGCDTime > 1.73, ["OtherActionCooldownCheck"] = { ["ID"] = 25788, ["Time"] = 4, }, ["OtherCheck"] = GaugeData1[3] == 0 and LastCast ~= 2876 and CurrentCast ~= 2876,
		},
		{
			["Type"] = 1, ["Name"] = "Chainsaw", ["ID"] = 25788, ["Range"] = 25, ["Level"] = PlayerLevel >= 90, ["TargetCast"] = true, ["Buff"] = HasReassembleBuff, ["OtherCheck"] = GaugeData1[3] == 0,
		},
		-- Extra Skills Level Based
		{
			["Type"] = 1, ["Name"] = "Bioblaster", ["ID"] = 16499, ["Range"] = 12, ["Level"] = PlayerLevel >= 76, ["TargetCast"] = true, ["Buff"] = HasReassembleBuff == false and LastCast ~= 2876 and CurrentCast ~= 2876, ["AOECount"] = 2, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and self.AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Cone", ["TargetPoint"] = Player.pos, ["AOERange"] = 12, ["MaxDistance"] = 12, ["Angle"] = 90, },
		},
		{
			["Type"] = 1, ["Name"] = "Drill", ["ID"] = 16498, ["Range"] = 25, ["Level"] = PlayerLevel >= 76, ["TargetCast"] = true, ["Buff"] = HasReassembleBuff == false and LastCast ~= 2876 and CurrentCast ~= 2876,
		},
		{
			["Type"] = 1, ["Name"] = "Air Anchor", ["ID"] = 16500, ["Range"] = 25, ["Level"] = PlayerLevel >= 90, ["TargetCast"] = true, ["Buff"] = HasReassembleBuff == false and LastCast ~= 2876 and CurrentCast ~= 2876,
		},
        
		{
			["Type"] = 1, ["Name"] = "Auto Crossbow", ["ID"] = 16497, ["Range"] = 12, ["TargetCast"] = true, ["AOECount"] = 2, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and self.AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Cone", ["TargetPoint"] = Player.pos, ["AOERange"] = 12, ["MaxDistance"] = 12, ["Angle"] = 90, }, ["Buff"] = HasReassembleBuff == false and LastCast ~= 2876 and CurrentCast ~= 2876,
		},
		{
			["Type"] = 1, ["Name"] = "Heat Blast", ["ID"] = 7410, ["Range"] = 25, ["TargetCast"] = true,
		},

		-- Filler Rotation

		{
			["Type"] = 1, ["Name"] = "Spread Shot", ["ID"] = 2870, ["Range"] = 12, ["TargetCast"] = true, ["AOECount"] = 2, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and self.AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Cone", ["TargetPoint"] = Player.pos, ["AOERange"] = 12, ["MaxDistance"] = 12, ["Angle"] = 90, }, ["Buff"] = HasReassembleBuff == false and LastCast ~= 2876 and CurrentCast ~= 2876,
			["OtherCheck"] = LastCast ~= 2878 and CurrentCast ~= 2878 and LastCast ~= 17209 and CurrentCast ~= 17209 and GaugeData1[3] == 0,
		},
		{
			["Type"] = 1, ["Name"] = "Scattergun", ["ID"] = 25786, ["Range"] = 12, ["TargetCast"] = true, ["AOECount"] = 2, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and self.AOETimeout == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Cone", ["TargetPoint"] = Player.pos, ["AOERange"] = 12, ["MaxDistance"] = 12, ["Angle"] = 90, }, ["Buff"] = HasReassembleBuff == false and LastCast ~= 2876 and CurrentCast ~= 2876,
			["OtherCheck"] = LastCast ~= 2878 and CurrentCast ~= 2878 and LastCast ~= 17209 and CurrentCast ~= 17209 and GaugeData1[3] == 0,
		},

		{
			["Type"] = 1, ["Name"] = "Split Shot", ["ID"] = 2866, ["Range"] = 25, ["Level"] = PlayerLevel < 54, ["TargetCast"] = true, ["ComboID"] = { [0] = true, [2870] = true, [25786] = true, [2866] = PlayerLevel < 2, [2868] = PlayerLevel < 26, [2873] = true, [7413] = true, }, ["Buff"] = HasReassembleBuff == false and LastCast ~= 2876 and CurrentCast ~= 2876,
			["OtherCheck"] = LastCast ~= 2878 and CurrentCast ~= 2878 and LastCast ~= 17209 and CurrentCast ~= 17209 and GaugeData1[3] == 0,
		},
		{
			["Type"] = 1, ["Name"] = "Slug Shot", ["ID"] = 2868, ["Range"] = 25, ["Level"] = PlayerLevel < 60, ["TargetCast"] = true, ["ComboID"] = { [2866] = true, [7411] = true, }, ["Buff"] = HasReassembleBuff == false and LastCast ~= 2876 and CurrentCast ~= 2876,
			["OtherCheck"] = LastCast ~= 2878 and CurrentCast ~= 2878 and LastCast ~= 17209 and CurrentCast ~= 17209 and GaugeData1[3] == 0,
		},
		{
			["Type"] = 1, ["Name"] = "Clean Shot", ["ID"] = 2873, ["Range"] = 25, ["Level"] = PlayerLevel < 64, ["TargetCast"] = true, ["ComboID"] = { [2868] = true, [7412] = true, }, ["Buff"] = HasReassembleBuff == false and LastCast ~= 2876 and CurrentCast ~= 2876,
		},

		{
			["Type"] = 1, ["Name"] = "Heated Split Shot", ["ID"] = 7411, ["Range"] = 25, ["Level"] = PlayerLevel >= 54, ["TargetCast"] = true, ["ComboID"] = { [0] = true, [2870] = true, [25786] = true, [2866] = PlayerLevel < 2, [2868] = PlayerLevel < 26, [2873] = true, [7413] = true, }, ["Buff"] = HasReassembleBuff == false and LastCast ~= 2876 and CurrentCast ~= 2876,
			["OtherCheck"] = LastCast ~= 2878 and CurrentCast ~= 2878 and LastCast ~= 17209 and CurrentCast ~= 17209 and GaugeData1[3] == 0,
		},
		{
			["Type"] = 1, ["Name"] = "Heated Slug Shot", ["ID"] = 7412, ["Range"] = 25, ["Level"] = PlayerLevel >= 60, ["TargetCast"] = true, ["ComboID"] = { [2866] = true, [7411] = true, }, ["Buff"] = HasReassembleBuff == false and LastCast ~= 2876 and CurrentCast ~= 2876,
			["OtherCheck"] = LastCast ~= 2878 and CurrentCast ~= 2878 and LastCast ~= 17209 and CurrentCast ~= 17209 and GaugeData1[3] == 0,
		},
		{
			["Type"] = 1, ["Name"] = "Heated Clean Shot", ["ID"] = 7413, ["Range"] = 25, ["Level"] = PlayerLevel >= 64, ["TargetCast"] = true, ["ComboID"] = { [2868] = true, [7412] = true, }, ["Buff"] = HasReassembleBuff == false and LastCast ~= 2876 and CurrentCast ~= 2876,
			["OtherCheck"] = LastCast ~= 2878 and CurrentCast ~= 2878 and LastCast ~= 17209 and CurrentCast ~= 17209 and GaugeData1[3] == 0,
		},

		-- ...
		{
			["Type"] = 1, ["Name"] = "Gauss Round", ["ID"] = 2874, ["Range"] = 25, ["TargetCast"] = true, ["OGCDLimited"] = OGCDTime > 0.5, ["Charges"] = 3,
		},
		{
			["Type"] = 1, ["Name"] = "Ricochet", ["ID"] = 2890, ["Range"] = 25, ["TargetCast"] = true, ["OGCDLimited"] = OGCDTime > 0.5, ["Charges"] = 3,
		},
		{
			["Type"] = 1, ["Name"] = "Gauss Round", ["ID"] = 2874, ["Range"] = 25, ["TargetCast"] = true, ["OGCDLimited"] = OGCDTime > 0.5, ["Charges"] = 2,
		},
		{
			["Type"] = 1, ["Name"] = "Ricochet", ["ID"] = 2890, ["Range"] = 25, ["TargetCast"] = true, ["OGCDLimited"] = OGCDTime > 0.5, ["Charges"] = 2,
		},

		{
			["Type"] = 1, ["Name"] = "Gauss Round", ["ID"] = 2874, ["Range"] = 25, ["TargetCast"] = true, ["OGCDLimited"] = OGCDTime > 0.5, ["Charges"] = 1, ["OtherCheck"] = GaugeData1[3] > 0,
		},
		{
			["Type"] = 1, ["Name"] = "Ricochet", ["ID"] = 2890, ["Range"] = 25, ["TargetCast"] = true, ["OGCDLimited"] = OGCDTime > 0.5, ["Charges"] = 1, ["OtherCheck"] = GaugeData1[3] > 0,
		},
		{
			["Type"] = 1, ["Name"] = "Gauss Round", ["ID"] = 2874, ["Range"] = 25, ["TargetCast"] = true, ["OGCDLimited"] = OGCDTime > 0.5, ["Charges"] = 0, ["OtherCheck"] = GaugeData1[3] > 0,
		},
		{
			["Type"] = 1, ["Name"] = "Ricochet", ["ID"] = 2890, ["Range"] = 25, ["TargetCast"] = true, ["OGCDLimited"] = OGCDTime > 0.5, ["Charges"] = 0, ["OtherCheck"] = GaugeData1[3] > 0,
		},
		-- Other Buffs
		{
			["Type"] = 1, ["Name"] = "Barrel Stabilizer", ["ID"] = 7414, ["Range"] = 25, ["TargetCast"] = false, ["OGCDLimited"] = OGCDTime > 0.5, ["Charges"] = 0, ["OtherCheck"] = GaugeData1[1] < 30,
		},

		-- Shared CDS
		{
			["Type"] = 1, ["Name"] = "Head Graze", ["ID"] = 7551, ["Range"] = 25, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Interrupts") == 1, 
			["OtherCheck"] = PlayerInCombat == true and table.valid(Target) == true and Target.castinginfo.channelingid ~= 0 and Target.castinginfo.castinginterruptible == true,
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

	if HasFlamethrowerBuff == true or (LastCast == 7418 and LastCastTime < 3000) or CurrentCast == 7418 then
		self.SendConsoleMessage("BURNNNNNNNN",3)
		return {}
	end

	self.SendConsoleMessage(ClassTypeID.."PROFILE END",1)
    return SkillList
end

return Profile