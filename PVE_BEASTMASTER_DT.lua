local Profile = {}

Profile.Settings = {
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
    local TargetInCombat = Data.TargetInCombat
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


    --[[
        [1]    TPGauge                Beastmaster TP (0–250)
        [2]    FamiliarTPGauge        Familiar TP (0–250)
        [3]    FamiliarTPAtLastUse    Familiar TP before its last action
        [4]    ActiveBattlehorn       Summoned Battlehorn slot (0=none, 1–3=slot)
        [5]    InstinctualComboState  Combo state (7=Wavering Heart)
        [6]    CurrentAffinity       Current affinity (see below)
        [7]    ChainCount            Instinctual combo chain count
        [8]    KinshipKinType        Borrowed kin type (see below)
        [9]    KinshipBattlehorn     Battlehorn slot recorded when Borrow was used
        [10]   NaturalInstinct       Natural Instinct stacks (0–3)
        [11]   MasteredInstinct      Mastered Instinct stacks (0–3)

        Affinity values — gauge[6]:
        0=None, 1=Volant, 2=Rampant, 3=Durant,
        4=Eldritch, 5=Sunstrider, 6=Moonstalker

        Kin types — gauge[8]:
        0=None, 1=Beastkin, 2=Vilekin, 3=Cloudkin, 4=Seedkin,
        5=Wavekin, 6=Scalekin, 7=Soulkin, 8=Ashkin


        HOW THE COMBO ACTUALLY WORKS
        A combo is one of OUR actions plus one of the BEAST's actions inside a
        7 second window -- not two axes of ours. Trick is the beast's action and
        is paid for out of the familiar bar (gauge[2] reads 0 the moment it goes
        out and crawls back at roughly 12 a second); the four axes are ours and
        come out of our own TP (gauge[1]).

        The Inner Compass, and clockwise is the way round it:
            NE Volant > SE Rampant > SW Durant > NW Eldritch > back to NE

        Each intentional combo lights the side of the compass it spans, and the
        two sides of an axis share a name -- sun rises east and sets west, the
        moon takes north and south:
            Volant   > Rampant   East   Sunstrider   (from the job guide)
            Rampant  > Durant    South  Moonstalker  (seen in our own log)
            Durant   > Eldritch  West   Sunstrider   (inferred from the pair above)
            Eldritch > Volant    North  Moonstalker  (inferred)
        Lighting the whole compass wants all four, and that is what sets off the
        big finish -- Infinitive Combo: Universality at 50.

        The chain count under the compass (gauge[7]) raises the extra damage a
        combo deals, so an unbroken run of them is worth more than the same
        number of combos started fresh each time.
        Second action follows the first clockwise  -> Intentional Combo, the
        strong one, which resolves as Sunstrider or Moonstalker.
        Anything else                              -> Instinctual Combo, the
        weak one, named after an affinity. That is what the level 8 quest wants.

        The game has an action per result, which is what the chat log shows:
            44910-44913  Instinctual Combo: Volant / Rampant / Durant / Eldritch
            44914        Intentional Combo: Sunstrider
            44915        Intentional Combo: Moonstalker
            44916        Infinitive Combo: Universality (lv50)

        WHICH DIAMOND WE EARN
        Whichever action finishes the combo decides it:
            finish with our axe    -> Mastered Instinct  (gauge[11], yellow),
                                      spent by Rally (44905, lv28) to refill our TP
            finish with the beast  -> Natural Instinct   (gauge[10], blue),
                                      spent by Rallying Cheer (44904, lv40) to
                                      refill the familiar bar
        Trick first, axe second is the default for that reason: it finishes on
        our action, so it banks the diamonds Rally spends.

        The four axes and the affinity each one applies. Levels are off the
        Action sheet, so at the level 8 quest only Avalanche and Mistral exist:
        44884 = Avalanche Axe - Rampant  (2) - lv4
        44887 = Mistral Axe   - Durant   (3) - lv8
        44888 = Spinning Axe  - Eldritch (4) - lv14
        44889 = Gale Axe      - Volant   (1) - lv16

        Affinity 5 (Sunstrider) and 6 (Moonstalker) are not on the four axe
        wheel because they are what a finished combo leaves behind, not
        something you build towards -- the chat log shows the combo resolving
        and then "You lose the effect of Moonstalker" as it wears off. A chain
        sitting on one of those is done, so Trick opens the next one.

        What the combo is called says which one landed:
          Intentional Combo  - the correct follow up, the axe the wheel wanted
          Instinctual Combo  - a wrong one, which is what the level 8 quest
                               asks for and what CorrectCombo = false does
    ]]


    -- Which affinity correctly follows another. 0 for anything off the wheel.
    local AffinityNext = { [1] = 2, [2] = 3, [3] = 4, [4] = 1, }

    -- And which side of the compass that pairing lights, for the log. Keyed by
    -- the affinity the combo starts from.
    local AffinityResult = { [1] = "Sunstrider (east)", [2] = "Moonstalker (south)",
        [3] = "Sunstrider (west)", [4] = "Moonstalker (north)", }

    -- Quests that want the combo done wrong on purpose. Step 0 means the whole
    -- quest; anything else only while it is sitting on that step.
    local PerQuestOverwrite = {
        {
            ["QuestID"] = 5492, ["Step"] = 1, ["Instinctual"] = true,
        }
    }

    local CurrentAffinity = GaugeData1[6] or 0
    local WantedAffinity = AffinityNext[CurrentAffinity] or 0

    -- True: continue the chain properly. False: deliberately break it, which is
    -- what an "instinctual" quest step asks for.
    -- Anything outside the routine can force the wrong combo by setting this,
    -- which is how the addon drives it -- it already knows the quest state and
    -- Quest is not always reachable from in here.
    local CorrectCombo = true

    -- Same thing off the quest directly, when the API is available.
    if Quest ~= nil and Quest.IsQuestCompleted ~= nil then
        for i,e in pairs(PerQuestOverwrite) do
            local QuestID = e.QuestID
            if QuestID ~= nil and Quest:IsQuestCompleted(QuestID) == false and Quest:HasQuest(QuestID) == true then
                local Step = e.Step or 0
                if Step == 0 or Quest:GetQuestCurrentStep(QuestID) == Step then
                    if e.Instinctual == true then CorrectCombo = false end
                end
            end
        end
    end

    -- Is an axe of this affinity the one to press right now? Correct continues
    -- the wheel, instinctual is anything that does not. Nothing to follow
    -- without an affinity up, which is Trick's job.
    local function AffinityAllowed(Affinity)
        if CurrentAffinity == 0 then return false end
        if CorrectCombo == true then return Affinity == WantedAffinity end
        return Affinity ~= WantedAffinity
    end

    -- Is the affinity one of the four the axes work off? Sunstrider and
    -- Moonstalker are not: they are the result of a combo, so landing on one
    -- means the chain is spent and the next one starts from Trick again.
    local OnWheel = AffinityNext[CurrentAffinity] ~= nil

    -- gauge[4] is the battlehorn slot that is out, 0 for nothing. No familiar
    -- means no job at all: Trick is the beast's half of every combo, so it and
    -- all four axes read as unusable and we are left auto attacking.
    local NoFamiliar = (GaugeData1[4] or 0) == 0

    -- Trick is what applies an affinity, so it goes out when there is nothing
    -- to follow -- either nothing up at all, or a chain that has resolved. It
    -- spends familiar TP: the bar reads 0 straight after it and crawls back at
    -- roughly 12 a second, so both bars want to be up first.
    local TrickReady = OnWheel == false
        and (GaugeData1[1] or 0) >= 100
        and (GaugeData1[2] or 0) >= 100

    -- The axes follow Trick, so being on the wheel is the only gate they get.
    -- The familiar bar is the one Trick just emptied: gating them on it is what
    -- kept all four silent for the eight seconds it takes to refill. Whether
    -- they can actually be cast is the ACR's Ready check, not ours.
    local ComboReady = OnWheel

    -- The whole gauge, printed only when a value actually moves. Watching this
    -- against the chat log is the quickest way to pin down what each action
    -- does: which field the Heart lives in, when the chain counts up, and
    -- whether Trick's affinity follows the pet.
    local GaugeLine = "BST gauge: TP "..tostring(GaugeData1[1])
        .." fam "..tostring(GaugeData1[2]).."/"..tostring(GaugeData1[3])
        .." horn "..tostring(GaugeData1[4])
        .." state "..tostring(GaugeData1[5])
        .." affinity "..tostring(GaugeData1[6])
        .." chain "..tostring(GaugeData1[7])
        .." kin "..tostring(GaugeData1[8]).."/"..tostring(GaugeData1[9])
        .." instinct "..tostring(GaugeData1[10]).."/"..tostring(GaugeData1[11])
        .."  -> wants affinity "..tostring(WantedAffinity)
        .." for "..tostring(AffinityResult[CurrentAffinity] or "nothing")
        .." correct combo "..tostring(CorrectCombo)
        -- horn 0 means no familiar is out, and without one none of this works:
        -- Trick is the beast's action, so everything reads as not ready.
        ..(GaugeData1[4] == 0 and "  NO PET OUT" or "")
        .."  target "..tostring(math.round(TargetDistance or 0,1)).."y"
        .." combat "..tostring(PlayerInCombat)
    if Profile.LastGaugeLine ~= GaugeLine then
        Profile.LastGaugeLine = GaugeLine
        d(GaugeLine)
    end

	local SkillList = {

        -- Nothing out? Call something. All three horns do the same job and each
        -- carries its own 90 second cooldown, which is why there are three --
        -- listed in order so whichever is up goes. Casting one while a familiar
        -- is already out recalls it, hence the gauge check.
        {
            ["Type"] = 2, ["Name"] = "First Battlehorn", ["ID"] = 44881, ["Range"] = 0, ["TargetCast"] = false,
            ["Level"] = PlayerLevel >= 1,
            ["OtherCheck"] = NoFamiliar,
        },
        {
            ["Type"] = 2, ["Name"] = "Second Battlehorn", ["ID"] = 44892, ["Range"] = 0, ["TargetCast"] = false,
            ["Level"] = PlayerLevel >= 10,
            ["OtherCheck"] = NoFamiliar,
        },
        {
            ["Type"] = 2, ["Name"] = "Third Battlehorn", ["ID"] = 44894, ["Range"] = 0, ["TargetCast"] = false,
            ["Level"] = PlayerLevel >= 20,
            ["OtherCheck"] = NoFamiliar,
        },

        -- Trick first: it puts up the affinity the axes then follow.
        {
            ["Type"] = 1, ["Name"] = "Trick", ["ID"] = 47093, ["Range"] = 3, ["TargetCast"] = true, ["OtherCheck"] = TrickReady,
        },

        -- Combo Thing
        {
            ["Type"] = 1, ["Name"] = "Avalanche Axe", ["ID"] = 44884, ["Range"] = 3, ["TargetCast"] = true, ["OtherCheck"] = ComboReady and AffinityAllowed(2),
        },
        {
            ["Type"] = 1, ["Name"] = "Mistral Axe", ["ID"] = 44887, ["Range"] = 3, ["TargetCast"] = true, ["OtherCheck"] = ComboReady and AffinityAllowed(3),
        },
        {
            ["Type"] = 1, ["Name"] = "Spinning Axe", ["ID"] = 44888, ["Range"] = 3, ["TargetCast"] = true, ["OtherCheck"] = ComboReady and AffinityAllowed(4),
        },
        {
            ["Type"] = 1, ["Name"] = "Gale Axe", ["ID"] = 44889, ["Range"] = 3, ["TargetCast"] = true, ["OtherCheck"] = ComboReady and AffinityAllowed(1),
        },

        -- Rally spends a Mastered Instinct diamond to refill our TP. Held for
        -- when the bar is actually low, otherwise the diamond is wasted.
        {
            ["Type"] = 2, ["Name"] = "Rally", ["ID"] = 44905, ["Range"] = 0, ["TargetCast"] = false,
            ["Level"] = PlayerLevel >= 28,
            ["OtherCheck"] = (GaugeData1[11] or 0) >= 1 and (GaugeData1[1] or 0) <= 100,
        },

        -- Rallying Cheer does the same for the familiar bar, which is what pays
        -- for Trick -- so a dry familiar bar is the whole rotation stalling.
        {
            ["Type"] = 2, ["Name"] = "Rallying Cheer", ["ID"] = 44904, ["Range"] = 0, ["TargetCast"] = false,
            ["Level"] = PlayerLevel >= 40,
            ["OtherCheck"] = (GaugeData1[10] or 0) >= 1 and (GaugeData1[2] or 0) <= 100,
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
