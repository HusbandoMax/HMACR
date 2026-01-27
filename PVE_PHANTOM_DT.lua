local Profile = {}
Profile.LastID = 0
Profile.Settings = {

	---- Phantom Freelancer - [0


	---- Phantom Knight - [1


	---- Phantom Berserker - [2


	---- Phantom Monk - [3


	---- Phantom Ranger - [4


	---- Phantom Samurai - [5


	---- Phantom Bard - [6


	---- Phantom Geomancer - [7
    {
        ["Setting"] = "BattleBell",
		["PhantomID"] = 7,
		["Options"] = {
			{ ["Name"] = "BattleBell", ["Tooltip"] = "BattleBell OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "BattleBell", ["Tooltip"] = "BattleBell ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "BattleBell", ["Tooltip"] = "BattleBell Party", ["Colour"] = { ["r"] = 0, ["g"] = 0, ["b"] = 1, ["a"] = 1 }, },
		},
    },
    {
        ["Setting"] = "RingingRespite",
		["PhantomID"] = 7,
		["Options"] = {
			{ ["Name"] = "RingingRespite", ["Tooltip"] = "RingingRespite OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "RingingRespite", ["Tooltip"] = "RingingRespite ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "RingingRespite", ["Tooltip"] = "RingingRespite Party", ["Colour"] = { ["r"] = 0, ["g"] = 0, ["b"] = 1, ["a"] = 1 }, },
		},
    },
    {
        ["Setting"] = "CloudyCaress",
		["PhantomID"] = 7,
		["Options"] = {
			{ ["Name"] = "CloudyCaress", ["Tooltip"] = "CloudyCaress ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "CloudyCaress", ["Tooltip"] = "CloudyCaress OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
		},
    },
    {
        ["Setting"] = "Suspend",
		["PhantomID"] = 7,
		["Options"] = {
			{ ["Name"] = "Suspend", ["Tooltip"] = "Suspend OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Suspend", ["Tooltip"] = "Suspend ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Suspend", ["Tooltip"] = "Suspend Party", ["Colour"] = { ["r"] = 0, ["g"] = 0, ["b"] = 1, ["a"] = 1 }, },
		},
    },


	---- Phantom Time Mage - [8


	---- Phantom Cannoneer - [9{
	{
        ["Setting"] = "ShockDark",
		["PhantomID"] = 9,
		["Options"] = {
			{ ["Name"] = "Shock", ["Tooltip"] = "Use Shock", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Dark", ["Tooltip"] = "Use Dark", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
		},
    },
    {
        ["Setting"] = "Cannons",
		["PhantomID"] = 9,
		["Options"] = {
			{ ["Name"] = "Cannons Burn", ["Tooltip"] = "Cannons Burn", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Cannons 2+", ["Tooltip"] = "Cannons 2+", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Cannons 3+", ["Tooltip"] = "Cannons 3+", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Cannons 4+", ["Tooltip"] = "Cannons 4+", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Cannons 5+", ["Tooltip"] = "Cannons 5+", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
		},
    },
    {
        ["Setting"] = "SmartAOE",
		["PhantomID"] = 9,
		["Options"] = {
			{ ["Name"] = "Smart AOE", ["Tooltip"] = "Smart AOE ON\n This pickts the most optimal target in combat to hit as many targets as possible.", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Smart AOE", ["Tooltip"] = "Smart AOE OFF\n This pickts the most optimal target in combat to hit as many targets as possible.", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
		},
    },


	---- Phantom Chemist - 10
    {
        ["Setting"] = "OccPot",
		["PhantomID"] = 10,
        ["Options"] = {
            { ["Name"] = "Occ Pot Off", ["Tooltip"] = "Occ Pot OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Occ Pot 25%", ["Tooltip"] = "Occ Pot 25%", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Occ Pot 50%", ["Tooltip"] = "Occ Pot 50%", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Occ Pot 75%", ["Tooltip"] = "Occ Pot 75%", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "OccPotForceParty",
		["PhantomID"] = 10,
		["Options"] = {
			{ ["Name"] = "Occ Pot Party", ["Tooltip"] = "Occ Pot Party Only ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Occ Pot Party", ["Tooltip"] = "Occ Pot Party Only OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
		},
    },


	---- Phantom Oracle - 11


	---- Phantom Thief - 12
    {
        ["Setting"] = "Sprint",
		["PhantomID"] = 12,
		["Options"] = {
			{ ["Name"] = "Sprint", ["Tooltip"] = "Sprint ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Sprint", ["Tooltip"] = "Sprint OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
		},
    },
    {
        ["Setting"] = "Steal",
		["PhantomID"] = 12,
		["Options"] = {
			{ ["Name"] = "Steal", ["Tooltip"] = "Steal ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Steal", ["Tooltip"] = "Steal OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
		},
    },
    {
        ["Setting"] = "Pilfer",
		["PhantomID"] = 12,
		["Options"] = {
			{ ["Name"] = "Pilfer", ["Tooltip"] = "Pilfer ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Pilfer", ["Tooltip"] = "Pilfer OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
		},
    },
    {
        ["Setting"] = "Vigilance",
		["PhantomID"] = 12,
		["Options"] = {
			{ ["Name"] = "Vigilance", ["Tooltip"] = "Vigilance OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Vigilance", ["Tooltip"] = "Vigilance ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
		},
    },

	-- 13 Phantom Mystic Knight
    {
        ["Setting"] = "Spellblade",
		["PhantomID"] = 13,
		["Options"] = {
			{ ["Name"] = "Sundering", ["Tooltip"] = "Sundering", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Holy", ["Tooltip"] = "Holy", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Blazing", ["Tooltip"] = "Blazing", ["Colour"] = { ["r"] = 0, ["g"] = 0, ["b"] = 1, ["a"] = 1 }, },
		},
    },
	

	-- 14 Phantom Gladiator
	
    {
        ["Setting"] = "Bladeblitz",
		["PhantomID"] = 14,
		["Options"] = {
			{ ["Name"] = "Bladeblitz Burn", ["Tooltip"] = "Bladeblitz Burn", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Bladeblitz 2+", ["Tooltip"] = "Bladeblitz 2+", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Bladeblitz 3+", ["Tooltip"] = "Bladeblitz 3+", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Bladeblitz 4+", ["Tooltip"] = "Bladeblitz 4+", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
			{ ["Name"] = "Bladeblitz 5+", ["Tooltip"] = "Bladeblitz 5+", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
		},
    },



	
    

    {
        ["Setting"] = "Raise",
        ["Options"] = {
            { ["Name"] = "Occ Raise", ["Tooltip"] = "Occ Raise ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Occ Raise", ["Tooltip"] = "Occ Raise OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "HealType",
        ["Options"] = {
            { ["Name"] = "Party", ["Tooltip"] = "Heal Party", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Ally", ["Tooltip"] = "Heal Ally", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
}

function Profile:SkillTable(Data,Target,ClassTypeID)
	self.SendConsoleMessage(ClassTypeID.."PROFILE",1)

	local TargetAttackable = false
	if Target ~= nil and Target.attackable == true then TargetAttackable = true end 
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

	local BladeblitzAOECount = -1
	local CannonsAOECount = -1
	local CannonAOECount = {
		[1] = -1,
		[2] = 2,
		[3] = 3,
		[4] = 4,
		[5] = 5,
	}
	CannonsAOECount = CannonAOECount[self.GetSettingsValue(ClassTypeID,"Cannons")] or -1
	BladeblitzAOECount = CannonAOECount[self.GetSettingsValue(ClassTypeID,"Bladeblitz")] or -1
	
	if Player.localmapid == 1252 and GetControl("MKDInfo") ~= nil and GetControl("MKDInfo"):IsOpen() == true then
		local Data = GetControl("MKDInfo"):GetRawData()
		if Data ~= nil then
			Profile.LastID = Data[13] and Data[13].value or 0
		end
	end

	--	[0] = { ["Name"] = "Phantom Freelancer", 
	--	[1] = { ["Name"] = "Phantom Knight", 
	--	[2] = { ["Name"] = "Phantom Berserker", 
	--	[3] = { ["Name"] = "Phantom Monk", 
	--	[4] = { ["Name"] = "Phantom Ranger", 
	--	[5] = { ["Name"] = "Phantom Samurai", 
	--	[6] = { ["Name"] = "Phantom Bard", 
	--	[7] = { ["Name"] = "Phantom Geomancer", 
	--	[8] = { ["Name"] = "Phantom Time Mage", 
	--	[9] = { ["Name"] = "Phantom Cannoneer", 
	--	[10] = { ["Name"] = "Phantom Chemist", 
	--	[11] = { ["Name"] = "Phantom Oracle", 
	--	[12] = { ["Name"] = "Phantom Thief", 

	local SkillList = {

		---- Phantom Freelancer - [0
		--41650	Occult Resuscitation
		--41651	Occult Treasuresight
	

		---- Phantom Knight - [1
		--41588	Phantom Guard
		--41589	Pray
		--41590	Occult Heal
		--41591	Pledge
		{
			["Type"] = 2, ["Name"] = "Phantom Guard", ["ID"] = 41588, ["Range"] = 5, ["TargetCast"] = false, ["HP"] = 50, ["OtherCheck"] = PlayerInCombat == true,
			--["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Guard") == 1, ["SettingsTags"] = { "Guard" }, --["OtherCheck"] = PlayerInCombat == true, 
		},
		{
			["Type"] = 2, ["Name"] = "Pray", ["ID"] = 41589, ["Range"] = 5, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true,
			["Buff2"] = { ["Target"] = Player, ["BuffID"] = {4232}, ["Time"] = 3, ["Type"] = "Missing", ["Owner"] = PlayerID, ["StackSize"] = nil, },
		},
		{
			["Type"] = 2, ["Name"] = "Occult Heal", ["ID"] = 41590, ["Range"] = 5, ["TargetCast"] = false, ["HP"] = 15, ["OtherCheck"] = PlayerInCombat == true,
			--["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Guard") == 1, ["SettingsTags"] = { "Guard" }, --["OtherCheck"] = PlayerInCombat == true, 
		},
		{
			["Type"] = 2, ["Name"] = "Pledge", ["ID"] = 41591, ["Range"] = 5, ["TargetCast"] = false, ["HP"] = 10, ["OtherCheck"] = PlayerInCombat == true,
			--["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Guard") == 1, ["SettingsTags"] = { "Guard" }, --["OtherCheck"] = PlayerInCombat == true, 
		},

		---- Phantom Berserker - [2
		--41592	Rage
		--41594	Deadly Blow
		--{
		--	["Type"] = 2, ["Name"] = "Rage", ["ID"] = 41592, ["Range"] = 15, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true, ["AOECount"] = 1, 
		--	["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Cone", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 8, ["MaxDistance"] = 8, ["LineWidth"] = 0, ["Angle"] = 180, },
		--},
		{
			["Type"] = 1, ["Name"] = "Deadly Blow", ["ID"] = 41594, ["Range"] = 15, ["TargetCast"] = true,
		},


		---- Phantom Monk - [3
		--41595	Phantom Kick
		--41596	Occult Counter
		--41597	Counterstance
		--41598	Occult Chakra

		{
			["Type"] = 1, ["Name"] = "Phantom Kick", ["ID"] = 41595, ["Range"] = 15, ["TargetCast"] = true, ["SettingValue"] = JumpTimeout == false and self.GetSettingsValue(ClassTypeID,"Phantom Kick") == 1,
			["Buff2"] = { ["Target"] = Player, ["BuffID"] = {4237}, ["Time"] = 5, ["Type"] = "Missing", ["Owner"] = PlayerID, ["StackSize"] = nil, },
		},
		{
			["Type"] = 1, ["Name"] = "Occult Counter", ["ID"] = 41596, ["Range"] = 6, ["TargetCast"] = true,
		},
		{
			["Type"] = 2, ["Name"] = "Counterstance", ["ID"] = 41597, ["Range"] = 5, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true,
			["Buff2"] = { ["Target"] = Player, ["BuffID"] = {4238}, ["Time"] = 5, ["Type"] = "Missing", ["Owner"] = PlayerID, ["StackSize"] = nil, },
		},
		{
			["Type"] = 2, ["Name"] = "Occult Chakra", ["ID"] = 41598, ["Range"] = 5, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true, ["HP"] = 29,
		},



		---- Phantom Ranger - [4
		--41599	Phantom Aim
		--41600	Occult Featherfoot
		--41601	Occult Falcon
		--41602	Occult Unicorn
		{
			["Type"] = 2, ["Name"] = "Phantom Aim", ["ID"] = 41599, ["Range"] = 5, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true, 
		},
		{
			["Type"] = 2, ["Name"] = "Occult Unicorn", ["ID"] = 41602, ["Range"] = 5, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true, ["HP"] = 50,
		},


		
		---- Phantom Samurai - [5
		--41603	Mineuchi
		--41604	Shirahadori
		--41605	Iainuki
		--41606	Zeninage
		{
			["Type"] = 1, ["Name"] = "Iainuki", ["ID"] = 41605, ["Range"] = 8, ["TargetCast"] = true, ["OtherCheck"] = PlayerInCombat == true, ["AOECount"] = 1, 
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Cone", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 8, ["MaxDistance"] = 8, ["LineWidth"] = 0, ["Angle"] = 90, },
		},
		

		---- Phantom Bard - [6
		--41608	Offensive Aria
		--41609	Romeo's Ballad
		--41607	Mighty March
		--41610	Hero's Rime
		{
			["Type"] = 2, ["Name"] = "Hero's Rime", ["ID"] = 41610, ["Range"] = 5, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true, 
			["Buff2"] = { ["Target"] = Player, ["BuffID"] = {4249,4247}, ["Time"] = -1, ["Type"] = "Missing", ["Owner"] = PlayerID, ["StackSize"] = nil, },
		},
		{
			["Type"] = 2, ["Name"] = "Offensive Aria", ["ID"] = 41608, ["Range"] = 5, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true, 
			["Buff2"] = { ["Target"] = Player, ["BuffID"] = {4249,4247}, ["Time"] = -1, ["Type"] = "Missing", ["Owner"] = PlayerID, ["StackSize"] = nil, },
		},
		{
			["Type"] = 2, ["Name"] = "Mighty March", ["ID"] = 41610, ["Range"] = 5, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true, ["HP"] = 50,
		},


		---- Phantom Geomancer - [7
		--41611	Battle Bell
		--41614	Cloudy Caress
		--41619	Ringing Respite
		--41620	Suspend

		{
			["Type"] = 3, ["Name"] = "Battle Bell", ["ID"] = 41611, ["Range"] = 30, ["TargetCast"] = true, ["PartyOnly"] = true, ["HPAbove"] = 1, ["OtherCheck"] = PlayerInCombat == true,
			["Buff2"] = { ["Target"] = nil, ["BuffID"] = {4251}, ["Time"] = 10, ["Type"] = "Missing", ["Owner"] = PlayerID, ["StackSize"] = nil, },
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"BattleBell") == 3, ["SettingsTags2"] = 7,
		},
		{
			["Type"] = 2, ["Name"] = "Battle Bell", ["ID"] = 41611, ["Range"] = 30, ["TargetCast"] = true, ["PartyOnly"] = true, ["HPAbove"] = 1, ["OtherCheck"] = PlayerInCombat == true,
			["Buff2"] = { ["Target"] = nil, ["BuffID"] = {4251}, ["Time"] = 10, ["Type"] = "Missing", ["Owner"] = PlayerID, ["StackSize"] = nil, },
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"BattleBell") == 2, ["SettingsTags2"] = 7,
		},
		{
			["Type"] = 3, ["Name"] = "Suspend", ["ID"] = 41620, ["Range"] = 30, ["TargetCast"] = true, ["PartyOnly"] = true, ["HPAbove"] = 1, ["OtherCheck"] = PlayerInCombat == true,
			["Buff2"] = { ["Target"] = nil, ["BuffID"] = {4258}, ["Time"] = 5, ["Type"] = "Missing", ["Owner"] = PlayerID, ["StackSize"] = nil, },
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Suspend") == 3, ["SettingsTags2"] = 7,
		},
		{
			["Type"] = 2, ["Name"] = "Suspend", ["ID"] = 41620, ["Range"] = 30, ["TargetCast"] = true, ["PartyOnly"] = true, ["HPAbove"] = 1, ["OtherCheck"] = PlayerInCombat == true,
			["Buff2"] = { ["Target"] = nil, ["BuffID"] = {4258}, ["Time"] = 5, ["Type"] = "Missing", ["Owner"] = PlayerID, ["StackSize"] = nil, },
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"Suspend") == 2, ["SettingsTags2"] = 7,
		},
		{
			["Type"] = 2, ["Name"] = "Cloudy Caress", ["ID"] = 41614, ["Range"] = 0, ["TargetCast"] = false, ["PartyOnly"] = true,
			["OtherCheck"] = self.PartyBelowHP(15,80,nil,Data.EntityListSorted.PartySelf) >= (PartySize/2) and PlayerInCombat == true,
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"CloudyCaress") ~= 1, ["SettingsTags2"] = 7,
		},
		{
			["Type"] = 3, ["Name"] = "Ringing Respite", ["ID"] = 41619, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 70, ["PartyOnly"] = true, ["OtherCheck"] = PlayerInCombat == true,
			["Buff2"] = { ["Target"] = nil, ["BuffID"] = {4257}, ["Time"] = -1, ["Type"] = "Missing", ["Owner"] = PlayerID, ["StackSize"] = nil, },
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"RingingRespite") == 3, ["SettingsTags2"] = 7,
		},
		{
			["Type"] = 2, ["Name"] = "Ringing Respite", ["ID"] = 41619, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = 70, ["PartyOnly"] = true, ["OtherCheck"] = PlayerInCombat == true,
			["Buff2"] = { ["Target"] = nil, ["BuffID"] = {4257}, ["Time"] = -1, ["Type"] = "Missing", ["Owner"] = PlayerID, ["StackSize"] = nil, },
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"RingingRespite") == 2, ["SettingsTags2"] = 7,
		},

		
		---- Phantom Time Mage - [8
		--41621	Occult Slowga
		--41623	Occult Comet
		--41624	Occult Mage Masher
		--41622	Occult Dispel
		--41625	Occult Quick

		--{
		--	["Type"] = 1, ["Name"] = "Occult Slowga", ["ID"] = 41621, ["Range"] = 30, ["TargetCast"] = true, ["OtherCheck"] = PlayerInCombat == true, 
		--	["Buff2"] = { ["Target"] = Player, ["BuffID"] = {4249}, ["Time"] = 5, ["Type"] = "Missing", ["Owner"] = PlayerID, ["StackSize"] = nil, },
		--},
		{
			["Type"] = 1, ["Name"] = "Occult Comet", ["ID"] = 41623, ["Range"] = 30, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Occult Mage Masher", ["ID"] = 41624, ["Range"] = 30, ["TargetCast"] = true, ["OtherCheck"] = PlayerInCombat == true, 
			["Buff2"] = { ["Target"] = Target, ["BuffID"] = {4259}, ["Time"] = 5, ["Type"] = "Missing", ["Owner"] = PlayerID, ["StackSize"] = nil, },
		},
		{
			["Type"] = 2, ["Name"] = "Occult Quick", ["ID"] = 41625, ["Range"] = 30, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true,
		},

		---- Phantom Cannoneer - [9
		--41626	Phantom Fire
		--41627	Holy Cannon
		--41628	Dark Cannon
		--41629	Shock Cannon
		--41630	Silver Cannon
		
		{
			["Type"] = 1, ["Name"] = "Phantom Fire", ["ID"] = 41626, ["Range"] = 30, ["TargetCast"] = true, ["SmartAOE"] = self.GetSettingsValue(ClassTypeID,"SmartAOE") == 1, ["AOECount"] = CannonsAOECount, ["OtherCheck"] = PlayerInCombat == true and HusbandoMax.ACRHandler.ActionTimeoutCheck("Cannons") == false, 
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 30, ["LineWidth"] = 0, ["Angle"] = 0, }, ["SettingsTags2"] = 9,
		},
		{
			["Type"] = 1, ["Name"] = "Holy Cannon", ["ID"] = 41627, ["Range"] = 30, ["TargetCast"] = true, ["SmartAOE"] = self.GetSettingsValue(ClassTypeID,"SmartAOE") == 1, ["AOECount"] = CannonsAOECount, ["OtherCheck"] = PlayerInCombat == true and HusbandoMax.ACRHandler.ActionTimeoutCheck("Cannons") == false, 
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 30, ["LineWidth"] = 0, ["Angle"] = 0, }, ["SettingsTags2"] = 9,
		},
		{
			["Type"] = 1, ["Name"] = "Dark Cannon", ["ID"] = 41628, ["Range"] = 30, ["TargetCast"] = true, ["SmartAOE"] = self.GetSettingsValue(ClassTypeID,"SmartAOE") == 1, ["AOECount"] = CannonsAOECount, ["OtherCheck"] = PlayerInCombat == true and HusbandoMax.ACRHandler.ActionTimeoutCheck("Cannons") == false, 
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 30, ["LineWidth"] = 0, ["Angle"] = 0, }, ["SettingsTags2"] = 9,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"ShockDark") == 2,
		},
		{
			["Type"] = 1, ["Name"] = "Shock Cannon", ["ID"] = 41629, ["Range"] = 30, ["TargetCast"] = true, ["SmartAOE"] = self.GetSettingsValue(ClassTypeID,"SmartAOE") == 1, ["AOECount"] = CannonsAOECount, ["OtherCheck"] = PlayerInCombat == true and HusbandoMax.ACRHandler.ActionTimeoutCheck("Cannons") == false, 
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 30, ["LineWidth"] = 0, ["Angle"] = 0, }, ["SettingsTags2"] = 9,
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"ShockDark") == 1,
		},
		{
			["Type"] = 1, ["Name"] = "Silver Cannon", ["ID"] = 41630, ["Range"] = 30, ["TargetCast"] = true, ["SmartAOE"] = self.GetSettingsValue(ClassTypeID,"SmartAOE") == 1, ["AOECount"] = CannonsAOECount, ["OtherCheck"] = PlayerInCombat == true and HusbandoMax.ACRHandler.ActionTimeoutCheck("Cannons") == false, 
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 30, ["LineWidth"] = 0, ["Angle"] = 0, }, ["SettingsTags2"] = 9,
		},

		---- Phantom Chemist - 10
		--41631	Occult Potion
		--41633	Occult Ether
		--41634	Revive
		--41635	Occult Elixir
		{
			["Type"] = 3, ["Name"] = "Occult Potion All", ["ID"] = 41631, ["Range"] = 30, ["TargetCast"] = true, ["HP"] = (self.GetSettingsValue(ClassTypeID,"OccPot") - 1) * 25, ["PartyOnly"] = self.GetSettingsValue(ClassTypeID,"OccPotForceParty") == 1,
			["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"OccPot") ~= 1, --["SettingsTags2"] = 10,
		},
		--{
		--	["Type"] = 3, ["Name"] = "Occult Ether", ["ID"] = 41633, ["Range"] = 30, ["TargetCast"] = true, ["MP"] = 25, ["PartyOnly"] = true,
		--	["SettingValue"] = HealTimeout == false and self.GetSettingsValue(ClassTypeID,"OccPot") ~= 1, ["SettingsTags2"] = 10, --["OtherCheck"] = PlayerInCombat == true, 
		--},
		

		---- Phantom Oracle - 11
		--41636	Predict
		--41641	Recuperation
		--41642	Phantom Doom
		--41643	Phantom Rejuvenation
		--41644	Invulnerability


		---- Phantom Thief - 12
		--41646	Occult Sprint
		--41645	Steal
		--41647	Vigilance
		--41648	Trap Detection
		--41649	Pilfer Weapon
		{
			["Type"] = 1, ["Name"] = "Occult Sprint", ["ID"] = 41646, ["Range"] = 5, ["TargetCast"] = false, 
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Sprint") == 1, ["SettingsTags2"] = 12, ["OtherCheck"] = PlayerInCombat == true and PlayerMoving == true,
		},
		{
			["Type"] = 1, ["Name"] = "Steal", ["ID"] = 41645, ["Range"] = 5, ["TargetCast"] = true, 
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Steal") == 1, ["SettingsTags2"] = 12, --["OtherCheck"] = PlayerInCombat == true, 
		},
		{
			["Type"] = 1, ["Name"] = "Vigilance", ["ID"] = 41647, ["Range"] = 20, ["TargetCast"] = false, 
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Vigilance") == 2, ["SettingsTags2"] = 12, ["OtherCheck"] = PlayerInCombat == false and TargetAttackable == true, 
		},
		{
			["Type"] = 1, ["Name"] = "Pilfer Weapon", ["ID"] = 41649, ["Range"] = 5, ["TargetCast"] = true, 
			["Buff2"] = { ["Target"] = nil, ["BuffID"] = {4279}, ["Time"] = 5, ["Type"] = "Missing", ["Owner"] = PlayerID, ["StackSize"] = nil, },
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Pilfer") == 1, ["SettingsTags2"] = 12, --["OtherCheck"] = PlayerInCombat == true, 
		},

		
		--	Phantom Mystic Knight
		--	46591 Sundering Spellblade
		--  46590 Magic Shell
		--  46592 Holy Spellblade
		--  46593 Blazing Spellblade

		{
			["Type"] = 2, ["Name"] = "Magic Shell", ["ID"] = 46590, ["Range"] = 5, ["TargetCast"] = false, ["HP"] = 50, ["OtherCheck"] = PlayerInCombat == true,
			--["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Guard") == 1, ["SettingsTags"] = { "Guard" }, --["OtherCheck"] = PlayerInCombat == true, 
		},
		{
			["Type"] = 1, ["Name"] = "Sundering Spellblade", ["ID"] = 46591, ["Range"] = 5, ["TargetCast"] = true, 
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Spellblade") == 1, ["SettingsTags2"] = 13, --["OtherCheck"] = PlayerInCombat == true, 
		},
		{
			["Type"] = 1, ["Name"] = "Holy Spellblade", ["ID"] = 46592, ["Range"] = 5, ["TargetCast"] = true, 
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Spellblade") == 2, ["SettingsTags2"] = 13, --["OtherCheck"] = PlayerInCombat == true, 
		},
		{
			["Type"] = 1, ["Name"] = "Blazing Spellblade", ["ID"] = 46593, ["Range"] = 5, ["TargetCast"] = true, 
			["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Spellblade") == 3, ["SettingsTags2"] = 13, --["OtherCheck"] = PlayerInCombat == true, 
		},

		--	Phantom Gladiator
		--	46594 Finisher
		--  46595 Defend
		--  46596 Long Reach
		--  46597 Bladeblitz

		{
			["Type"] = 2, ["Name"] = "Defend", ["ID"] = 46595, ["Range"] = 5, ["TargetCast"] = false, ["HP"] = 50, ["OtherCheck"] = PlayerInCombat == true,
			--["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Guard") == 1, ["SettingsTags"] = { "Guard" }, --["OtherCheck"] = PlayerInCombat == true, 
		},
		{
			["Type"] = 2, ["Name"] = "Bladeblitz", ["ID"] = 46597, ["Range"] = 0, ["TargetCast"] = false, ["SmartAOE"] = self.GetSettingsValue(ClassTypeID,"SmartAOE") == 1, ["AOECount"] = BladeblitzAOECount, ["OtherCheck"] = PlayerInCombat == true and HusbandoMax.ACRHandler.ActionTimeoutCheck("Bladeblitz") == false, 
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 8, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, }, ["SettingsTags2"] = 9,
		},
		{
			["Type"] = 1, ["Name"] = "Finisher", ["ID"] = 46594, ["Range"] = 5, ["TargetCast"] = true, 
			--["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Spellblade") == 3, ["SettingsTags2"] = 13, --["OtherCheck"] = PlayerInCombat == true, 
		},
		{
			["Type"] = 1, ["Name"] = "Long Reach", ["ID"] = 46596, ["Range"] = 30, ["TargetCast"] = true, 
			--["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Spellblade") == 3, ["SettingsTags2"] = 13, --["OtherCheck"] = PlayerInCombat == true, 
		},

		--	Phantom Dancer
		--  46598  Dance
		--  46599  Phantom Sword Dance
		--  46600  Tempting Tango
		--  46601  Jitterbug
		--  46602  Mystery Waltz

		--  46603 Quickstep
		--  46604 Steadfast Stance
		--  46605 Mesmerize


		{
			["Type"] = 2, ["Name"] = "Dance", ["ID"] = 46598, ["Range"] = 5, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true,
			--["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Guard") == 1, ["SettingsTags"] = { "Guard" }, --["OtherCheck"] = PlayerInCombat == true, 
		},
		{
			["Type"] = 1, ["Name"] = "Phantom Sword Dance", ["ID"] = 46599, ["Range"] = 30, ["TargetCast"] = true, 
			--["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Spellblade") == 3, ["SettingsTags2"] = 15, --["OtherCheck"] = PlayerInCombat == true, 
		},
		{
			["Type"] = 1, ["Name"] = "Tempting Tango", ["ID"] = 46600, ["Range"] = 30, ["TargetCast"] = true, 
			--["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Spellblade") == 3, ["SettingsTags2"] = 15, --["OtherCheck"] = PlayerInCombat == true, 
		},
		{
			["Type"] = 1, ["Name"] = "Jitterbug", ["ID"] = 46601, ["Range"] = 30, ["TargetCast"] = true, 
			--["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Spellblade") == 3, ["SettingsTags2"] = 15, --["OtherCheck"] = PlayerInCombat == true, 
		},
		{
			["Type"] = 1, ["Name"] = "Mystery Waltz", ["ID"] = 46602, ["Range"] = 30, ["TargetCast"] = true, 
			--["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Spellblade") == 3, ["SettingsTags2"] = 15, --["OtherCheck"] = PlayerInCombat == true, 
		},

		{
			["Type"] = 1, ["Name"] = "Mesmerize", ["ID"] = 46605, ["Range"] = 30, ["TargetCast"] = true, 
			--["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Spellblade") == 3, ["SettingsTags2"] = 15, --["OtherCheck"] = PlayerInCombat == true, 
		},
		{
			["Type"] = 2, ["Name"] = "Steadfast Stance", ["ID"] = 46604, ["Range"] = 5, ["TargetCast"] = false, ["HP"] = 50, ["OtherCheck"] = PlayerInCombat == true,
			--["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Guard") == 1, ["SettingsTags"] = { "Guard" }, --["OtherCheck"] = PlayerInCombat == true, 
		},
		{
			["Type"] = 2, ["Name"] = "Quickstep", ["ID"] = 46603, ["Range"] = 5, ["TargetCast"] = false, ["OtherCheck"] = PlayerInCombat == true,
			["Buff2"] = { ["Target"] = Player, ["BuffID"] = {4798}, ["Time"] = 5, ["Type"] = "Missing", ["Owner"] = PlayerID, ["StackSize"] = nil, },
		},

	}


	local SettingsChecked = {}
	for i,e in pairs(SkillList) do
		if e.SettingsTags ~= nil then
			for ii,ee in pairs(e.SettingsTags) do
				if SettingsChecked[ee] == nil then
					local Action = ActionList:Get(1,e.ID)
					if Action ~= nil and Action.usable == false then
						SettingsChecked[ee] = false
					else
						SettingsChecked[ee] = true
					end
				end
				HusbandoMax.ACRHandler.SettingState("PVE_PHANTOM_DT",ClassTypeID..ee,SettingsChecked[ee])
			end
		end
	end

	--d("SettingsChecked")
	--d(SettingsChecked)

	local RaiseAction
	if self.GetSettingsValue(ClassTypeID,"Raise") == 1 then
		RaiseAction = 41634
	end
	
	local Action = ActionList:Get(1,RaiseAction)
	if Action ~= nil and Action.usable == false then
		HusbandoMax.ACRHandler.SettingState("PVE_PHANTOM_DT",ClassTypeID.."Raise",false)
	end
	
	self.SendConsoleMessage(ClassTypeID.."PROFILE END",1)
    return SkillList,nil,{ ["Profile"] = "PVE_PHANTOM_DT", ["ID"] = Profile.LastID, },RaiseAction
end

return Profile