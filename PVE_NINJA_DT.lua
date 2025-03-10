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
        ["Setting"] = "SingleMudraType",
        ["Options"] = {
            { ["Name"] = "Raiton", ["Tooltip"] = "Raiton", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Fuma", ["Tooltip"] = "Fuma", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Hyoton", ["Tooltip"] = "Hyoton", ["Colour"] = { ["r"] = 0, ["g"] = 0, ["b"] = 1, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "AOEMudraType",
        ["Options"] = {
            { ["Name"] = "Katon", ["Tooltip"] = "Katon", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Huton", ["Tooltip"] = "Huton", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
        },
    },
    {
        ["Setting"] = "Doton",
        ["Options"] = {
            { ["Name"] = "Doton OFF", ["Tooltip"] = "Doton OFF", ["Colour"] = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1 }, },
            { ["Name"] = "Doton ON", ["Tooltip"] = "Doton ON", ["Colour"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1 }, },
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
    local LastCastTime = Data.LastCastTime
    local LastCombo = Data.LastCombo
    local CurrentChannel = Data.CurrentChannel
    local GaugeData1 = Data.GaugeData1
    local GaugeData2 = Data.GaugeData2
    local AOETimeout = Data.AOETimeout
    local JumpTimeout = Data.JumpTimeout
    local CastTimeout = Data.CastTimeout
    local PositionToTarget = Data.PositionToTarget
	
    local HasDotonBuff = self.TargetBuff2(Player,501,0,"Has",PlayerID)
	local HasMudraBuff = self.TargetBuff2(Player,{496,497},0,"Has",PlayerID)
	local HasSuitonBuff = self.TargetBuff2(Player,3848,0,"Has",PlayerID)
	local HasKassatsuBuff = self.TargetBuff2(Player,497,0,"Has",PlayerID)
	local HasTenChiJinBuff = self.TargetBuff2(Player,1186,0,"Has",PlayerID)
	local HasMeisuiBuff = self.TargetBuff2(Player,2689,0,"Has",PlayerID)
	local HasActiveMudraSkill = self.TargetBuff2(Player,2689,0,"Has",PlayerID)
	local TargetHasTrickAttack = self.TargetBuff2(Target,{3254,638},1,"Has",PlayerID)

	--d("HasDotonBuff: "..tostring(HasDotonBuff))
	--d("HasMudraBuff: "..tostring(HasMudraBuff))	
	--d("HasSuitonBuff: "..tostring(HasSuitonBuff))
	--d("HasKassatsuBuff: "..tostring(HasKassatsuBuff))
	--d("HasTenChiJinBuff: "..tostring(HasTenChiJinBuff))
	--d("HasMeisuiBuff: "..tostring(HasMeisuiBuff))
	--d("HasActiveMudraSkill: "..tostring(HasActiveMudraSkill))
	--d("TargetHasTrickAttack: "..tostring(TargetHasTrickAttack))
	
	local AttackableTarget = false
	if table.valid(Target) == true then
		AttackableTarget = Target.attackable
	end

	local MudraActions = {
		[2259] = "Ten",
		[2261] = "Chi",
		[2263] = "Jin",
		[18805] = "Ten",
		[18806] = "Chi",
		[18807] = "Jin",
		[2264] = "Kassatsu",
		[7403] = "Ten Chi Jin",
		[18873] = "Fuma",
		[18877] = "Raiton",
		[18881] = "Suiton",
	}

	local LastActionWasMudra = MudraActions[CurrentCast] ~= nil or MudraActions[LastCast] ~= nil
	
	if HasMudraBuff == false and HasKassatsuBuff == false and (LastActionWasMudra == false or LastCastTime > 500) then 
		--d("---------------------- RESET 1")
		--self.NinjaLastMudra = 0 
		LastActionWasMudra = false 
	end

	if HasMudraBuff == true and LastActionWasMudra == true and (LastCastTime > 5000 or (LastCastTime > 1500 and HasActiveMudraSkill)) then 
		--d("---------------------- RESET 2")
		--self.NinjaLastMudra = 0 
		LastActionWasMudra = false 
	end

	local Meisui = ActionList:Get(1,16489)
	local TrickAttack = ActionList:Get(1,2258)
	if self.NinjaLastMudra == 2 and TrickAttack.cd + 5 < TrickAttack.cdmax then
		--self.NinjaLastMudra = 0
		--d("Trick Mudra Clear")
	end

	local Kassatsu = ActionList:Get(1,2264)
	local Ten = ActionList:Get(1,2259)
	local MudraCurrentCharges = math.floor((Ten.cdmax /Ten.recasttime) - ((Ten.cdmax - Ten.cd) / Ten.recasttime))
	if Ten.isoncd == false or HasMudraBuff == true or HasKassatsuBuff == true then MudraCurrentCharges = 1 end

	--[[
		2240    Spinning Edge           ROG NIN
		2241    Shade Shift             ROG NIN
		2242    Gust Slash              ROG NIN
		2245    Hide                    ROG NIN
		2246    Assassinate             NIN
		2247    Throwing Dagger         ROG NIN
		2248    Mug                     ROG NIN
		2254    Death Blossom           ROG NIN
		2255    Aeolian Edge            ROG NIN
		2258    Trick Attack            ROG NIN
		2259    Ten                     NIN
		2260    Ninjutsu                NIN
		2261    Chi                     NIN
		2262    Shukuchi                NIN
		2263    Jin                     NIN
		2264    Kassatsu                NIN
		2265    Fuma Shuriken           NIN
		2266    Katon                   NIN
		2267    Raiton                  NIN
		2268    Hyoton                  NIN
		2269    Huton                   NIN
		2270    Doton                   NIN
		2271    Suiton                  NIN
		2272    Rabbit Medium           NIN
		3563    Armor Crush             NIN
		3566    Dream Within a Dream    NIN
		7401    Hellfrog Medium         NIN
		7402    Bhavacakra              NIN
		7403    Ten Chi Jin             NIN
		16488   Hakke Mujinsatsu        NIN
		16489   Meisui                  NIN
		16491   Goka Mekkyaku           NIN
		16492   Hyosho Ranryu           NIN
		16493   Bunshin                 NIN
		17413   Spinning Edge           NIN
		17414   Gust Slash              NIN
		17415   Aeolian Edge            NIN
		17417   Armor Crush             NIN
		17418   Throwing Dagger         NIN
		17419   Death Blossom           NIN
		17420   Hakke Mujinsatsu        NIN
		18805   Ten                     NIN
		18806   Chi                     NIN
		18807   Jin                     NIN
		18873   Fuma Shuriken           NIN
		18874   Fuma Shuriken           NIN
		18875   Fuma Shuriken           NIN
		18876   Katon                   NIN
		18877   Raiton                  NIN
		18878   Hyoton                  NIN
		18879   Huton                   NIN
		18880   Doton                   NIN
		18881   Suiton                  NIN
		25774   Phantom Kamaitachi      NIN
		25775   Phantom Kamaitachi      NIN
		25776   Hollow Nozuchi          NIN
		25777   Forked Raiju            NIN
		25778   Fleeting Raiju          NIN
		25878   Forked Raiju            NIN
		25879   Fleeting Raiju          NIN
		36957   Dokumori                NIN
		36958   Kunai's Bane            NIN
		36959   Deathfrog Medium        NIN
		36960   Zesho Meppo             NIN
		36961   Tenri Jindo             NIN
	]]


	local MudraCurrentCharges = math.floor((Ten.cdmax / Ten.recasttime) - ((Ten.cdmax - Ten.cd) / Ten.recasttime))
	if Ten.isoncd == false or HasMudraBuff == true or HasKassatsuBuff == true then
		MudraCurrentCharges = 1
	end
	local AOEType = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0 }
	local EnemiesAroundSelf = self.EntityInCount(AOEType)
	local EnemiesAroundTarget = 0
	if table.valid(Target) == true then
		local AOEType2 = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 5, ["MaxDistance"] = 20, ["LineWidth"] = 0, ["Angle"] = 0 }
		EnemiesAroundTarget = self.EntityInCount(AOEType2)
	end

	local function DetermineRequestedMudraActionV2()
		
		local GeneralCheck = HasSuitonBuff == false and MudraCurrentCharges > 0 and ((TrickAttack.cd ~= 0 and TrickAttack.cd + 10 < TrickAttack.cdmax) or (PlayerLevel >= 72 and GaugeData1[1] < 50 and Meisui.cd ~= 0 and Meisui.cd + 10 < Meisui.cdmax))

		d("PlayerLevel: "..tostring(PlayerLevel >= 72))
		d("GaugeData1[1] < 50: "..tostring(GaugeData1[1] < 50))
		d("Meisui.cd: "..tostring(Meisui.cd))
		d("Meisui.cdmax: "..tostring(Meisui.cdmax))
		d("TrickAttack.cd: "..tostring(TrickAttack.cd))
		d("TrickAttack.cdmax: "..tostring(TrickAttack.cdmax))
		d("EnemiesAroundSelf: "..tostring(EnemiesAroundSelf))
		d("AttackableTarget: "..tostring(AttackableTarget))
		d("table.valid(Target): "..tostring(table.valid(Target)))
		
		if EnemiesAroundSelf == 0 and (table.valid(Target) == false or AttackableTarget == false) then
			return nil
		end
		if HasTenChiJinBuff == true then
			if EnemiesAroundTarget > 2 and self.GetSettingsValue(ClassTypeID, "AOEMudraType") == 1 and self.GetSettingsValue(ClassTypeID, "AOE") == 1 and AOETimeout == false then
				return "Ten Chi Jin AOE"
			else
				return "Ten Chi Jin Single"
			end
		end

		if MudraCurrentCharges == 0 then
			return nil
		end

		if PlayerLevel >= 45 and (PlayerLevel < 76 or HasKassatsuBuff == false) and AttackableTarget == true and HasSuitonBuff == false and (TrickAttack.cd + 2 > TrickAttack.cdmax) or (Meisui.cd + 2 > Meisui.cdmax) and MudraCurrentCharges > 0 then
			return "Suiton"
		elseif PlayerLevel >= 35 and (PlayerLevel < 76 or HasKassatsuBuff == false) and LastCast ~= 2270 and EnemiesAroundSelf > 2 and HasDotonBuff == false and PlayerMoving == false and GeneralCheck == true and self.GetSettingsValue(ClassTypeID, "Doton") == 1 and self.GetSettingsValue(ClassTypeID, "AOE") == 1 and AOETimeout == false then
			return "Doton"
		elseif PlayerLevel >= 35 and (PlayerLevel < 76 or HasKassatsuBuff == false) and AttackableTarget == true and EnemiesAroundTarget > 2 and GeneralCheck == true and self.GetSettingsValue(ClassTypeID, "AOEMudraType") == 1 and self.GetSettingsValue(ClassTypeID, "AOE") == 1 and AOETimeout == false then
			return "Katon"
		elseif PlayerLevel >= 45 and (PlayerLevel < 76 or HasKassatsuBuff == false) and AttackableTarget == true and EnemiesAroundTarget > 2 and GeneralCheck == true and self.GetSettingsValue(ClassTypeID, "AOEMudraType") == 2 and self.GetSettingsValue(ClassTypeID, "AOE") == 1 and AOETimeout == false then
			return "Huton"
		elseif PlayerLevel >= 32 and (PlayerLevel < 76 or HasKassatsuBuff == false) and AttackableTarget == true and GeneralCheck == true and self.GetSettingsValue(ClassTypeID, "SingleMudraType") == 1 then
			return "Raiton"
		elseif PlayerLevel >= 30 and (PlayerLevel < 76 or HasKassatsuBuff == false) and AttackableTarget == true and GeneralCheck == true and self.GetSettingsValue(ClassTypeID, "SingleMudraType") == 2 then
			return "Fuma"
		elseif PlayerLevel >= 45 and (PlayerLevel < 76 or HasKassatsuBuff == false) and AttackableTarget == true and GeneralCheck == true and self.GetSettingsValue(ClassTypeID, "SingleMudraType") == 3 then
			return "Hyoton"
		elseif PlayerLevel >= 96 and AttackableTarget == true and GeneralCheck == true and HasKassatsuBuff == true and EnemiesAroundTarget <= 2 then
			return "Hyosho Ranryu"
		elseif PlayerLevel >= 76 and AttackableTarget == true and GeneralCheck == true and HasKassatsuBuff == true and EnemiesAroundTarget > 2  then
			return "Goka Mekkyaku"
		end
		return nil
	end
	
	local RequestedMudraAction = DetermineRequestedMudraActionV2()
	d("RequestedMudraAction: "..tostring(RequestedMudraAction))








	if self.LastMudras == nil then self.LastMudras = {} end
	if self.LastCast == nil then self.LastCast = 0 end

	local Ten = ActionList:Get(1,2259)
	local Chi = ActionList:Get(1,2261)
	local Jin = ActionList:Get(1,2263)
	local Ten2 = ActionList:Get(1,18805)
	local Chi2 = ActionList:Get(1,18806)
	local Jin2 = ActionList:Get(1,18807)
	d("Ten: "..tostring(Ten:IsReady(Player)))
	d("Chi: "..tostring(Chi:IsReady(Player)))
	d("Jin: "..tostring(Jin:IsReady(Player)))
	d("Ten2: "..tostring(Ten2:IsReady(Player)))
	d("Chi2: "..tostring(Chi2:IsReady(Player)))
	d("Jin2: "..tostring(Jin2:IsReady(Player)))
	
	
	-- Actions
	local MudraActions = {
		{ ["ID2"] = 18875, ["ID"] = 2265, ["Name"] = "Fuma", ["Combo"] = {"Ten"} },

		{ ["ID2"] = 18876, ["ID"] = 2266, ["Name"] = "Katon", ["Combo"] = {"Chi", "Ten"}, ["Combo2"] = {"Jin", "Ten"} },
		{ ["ID2"] = 18877, ["ID"] = 2267, ["Name"] = "Raiton", ["Combo"] = {"Ten", "Chi"}, ["Combo2"] = {"Chi", "Ten"} },
		{ ["ID2"] = 18878, ["ID"] = 2268, ["Name"] = "Hyoton", ["Combo"] = {"Ten", "Jin"}, ["Combo2"] = {"Chi", "Jin"} },

		{ ["ID2"] = 18879, ["ID"] = 2269, ["Name"] = "Huton", ["Combo"] = {"Jin", "Chi", "Ten"}, ["Combo2"] = {"Chi", "Jin", "Ten"} },
		{ ["ID2"] = 18880, ["ID"] = 2270, ["Name"] = "Doton", ["Combo"] = {"Ten", "Jin", "Chi"}, ["Combo2"] = {"Jin", "Ten", "Chi"} },
		{ ["ID2"] = 18881, ["ID"] = 2271, ["Name"] = "Suiton", ["Combo"] = {"Ten", "Chi", "Jin"}, ["Combo2"] = {"Chi", "Ten", "Jin"} },

		{ ["Name"] = "Ten Chi Jin AOE", ["Combo"] = {"Ten", "Chi", "Jin"}, ["Combo2"] = {"Chi", "Ten", "Jin"} },
		{ ["Name"] = "Ten Chi Jin Single", ["Combo"] = {"Ten", "Chi", "Jin"}, ["Combo2"] = {"Chi", "Ten", "Jin"} },
		-- "Ten Chi Jin Single"

		-- Kass
		{ ["ID"] = 16491, ["Name"] = "Goka Mekkyaku", ["Combo"] = {"Chi", "Ten"}, ["Combo2"] = {"Jin", "Ten"} },
		{ ["ID"] = 16492, ["Name"] = "Hyosho Ranryu", ["Combo"] = {"Ten","Jin"}, ["Combo2"] = {"Chi","Jin"} },
	}
	
	for i,e in pairs(MudraActions) do
		if e.ID ~= nil then
			e.Action = ActionList:Get(1,e.ID)
			e.ActionReady = e.Action:IsReady(TargetID)
			d(e.Name..": "..tostring(e.ActionReady))
		else
			e.ActionReady = false
		end
	end

	local ValidMudraIDs = {
		[2259] = true,
		[2261] = true,
		[2263] = true,
		[18805] = true,
		[18806] = true,
		[18807] = true,

		[18873] = true,
		[18874] = true,
		[18875] = true,
		[18876] = true,
		[18877] = true,
		[18878] = true,
		[18879] = true,
		[18880] = true,
		[18881] = true,
	}

	local HasMudraBuff = self.TargetBuff2(Player,{496,497},0,"Has",PlayerID)
	d("HasMudraBuff: "..tostring(HasMudraBuff))
	d("HasTenChiJinBuff: "..tostring(HasTenChiJinBuff))
	local LastCastID = Data.LastCast
	if LastCast ~= self.LastCast then
		self.LastCast = LastCast
		d("New Cast: "..tostring(LastCast))
		if ValidMudraIDs[LastCast] == true then
			table.insert(self.LastMudras,LastCast)
		end
	end

	if HasMudraBuff == false and HasTenChiJinBuff == false then
		self.LastMudras = {}
		self.RequestedMudraAction = nil
	elseif table.valid(self.LastMudras) == false and (HasMudraBuff == true or HasTenChiJinBuff == true) then
		if ValidMudraIDs[LastCast] == true then
			table.insert(self.LastMudras,LastCast)
		end
	end
	if self.RequestedMudraAction == nil then self.RequestedMudraAction = RequestedMudraAction end
	d("self.RequestedMudraAction: "..tostring(self.RequestedMudraAction))

	local function GetNextMudraAction(RequestedMudraAction2, LastMudras)
		local actionData = nil
		for _, action in ipairs(MudraActions) do
			if action.Name == RequestedMudraAction2 then
				actionData = action
				break
			end
		end
		if not actionData then
			d("Requested Mudra Action not found: " .. tostring(RequestedMudraAction2))
			return nil
		end
		local combo = actionData.Combo
		local nextMudraIndex = #LastMudras + 1  -- Determine the next step in the combo
		if nextMudraIndex <= #combo then
			return combo[nextMudraIndex]
		else
			return actionData.Action
		end
	end



	d("MudraCurrentCharges: "..MudraCurrentCharges)
	d("self.LastMudras")
	d(self.LastMudras)
	
	local NextAction = GetNextMudraAction(self.RequestedMudraAction, self.LastMudras)
	if NextAction then
		if type(NextAction) == "string" then
			-- It's the next Mudra
			d("Next Mudra to use: " .. NextAction)
			local IsOnCD = Ten:IsReady(PlayerID) == false and Chi:IsReady(PlayerID) == false and Jin:IsReady(PlayerID) == false and Ten2:IsReady(PlayerID) == false and Chi2:IsReady(PlayerID) == false and Jin2:IsReady(PlayerID) == false
			local IsOnCD2 = Ten:IsReady(TargetID) == false and Chi:IsReady(TargetID) == false and Jin:IsReady(TargetID) == false and Ten2:IsReady(TargetID) == false and Chi2:IsReady(TargetID) == false and Jin2:IsReady(TargetID) == false
			if IsOnCD == false then
				if NextAction == "Ten" then
					Ten:Cast(PlayerID)
				elseif NextAction == "Chi" then
					Chi:Cast(PlayerID)
				elseif NextAction == "Jin" then
					Jin:Cast(PlayerID)
				end
			elseif HasTenChiJinBuff == true then
				d("Next: "..NextAction)
				if NextAction == "Ten" then
					Ten:Cast(TargetID)
				elseif NextAction == "Chi" then
					Chi:Cast(TargetID)
				elseif NextAction == "Jin" then
					Jin:Cast(TargetID)
				end
			else
				d("Mudra is on cooldown")
			end
		else
			d("Final action to execute: " .. NextAction.name.." - "..NextAction.id.. " - "..tostring(NextAction:IsReady(TargetID)))
			NextAction:Cast(TargetID)  -- Execute the action
		end
		return
	end


	local SkillList = {
		{
			["Type"] = 1, ["Name"] = "Kunai's Bane", ["ID"] = 36958, ["Range"] = 5, ["TargetCast"] = true,
		},
		{
			["Type"] = 1, ["Name"] = "Trick Attack", ["ID"] = 2258, ["Range"] = 5, ["TargetCast"] = true, ["OtherCheck"] = PositionToTarget == "Rear",
		},
		{
			["Type"] = 1, ["Name"] = "Meisui", ["ID"] = 16489, ["Range"] = 5, ["TargetCast"] = false, ["OtherCheck"] = GaugeData1[1] < 50,
		},
		{
			["Type"] = 1, ["Name"] = "Kassatsu", ["ID"] = 2264, ["Range"] = 5, ["TargetCast"] = false, ["OtherCheck"] = MudraCurrentCharges == 0,
		},

		--{
		--	["Type"] = 1, ["Name"] = "Ten Chi Jin", ["ID"] = 7403, ["Range"] = 5, ["TargetCast"] = false, ["OtherCheck"] = MudraCurrentCharges == 0 and HasKassatsuBuff == false,
		--},
		    
		--{
		--	["Type"] = 1, ["Name"] = "Trick Attack", ["ID"] = 2258, ["Range"] = 5, ["TargetCast"] = true, ["OtherCheck"] = LastActionWasMudra == false and (PositionToTarget == "Flank" or PositionToTarget == "Front"),
		--},
		    
		{
			["Type"] = 1, ["Name"] = "Fleeting Raiju", ["ID"] = 25778, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = LastActionWasMudra == false, ["Buff"] = HasMudraBuff == false and HasTenChiJinBuff == false,
		},
		   
		{
			["Type"] = 1, ["Name"] = "Tenri Jindo", ["ID"] = 36961, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = LastActionWasMudra == false, ["Buff"] = HasMudraBuff == false and HasTenChiJinBuff == false,
		},

		{
			["Type"] = 1, ["Name"] = "Phantom Kamaitachi", ["ID"] = 25774, ["Range"] = 20, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = LastActionWasMudra == false and PlayerInCombat == true and NextAction == nil,
			["Buff"] = HasMudraBuff == false and HasTenChiJinBuff == false,
		},

		-- AOE
		{
			["Type"] = 2, ["Name"] = "Death Blossom", ["ID"] = 2254, ["Range"] = 0, ["TargetCast"] = false, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["Buff"] = HasMudraBuff == false and HasTenChiJinBuff == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, }, ["OtherCheck"] = LastActionWasMudra == false,
			["ComboIDNOT"] = { [2254] = PlayerLevel >= 52 }, --["ComboID"] = { [0] = true, [2254] = PlayerLevel < 52, [16488] = true, },
		},
		{
			["Type"] = 2, ["Name"] = "Hakke Mujinsatsu", ["ID"] = 16488, ["Range"] = 0, ["TargetCast"] = false, ["ComboID"] = { [2254] = true, }, ["AOECount"] = 3, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"AOE") == 1 and AOETimeout == false, ["Buff"] = HasMudraBuff == false and HasTenChiJinBuff == false,
			["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = PlayerPOS, ["AOERange"] = 5, ["MaxDistance"] = 0, ["LineWidth"] = 0, ["Angle"] = 0, }, ["OtherCheck"] = LastActionWasMudra == false,
		},

	   -- Single Target
		{
			["Type"] = 1, ["Name"] = "Spinning Edge", ["ID"] = 2240, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = LastActionWasMudra == false, ["Buff"] = HasMudraBuff == false and HasTenChiJinBuff == false,
			["ComboIDNOT"] = { [2240] = PlayerLevel >= 4, [2242] = PlayerLevel >= 26, }, 
		},
		{
			["Type"] = 1, ["Name"] = "Gust Slash", ["ID"] = 2242, ["Range"] = 25, ["TargetCast"] = true, ["ComboID"] = { [2240] = true, }, ["OtherCheck"] = LastActionWasMudra == false, ["Buff"] = HasMudraBuff == false and HasTenChiJinBuff == false,
		},
		{
			["Type"] = 1, ["Name"] = "Armor Crush", ["ID"] = 3563, ["Range"] = 25, ["TargetCast"] = true, ["ComboID"] = { [2242] = true, }, ["OtherCheck"] = LastActionWasMudra == false and (PositionToTarget == "Flank" or PositionToTarget == "Front"), ["Buff"] = HasMudraBuff == false and HasTenChiJinBuff == false,
		},
		{
			["Type"] = 1, ["Name"] = "Aeolian Edge", ["ID"] = 2255, ["Range"] = 25, ["TargetCast"] = true, ["ComboID"] = { [2242] = true, }, ["OtherCheck"] = LastActionWasMudra == false and (PositionToTarget == "Rear" or PositionToTarget == "Front"), ["Buff"] = HasMudraBuff == false and HasTenChiJinBuff == false,
		},

		{
			["Type"] = 1, ["Name"] = "Throwing Dagger", ["ID"] = 2247, ["Range"] = 25, ["TargetCast"] = true, ["OtherCheck"] = LastActionWasMudra == false, ["Buff"] = HasMudraBuff == false and HasTenChiJinBuff == false,
		},
		{
			["Type"] = 1, ["Name"] = "Dream Within a Dream", ["ID"] = 3566, ["Range"] = 3, ["TargetCast"] = true, ["OtherCheck"] = LastActionWasMudra == false, ["Buff"] = HasMudraBuff == false and HasTenChiJinBuff == false and TargetHasTrickAttack == true,
		},

		{
			["Type"] = 1, ["Name"] = "Mug", ["ID"] = 2248, ["Range"] = 3, ["TargetCast"] = true, ["OtherCheck"] = GaugeData1[1] < 50 and LastActionWasMudra == false, ["Buff"] = HasMudraBuff == false and HasTenChiJinBuff == false,
		},

		
		{
			["Type"] = 1, ["Name"] = "Bhavacakra", ["ID"] = 7402, ["Range"] = 3, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = LastActionWasMudra == false and PlayerInCombat == true and NextAction == nil,
			["Buff"] = HasMudraBuff == false and HasTenChiJinBuff == false and HasMeisuiBuff == true,
		},
        
		{
			["Type"] = 1, ["Name"] = "Bunshin", ["ID"] = 16493, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = LastActionWasMudra == false and PlayerInCombat == true and NextAction == nil,
			["Buff"] = HasMudraBuff == false and HasTenChiJinBuff == false,
		},
		{
			["Type"] = 1, ["Name"] = "Hellfrog Medium", ["ID"] = 7401, ["Range"] = 25, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = LastActionWasMudra == false and PlayerInCombat == true and NextAction == nil,
			["Buff"] = HasMudraBuff == false and HasTenChiJinBuff == false,
			["AOECount"] = PlayerLevel >= 68 and 1 or 3, ["AOEType"] = { ["Filter"] = "Enemy", ["Name"] = "Circle", ["TargetPoint"] = TargetPOS, ["AOERange"] = 6, ["MaxDistance"] = 25, ["LineWidth"] = 0, ["Angle"] = 0, },
		},
		{
			["Type"] = 1, ["Name"] = "Bhavacakra", ["ID"] = 7402, ["Range"] = 3, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = LastActionWasMudra == false and PlayerInCombat == true and NextAction == nil,
			["Buff"] = HasMudraBuff == false and HasTenChiJinBuff == false,
		},
        
		-- Shared CDS
		{
			["Type"] = 1, ["Name"] = "Feint", ["ID"] = 7549, ["Range"] = 0, ["TargetCast"] = true, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = LastActionWasMudra == false and PlayerInCombat == true, ["Buff"] = HasMudraBuff == false and HasTenChiJinBuff == false,
		},
		{
			["Type"] = 1, ["Name"] = "Bloodbath", ["ID"] = 7542, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = LastActionWasMudra == false and PlayerInCombat == true and PlayerHP < 50, ["Buff"] = HasMudraBuff == false and HasTenChiJinBuff == false,
		},
		{
			["Type"] = 1, ["Name"] = "Second Wind", ["ID"] = 7541, ["Range"] = 0, ["TargetCast"] = false, ["SettingValue"] = self.GetSettingsValue(ClassTypeID,"CDs") == 1, ["OtherCheck"] = LastActionWasMudra == false and PlayerInCombat == true and PlayerHP < 30, ["Buff"] = HasMudraBuff == false and HasTenChiJinBuff == false,
		},

	}
	
	self.SendConsoleMessage(ClassTypeID.."PROFILE END",1)
    return SkillList
end

return Profile