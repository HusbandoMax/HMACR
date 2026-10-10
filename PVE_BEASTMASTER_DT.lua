local Profile = {}

Profile.Settings = {
    {
        ["Setting"] = "Jumps", ["Icon"] = 3925,
        ["Options"] = {
            { ["Name"] = "Jumps > 5", ["Short"] = ">5", ["Tooltip"] = "Shield Charge > 5y", ["Colour"] = { ["r"] = 1, ["g"] = 0.6, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Jumps > 10", ["Short"] = ">10", ["Tooltip"] = "Shield Charge > 10y", ["Colour"] = { ["r"] = 1, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Jumps > 15", ["Short"] = ">15", ["Tooltip"] = "Shield Charge > 15y", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Jumps Off", ["Short"] = "OFF", ["Tooltip"] = "Shield Charge Off", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    
    {
        ["Setting"] = "Snarl", ["Icon"] = 64535, ["DefaultOption"] = 2,
        ["Options"] = {
            { ["Name"] = "Snarl Off", ["Short"] = "OFF", ["Tooltip"] = "Neither Snarl nor Challenge", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Snarl", ["Short"] = "ON", ["Tooltip"] = "Snarl on cooldown, the familiar holds it", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Smart Snarl", ["Short"] = "SMART", ["Tooltip"] = "Snarl on cooldown, and Challenge to take it back when the familiar is at or under the HP number", ["Colour"] = { ["r"] = 0, ["g"] = 0.6, ["b"] = 1, ["a"] = 1 }, },
        },
        ["Value"] = {
            ["Setting"] = "PetHP", ["Option"] = 3, ["Name"] = "Smart", ["Suffix"] = "%",
            ["ValueMin"] = 10, ["ValueMax"] = 90, ["ValueStep"] = 5, ["ValueDefault"] = 50,
            ["Tooltip"] = "Smart Snarl stops snarling and takes the target back with Challenge once the familiar is at or under this",
        },
    },
    
    {
        ["Setting"] = "PetSwap", ["Icon"] = 3924, ["DefaultOption"] = 3,
        ["Options"] = {
            { ["Name"] = "Pet Swap Off", ["Short"] = "OFF", ["Tooltip"] = "Keep whatever is out until it dies", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Auto Swap", ["Short"] = "AUTO", ["ValueName"] = "[A] Swap", ["Tooltip"] = "Pet Swap's HP rule, and on top of it the familiars are rotated: each stays out for its share of the horns' 90 seconds (30s with three horns, 45s with two), then goes off for the next once its aether is spent, so a horn is always coming back", ["Colour"] = { ["r"] = 0, ["g"] = 0.6, ["b"] = 1, ["a"] = 1 }, },
            { ["Name"] = "Pet Swap", ["Short"] = "ON", ["Tooltip"] = "Parting Blow a worn down familiar and call the next one", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
        },
        ["Value"] = {
            ["Setting"] = "SwapHP", ["Option"] = { 2, 3, }, ["Name"] = "Swap", ["Suffix"] = "%",
            ["ValueMin"] = 5, ["ValueMax"] = 90, ["ValueStep"] = 5, ["ValueDefault"] = 30,
            ["Tooltip"] = "How much HP the familiar has to lose from where it was called before it is swapped out",
        },
    },
    
    {
        ["Setting"] = "Aether", ["Icon"] = 3914,
        ["Options"] = {
            { ["Name"] = "Borrow", ["Short"] = "BRW", ["Tooltip"] = "Spend One with Nature on Borrow, for the kin's Beast Mode action", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Release", ["Short"] = "REL", ["Tooltip"] = "Spend One with Nature on Tempered Release, the beast's own ability", ["Colour"] = { ["r"] = 0, ["g"] = 0.6, ["b"] = 1, ["a"] = 1 }, },
            { ["Name"] = "Aether Off", ["Short"] = "OFF", ["Tooltip"] = "Spend neither", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Per Pet", ["Short"] = "LIST", ["Tooltip"] = "Each familiar does what it is set to in the Familiars window (the Familiars button on the settings page). Beasts left on Default there Borrow", ["Colour"] = { ["r"] = 1, ["g"] = 0.8, ["b"] = 0.2, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "BeastMode", ["Icon"] = 3944,
        ["Options"] = {
            { ["Name"] = "Beast Mode", ["Short"] = "ON", ["Tooltip"] = "Use the action Borrow handed over. Quelling Wave when the target is out of melee reach, Soul Crush on cooldown, the skins and Seedsower put up once, Scouring Ash when there is a debuff to cleanse. Cloud Skim is a dash and is never pressed", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Beast Mode Off", ["Short"] = "OFF", ["Tooltip"] = "Leave the borrowed action alone", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    
    {
        ["Setting"] = "RallyStacks", ["Type"] = "Value", ["Name"] = "Rally", ["Suffix"] = "",
        ["ValueMin"] = 1, ["ValueMax"] = 3, ["ValueStep"] = 1, ["ValueDefault"] = 3,
        ["Tooltip"] = "How many Mastered Instinct stacks to bank before Rally spends them on a pair. At level 50 Rally always waits for three: that is 250 TP from empty, which under a Sunstrider or Moonstalker is Universality",
    },
    {
        ["Setting"] = "CheerStacks", ["Type"] = "Value", ["Name"] = "Cheer", ["Suffix"] = "",
        ["ValueMin"] = 1, ["ValueMax"] = 3, ["ValueStep"] = 1, ["ValueDefault"] = 3,
        ["Tooltip"] = "How many Natural Instinct stacks to bank before Rallying Cheer spends them on the familiar bar, which is what pays for Trick. Spent whenever that makes a pair possible right away",
    },
    {
        ["Setting"] = "PetFloor", ["Type"] = "Value", ["Name"] = "Away", ["Suffix"] = "%",
        ["ValueMin"] = 1, ["ValueMax"] = 50, ["ValueStep"] = 1, ["ValueDefault"] = 10,
        ["Tooltip"] = "Parting Blow the familiar the moment it is this low, whatever the swap rule says and whether or not a horn is ready. A dismissed familiar keeps its HP, a dead one has to be recaught",
    },
    
    {
        ["Setting"] = "Horn1", ["Icon"] = 3941,
        ["Options"] = {
            { ["Name"] = "1st Horn", ["Short"] = "ON", ["Tooltip"] = "First Battlehorn ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "1st Horn", ["Short"] = "OFF", ["Tooltip"] = "First Battlehorn OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "Horn2", ["Icon"] = 3942,
        ["Options"] = {
            { ["Name"] = "2nd Horn", ["Short"] = "ON", ["Tooltip"] = "Second Battlehorn ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "2nd Horn", ["Short"] = "OFF", ["Tooltip"] = "Second Battlehorn OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "Horn3", ["Icon"] = 3943,
        ["Options"] = {
            { ["Name"] = "3rd Horn", ["Short"] = "ON", ["Tooltip"] = "Third Battlehorn ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "3rd Horn", ["Short"] = "OFF", ["Tooltip"] = "Third Battlehorn OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
}

function Profile:SkillTable(Data,Target,ClassTypeID)
	self.SendConsoleMessage(ClassTypeID.."PROFILE",1)

    local PlayerLevel = Data.PlayerLevel
    local PlayerInCombat = Data.PlayerInCombat
    local TargetDistance = Data.TargetDistance
    local JumpTimeout = Data.JumpTimeout

    local Helper = (HusbandoMax ~= nil and HusbandoMax.ACRHandler ~= nil) and HusbandoMax.ACRHandler.Beastmaster or nil
    if Helper == nil or Helper.State == nil or Helper.State.Read == nil then
        if Profile.SaidNoHelper ~= true then
            Profile.SaidNoHelper = true
            self.SendConsoleMessage("Beastmaster helper is not loaded, so this profile can do nothing. Reload the ACR pack.",1)
        end
        return {}
    end
    Profile.SaidNoHelper = nil
    local S = Helper.State.Read(self,Data,Target,ClassTypeID)
    local Plan = S.Plan

	local SkillList = {
        {
            ["Type"] = 2, ["Name"] = "First Battlehorn", ["ID"] = 44881, ["Range"] = 0, ["TargetCast"] = false,
            ["Level"] = PlayerLevel >= 1, ["OtherCheck"] = S.NoFamiliar and S.AddonDrivingPet == false,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Horn1") == 1,
        },
        {
            ["Type"] = 2, ["Name"] = "Second Battlehorn", ["ID"] = 44892, ["Range"] = 0, ["TargetCast"] = false,
            ["Level"] = PlayerLevel >= 10, ["OtherCheck"] = S.NoFamiliar and S.AddonDrivingPet == false,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Horn2") == 1,
        },
        {
            ["Type"] = 2, ["Name"] = "Third Battlehorn", ["ID"] = 44894, ["Range"] = 0, ["TargetCast"] = false,
            ["Level"] = PlayerLevel >= 20, ["OtherCheck"] = S.NoFamiliar and S.AddonDrivingPet == false,
            ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"Horn3") == 1,
        },


        {
            ["Type"] = 1, ["Name"] = "Snarl", ["ID"] = 46751, ["Range"] = 25, ["TargetCast"] = true,
            ["OtherCheck"] = S.SnarlAllowed,
        },
        {
            ["Type"] = 1, ["Name"] = "Challenge", ["ID"] = 46750, ["Range"] = 25, ["TargetCast"] = true,
            ["OtherCheck"] = S.ChallengeAllowed,
        },
        
        {
            ["Type"] = 1, ["Name"] = "Shield Charge", ["ID"] = 44893, ["Range"] = 20, ["TargetCast"] = true,
            ["Level"] = PlayerLevel >= 24,
            ["SettingValue"] = JumpTimeout == false and self.GetSettingsValue(ClassTypeID,"Jumps") ~= 4,
            ["OtherCheck"] = (self.GetSettingsValue(ClassTypeID,"Jumps") == 1 and TargetDistance > 5) or (self.GetSettingsValue(ClassTypeID,"Jumps") == 2 and TargetDistance > 10) or (self.GetSettingsValue(ClassTypeID,"Jumps") == 3 and TargetDistance > 15),
        },

        {
            ["Type"] = 2, ["Name"] = "Borrow", ["ID"] = 44895, ["Range"] = 0, ["TargetCast"] = false,
            ["Level"] = PlayerLevel >= 22,
            ["OtherCheck"] = S.AetherMode == 1 and S.OneWithNature == true and S.NoFamiliar == false,
        },
        {
            ["Type"] = 1, ["Name"] = "Tempered Release", ["ID"] = 47092, ["Range"] = 25, ["TargetCast"] = true,
            ["Level"] = PlayerLevel >= 18,
            ["OtherCheck"] = S.NoFamiliar == false and S.OneWithNature == true
                and (S.AetherMode == 2 or (S.PartWithReleaseNow == true and S.SwapPet == true and PlayerInCombat == true)),
        },

        
        {
            ["Type"] = 1, ["Name"] = "Beast Mode", ["ID"] = 44886, ["Range"] = 25, ["TargetCast"] = true,
            ["Level"] = PlayerLevel >= 22,
            ["OtherCheck"] = S.BeastModeAimed == true,
        },
        {
            ["Type"] = 2, ["Name"] = "Beast Mode", ["ID"] = 44886, ["Range"] = 0, ["TargetCast"] = false,
            ["Level"] = PlayerLevel >= 22,
            ["OtherCheck"] = S.BeastModeSelf == true,
        },

        -- Low HP
        {
            ["Type"] = 1, ["Name"] = "Parting Blow", ["ID"] = 44891, ["Range"] = 25, ["TargetCast"] = true,
            ["Level"] = PlayerLevel >= 6,
            ["OtherCheck"] = S.SwapPet == true and PlayerInCombat == true
                and (S.PartWithRelease == false or (S.PetCritical == true and S.OneWithNature == false)),
        },

        {
            ["Type"] = 2, ["Name"] = "Rally", ["ID"] = 44905, ["Range"] = 0, ["TargetCast"] = false,
            ["Level"] = PlayerLevel >= 28,
            ["OtherCheck"] = Plan.Rally == true and PlayerInCombat == true,
        },
        {
            ["Type"] = 2, ["Name"] = "Rallying Cheer", ["ID"] = 44904, ["Range"] = 0, ["TargetCast"] = false,
            ["Level"] = PlayerLevel >= 40,
            ["OtherCheck"] = Plan.Cheer == true and PlayerInCombat == true,
        },

        {
            ["Type"] = 1, ["Name"] = "Trick", ["ID"] = 47093, ["Range"] = 3, ["TargetCast"] = true,
            ["Level"] = PlayerLevel >= 8, ["OtherCheck"] = Plan.Trick == true,
        },

        -- At 250 TP
        {
            ["Type"] = 1, ["Name"] = "Brutal Rage", ["ID"] = 44930, ["Range"] = 3, ["TargetCast"] = true,
            ["Level"] = PlayerLevel >= 50, ["OtherCheck"] = Plan.Upgraded == "Sun" or Plan.Upgraded == "Any",
        },
        {
            ["Type"] = 1, ["Name"] = "Risen Fall", ["ID"] = 44932, ["Range"] = 3, ["TargetCast"] = true,
            ["Level"] = PlayerLevel >= 50, ["OtherCheck"] = Plan.Upgraded == "Sun" or Plan.Upgraded == "Any",
        },
        {
            ["Type"] = 1, ["Name"] = "Hawkish Talons", ["ID"] = 44931, ["Range"] = 3, ["TargetCast"] = true,
            ["Level"] = PlayerLevel >= 50, ["OtherCheck"] = Plan.Upgraded == "Moon" or Plan.Upgraded == "Any",
        },
        {
            ["Type"] = 1, ["Name"] = "Calamity", ["ID"] = 44933, ["Range"] = 3, ["TargetCast"] = true,
            ["Level"] = PlayerLevel >= 50, ["OtherCheck"] = Plan.Upgraded == "Moon" or Plan.Upgraded == "Any",
        },

        -- Combo Thing
        {
            ["Type"] = 1, ["Name"] = "Avalanche Axe", ["ID"] = 44884, ["Range"] = 3, ["TargetCast"] = true,
            ["Level"] = PlayerLevel >= 4, ["OtherCheck"] = Plan.Axe == 2 or Plan.AxeAny == true,
        },
        {
            ["Type"] = 1, ["Name"] = "Mistral Axe", ["ID"] = 44887, ["Range"] = 3, ["TargetCast"] = true,
            ["Level"] = PlayerLevel >= 8, ["OtherCheck"] = Plan.Axe == 3 or Plan.AxeAny == true,
        },
        {
            ["Type"] = 1, ["Name"] = "Spinning Axe", ["ID"] = 44888, ["Range"] = 3, ["TargetCast"] = true,
            ["Level"] = PlayerLevel >= 14, ["OtherCheck"] = Plan.Axe == 4 or Plan.AxeAny == true,
        },
        {
            ["Type"] = 1, ["Name"] = "Gale Axe", ["ID"] = 44889, ["Range"] = 3, ["TargetCast"] = true,
            ["Level"] = PlayerLevel >= 16, ["OtherCheck"] = Plan.Axe == 1 or Plan.AxeAny == true,
        },

		--Single Target
		{
			["Type"] = 1, ["Name"] = "Shieldsplitter", ["ID"] = 44885, ["Range"] = 3, ["TargetCast"] = true, ["Proc"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Axeblade Bite", ["ID"] = 44883, ["Range"] = 3, ["TargetCast"] = true, ["Proc"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Smash Axe", ["ID"] = 44879, ["Range"] = 3, ["TargetCast"] = true,
		},
	}




	self.SendConsoleMessage(ClassTypeID.."PROFILE END",1)
    return SkillList
end

return Profile
