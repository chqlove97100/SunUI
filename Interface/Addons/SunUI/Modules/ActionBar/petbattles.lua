local S, L, DB, _, C = unpack(select(2, ...))
local PB = LibStub("AceAddon-3.0"):GetAddon("SunUI"):NewModule("PetBattle", "AceEvent-3.0", "AceHook-3.0")
local SunUIConfig = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("SunUIConfig")
local btnsize = 48
local unitsize = 36
local testmode = false
local MAX_PET_LEVEL = 25
local media = {
	["backdrop"] = "Interface\\ChatFrame\\ChatFrameBackground", -- default backdrop
	["checked"] = "Interface\\AddOns\\SunUI\\Media\\CheckButtonHilight", -- replace default checked texture
	["glow"] = DB.GlowTex, -- glow/shadow texture
	["texture"] = DB.Statusbar, -- statusbar texture
}
local frame = PetBattleFrame
local bf = frame.BottomFrame
local first = true
local r, g, b = DB.MyClassColor.r,  DB.MyClassColor.g,  DB.MyClassColor.b
local tooltips = {PetBattlePrimaryAbilityTooltip, PetBattlePrimaryUnitTooltip, FloatingBattlePetTooltip, BattlePetTooltip, FloatingPetBattleAbilityTooltip}
local units = {frame.ActiveAlly, frame.ActiveEnemy}
local extraUnits = {frame.Ally2, frame.Ally3, frame.Enemy2, frame.Enemy3}
local allunit = {
	frame.ActiveAlly, frame.ActiveEnemy, frame.Ally2, frame.Ally3, frame.Enemy2, frame.Enemy3
}
local frames = {
	"alDamageMeterFrame",
	"SkadaBarWindowSkada",
	"NumerationFrame",
	"SunUIExpBar",
}
if testmode then frame:Show() end
local bar = CreateFrame("Frame", "SunUIPetBattleActionBar", UIParent, "SecureHandlerStateTemplate")
local function SkinPetTooltip(tt)
	tt.Background:SetTexture(nil)
	if tt.Delimiter1 then
		tt.Delimiter1:SetTexture(nil)
		tt.Delimiter2:SetTexture(nil)
	elseif tt.Delimiter then
		tt.Delimiter:SetTexture(nil)
	end
	if tt.HealthBorder then
		tt.HealthBorder:SetTexture(nil)
		if not tt.hbd then
			tt.hbd = CreateFrame("Frame", nil, tt)
			tt.hbd:SetPoint("TOPLEFT", tt.HealthBorder, "TOPLEFT", 0, 0)
			tt.hbd:SetPoint("BOTTOMRIGHT", tt.HealthBorder, "BOTTOMRIGHT", 0, -1)
			tt.hbd:SetFrameLevel(0)
			S.CreateBD(tt.hbd)
		end
	end
	if tt.HealthBG then
		tt.HealthBG:SetTexture(nil)
	end
	if tt.XPBorder then
		tt.XPBorder:SetTexture(nil)
	end
	if tt.XPBG then
		tt.XPBG:SetTexture(nil)
	end
	if tt.ActualHealthBar then
		tt.ActualHealthBar:SetTexture(DB.Statusbar)
	end
	if tt.XPBar then
		tt.XPBar:SetTexture(DB.Statusbar)
		if not tt.xpbd then
			tt.xpbd = CreateFrame("Frame", nil, tt)
			tt.xpbd:SetPoint("TOPLEFT", tt.XPBorder, "TOPLEFT", 0, 0)
			tt.xpbd:SetPoint("BOTTOMRIGHT", tt.XPBorder, "BOTTOMRIGHT", 0, 0)
			tt.xpbd:SetFrameLevel(0)
			S.CreateBD(tt.xpbd)
		end
	end
	
	if tt.Icon then
		tt.Icon:SetTexCoord(.08, .92, .08, .92)
		if not tt.iconbd then
			tt.iconbd = CreateFrame("Frame", nil, tt)
			tt.iconbd:SetPoint("TOPLEFT", tt.Icon, "TOPLEFT", -1, 1)
			tt.iconbd:SetPoint("BOTTOMRIGHT", tt.Icon, "BOTTOMRIGHT", 1, -1)
			S.CreateBD(tt.iconbd)
		end
	end
	if tt.Border then
		tt.Border:Kill()
	end
	tt.BorderTop:SetTexture(nil)
	tt.BorderTopLeft:SetTexture(nil)
	tt.BorderTopRight:SetTexture(nil)
	tt.BorderLeft:SetTexture(nil)
	tt.BorderRight:SetTexture(nil)
	tt.BorderBottom:SetTexture(nil)
	tt.BorderBottomRight:SetTexture(nil)
	tt.BorderBottomLeft:SetTexture(nil)
	
	tt:SetBackdrop(nil)
	local border = CreateFrame("Frame", nil, tt)
	border:SetPoint("TOPLEFT", -1, 1)
	border:SetPoint("TOPRIGHT", 1, 1)
	border:SetPoint("BOTTOMRIGHT", 1, -1)
	border:SetPoint("BOTTOMLEFT", -1, -1)
	border:SetFrameLevel(0)
	border:SetBackdrop( { 
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeSize = 1,
	})
	border:SetBackdropColor(0, 0, 0, 0.6)
	border:SetBackdropBorderColor(.05, .05, .05, .9)
end

local function SkinPetBattleFrame()
	frame.TopArtLeft:Hide()
	frame.TopArtRight:Hide()
	frame.TopVersus:Hide()
	frame.TopVersusText:SetPoint("TOP", frame, "TOP", 0, -46)
	frame.WeatherFrame.Icon:Hide()
	frame.WeatherFrame.Name:Hide()
	frame.WeatherFrame.DurationShadow:Hide()
	frame.WeatherFrame.Label:Hide()
	frame.WeatherFrame.Duration:SetPoint("CENTER", frame.WeatherFrame, 0, 8)
	frame.WeatherFrame:ClearAllPoints()
	frame.WeatherFrame:SetPoint("TOP", UIParent, 0, -15)
	
	for index, unit in pairs(units) do
		unit.healthBarWidth = 300

		unit.Border:SetDrawLayer("ARTWORK", 0)
		unit.Border2:SetDrawLayer("ARTWORK", 1)
		unit.HealthBarBG:Hide()
		unit.HealthBarFrame:Hide()
		unit.LevelUnderlay:Hide()
		unit.SpeedUnderlay:SetAlpha(0)
		unit.PetType:Hide()

		unit.ActualHealthBar:SetTexture(media.texture)

		unit.Border:SetTexture(media.checked)
		unit.Border:SetTexCoord(0, 1, 0, 1)
		unit.Border:SetPoint("TOPLEFT", unit.Icon, "TOPLEFT", -1, 1)
		unit.Border:SetPoint("BOTTOMRIGHT", unit.Icon, "BOTTOMRIGHT", 1, -1)
		unit.Border2:SetTexture(media.checked)
		unit.Border2:SetVertexColor(.89, .88, .06)
		unit.Border2:SetTexCoord(0, 1, 0, 1)
		unit.Border2:SetPoint("TOPLEFT", unit.Icon, "TOPLEFT", -1, 1)
		unit.Border2:SetPoint("BOTTOMRIGHT", unit.Icon, "BOTTOMRIGHT", 1, -1)

		unit.Level:SetFontObject(GameFontWhite)
		unit.Level:SetTextColor(1, 1, 1)

		local bg = CreateFrame("Frame", nil, unit)
		bg:SetWidth(unit.healthBarWidth+ 2)
		bg:SetFrameLevel(unit:GetFrameLevel()-1)
		S.CreateBD(bg)
		
		unit.HealthText:SetPoint("CENTER", bg, "CENTER")

		unit.PetTypeString = unit:CreateFontString(nil, "ARTWORK")
		unit.PetTypeString:SetFontObject(GameFontNormalLarge)

		if testmode then
			unit.Name:SetText("Lol pets")
			unit.HealthText:SetText("140/200")
			unit.Level:SetText("5")
			unit.PetTypeString:SetText("Martian")
		end

		unit.Name:ClearAllPoints()
		unit.ActualHealthBar:ClearAllPoints()
	
		if index == 1 then
			bg:SetPoint("TOPLEFT", unit.ActualHealthBar, "TOPLEFT", -1, 1)
			bg:SetPoint("BOTTOMLEFT", unit.ActualHealthBar, "BOTTOMLEFT", -1, -1)
			unit.ActualHealthBar:SetPoint("BOTTOMLEFT", unit.Icon, "BOTTOMRIGHT", 10, 0)
			unit.ActualHealthBar:SetVertexColor(0.26, 1, 0.22)
			unit.Name:SetPoint("BOTTOMLEFT", bg, "TOPLEFT", 0, 4)
			unit.PetTypeString:SetPoint("BOTTOMRIGHT", bg, "TOPRIGHT", 0, 4)
			unit.PetTypeString:SetJustifyH("RIGHT")
		else
			bg:SetPoint("TOPRIGHT", unit.ActualHealthBar, "TOPRIGHT", 1, 1)
			bg:SetPoint("BOTTOMRIGHT", unit.ActualHealthBar, "BOTTOMRIGHT", 1, -1)
			unit.ActualHealthBar:SetPoint("BOTTOMRIGHT", unit.Icon, "BOTTOMLEFT", -10, 0)
			unit.ActualHealthBar:SetVertexColor(1, .12, .24)
			unit.Name:SetPoint("BOTTOMRIGHT", bg, "TOPRIGHT", 0, 4)
			unit.PetTypeString:SetPoint("BOTTOMLEFT", bg, "TOPLEFT", 0, 4)
			unit.PetTypeString:SetJustifyH("LEFT")
		end
		unit.Icon:SetDrawLayer("ARTWORK", 2)
		S.CreateBG(unit.Icon)
	end
	for index, unit in pairs(extraUnits) do
		if testmode then unit:Show() end

		unit.healthBarWidth = unitsize
		unit:SetFrameLevel(3)
		unit:SetSize(unitsize, unitsize)

		unit.HealthBarBG:SetAlpha(0)
		unit.BorderAlive:SetAlpha(0)
		unit.BorderDead:SetAlpha(0)
		unit.HealthDivider:SetAlpha(0)

		unit.ActualHealthBar:ClearAllPoints()
		unit.ActualHealthBar:SetPoint("BOTTOM", 0, -1)

		unit.bg = CreateFrame("Frame", nil, unit)
		unit.bg:SetPoint("TOPLEFT", -1, 1)
		unit.bg:SetPoint("BOTTOMRIGHT", 1, -1)
		unit.bg:SetFrameLevel(unit:GetFrameLevel()-1)
		S.CreateBD(unit.bg)
		if index < 3 then
			unit.ActualHealthBar:SetVertexColor(26, 1, .22)
		else
			unit.ActualHealthBar:SetVertexColor(1, .12, .24)
		end
	end

	for i = 1, NUM_BATTLE_PETS_IN_BATTLE  do
		local unit = bf.PetSelectionFrame["Pet"..i]
		local icon = unit.Icon

		unit.HealthBarBG:Hide()
		unit.Framing:Hide()
		unit.HealthDivider:Hide()

		unit.Name:SetPoint("TOPLEFT", icon, "TOPRIGHT", 3, -3)
		unit.ActualHealthBar:SetPoint("BOTToMLEFT", icon, "BOTTOMRIGHT", 3, 0)

		icon:SetTexCoord(.08, .92, .08, .92)
		S.CreateBG(icon)

		unit.ActualHealthBar:SetTexture(media.backdrop)
		S.CreateBDFrame(unit.ActualHealthBar)
	end
	
	bf.RightEndCap:Hide()
	bf.LeftEndCap:Hide()
	bf.Background:Hide()
	bf.Delimiter:Hide()
	bf.TurnTimer.TimerBG:SetTexture("")
	bf.TurnTimer.ArtFrame:SetTexture("")
	bf.TurnTimer.ArtFrame2:SetTexture("")
	bf.FlowFrame.LeftEndCap:Hide()
	bf.FlowFrame.RightEndCap:Hide()
	select(3, bf.FlowFrame:GetRegions()):Hide()
	bf.MicroButtonFrame:Hide()
	PetBattleFrameXPBarLeft:Hide()
	PetBattleFrameXPBarRight:Hide()
	PetBattleFrameXPBarMiddle:Hide()
	for i = 7, 12 do
		select(i, bf.xpBar:GetRegions()):Hide()
	end
end

local function stylePetBattleButton(bu)
	if bu.reskinned then return end

	bu:SetNormalTexture("")
	bu:SetPushedTexture("")
	bu:SetHighlightTexture("")

	bu.bg = CreateFrame("Frame", nil, bu)
	bu.bg:SetAllPoints(bu)
	bu.bg:SetFrameLevel(0)
	bu.bg:SetBackdrop({
		edgeFile = media.backdrop,
		edgeSize = 1,
	})
	bu.bg:SetBackdropBorderColor(0, 0, 0)

	
	bu.Icon:SetDrawLayer("BACKGROUND", 2)
	bu.Icon:SetTexCoord(.08, .92, .08, .92)
	bu.Icon:SetPoint("TOPLEFT", bu, 1, -1)
	bu.Icon:SetPoint("BOTTOMRIGHT", bu, -1, 1)

	bu.CooldownShadow:SetAllPoints()
	bu.CooldownFlash:SetAllPoints()

	bu.SelectedHighlight:SetTexture(r, g, b)
	bu.SelectedHighlight:SetDrawLayer("BACKGROUND")
	bu.SelectedHighlight:SetAllPoints()

	bu.HotKey:SetFont(DB.Font, 12, "OUTLINEMONOCHROME")
	bu.HotKey:SetJustifyH("RIGHT")
	bu.HotKey:ClearAllPoints()
	bu.HotKey:SetPoint("TOPRIGHT", 0, -2)

	bu.Cooldown:SetFont(DB.Font, 12, "OUTLINEMONOCHROME")
	bu.Cooldown:SetJustifyH("CENTER")
	bu.Cooldown:SetDrawLayer("OVERLAY", 5)
	bu.Cooldown:SetTextColor(1, 1, 1)
	bu.Cooldown:SetShadowOffset(0, 0)
	bu.Cooldown:ClearAllPoints()
	bu.Cooldown:SetPoint("BOTTOM", 1, -1)

	bu.BetterIcon:SetSize(24, 24)
	bu.BetterIcon:ClearAllPoints()
	bu.BetterIcon:SetPoint("BOTTOM", 6, -9)

	bu.reskinned = true
end

local function ActionBar()
	bar:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 50)
	bar:SetSize(6 * (btnsize+1), btnsize)
	RegisterStateDriver(bar, "visibility", "[petbattle] show; hide")
	
	bf.TurnTimer.SkipButton:SetParent(bar)
	bf.TurnTimer.SkipButton:SetWidth(bar:GetWidth())
	bf.TurnTimer.SkipButton:ClearAllPoints()
	bf.TurnTimer.SkipButton:SetPoint("BOTTOM", bar, "TOP", 0, 2)
	bf.TurnTimer.SkipButton.ClearAllPoints = function() end
	bf.TurnTimer.SkipButton.SetPoint = function() end
	S.Reskin(bf.TurnTimer.SkipButton)

	bf.TurnTimer.Bar:ClearAllPoints()
	bf.TurnTimer.Bar:SetPoint("LEFT")

	bf.TurnTimer:SetParent(bar)
	bf.TurnTimer:SetSize(bf.TurnTimer.SkipButton:GetWidth() - 2, bf.TurnTimer.SkipButton:GetHeight())
	bf.TurnTimer:ClearAllPoints()
	bf.TurnTimer:SetPoint("BOTTOM", bf.TurnTimer.SkipButton, "TOP", 0, 2)
	S.CreateBDFrame(bf.TurnTimer)

	bf.xpBar:SetParent(bar)
	bf.xpBar:SetWidth(bar:GetWidth() - 2)
	bf.xpBar:ClearAllPoints()
	bf.xpBar:SetPoint("BOTTOM", bf.TurnTimer, "TOP", 0, 4)
	bf.xpBar:SetScript("OnShow", function(self)
		self:StripTextures() 
		self:SetStatusBarTexture(DB.Statusbar) 
		local r,g,b = self:GetStatusBarColor()
		S.CreateTop(self:GetStatusBarTexture(), r, g, b)
	end)
end

function PB:PetBattleUnitFrame_UpdateHealthInstant(self)
	if self.BorderAlive then
		if self.BorderAlive:IsShown() then
			self.bg:SetBackdropBorderColor(.26, 1, .22)
		else
			self.bg:SetBackdropBorderColor(1, .12, .24)
		end
	end
end

function PB:PetBattleUnitFrame_UpdateDisplay(self)
	local petOwner = self.petOwner

	if (not petOwner) or self.petIndex > C_PetBattles.GetNumPets(petOwner) then return end

	if self.Icon then
		if petOwner == LE_BATTLE_PET_ALLY then
			self.Icon:SetTexCoord(.92, .08, .08, .92)
		else
			self.Icon:SetTexCoord(.08, .92, .08, .92)
		end
	end
end

function PB:PetBattleUnitFrame_UpdatePetType(self)
	if self.PetType and self.PetTypeString then
		local petType = C_PetBattles.GetPetType(self.petOwner, self.petIndex)
		self.PetTypeString:SetText(PET_TYPE_SUFFIX[petType])
	end
end

function PB:PetBattleAuraHolder_Update(self)
	if not self.petOwner or not self.petIndex then return end
	local nextFrame = 1
	for i = 1, C_PetBattles.GetNumAuras(self.petOwner, self.petIndex) do
		local _, _, turnsRemaining, isBuff = C_PetBattles.GetAuraInfo(self.petOwner, self.petIndex, i)
		if (isBuff and self.displayBuffs) or (not isBuff and self.displayDebuffs) then
			local frame = self.frames[nextFrame]

			frame.DebuffBorder:Hide()

			if not frame.reskinned then
				frame.Icon:SetTexCoord(.08, .92, .08, .92)
				frame.bg = S.CreateBG(frame.Icon)
				frame.reskinned = true
			end

			frame.Duration:SetFont(DB.Font, 14, "OUTLINEMONOCHROME")
			frame.Duration:SetShadowOffset(0, 0)
			frame.Duration:ClearAllPoints()
			frame.Duration:SetPoint("BOTTOM", frame.Icon, 1, -1)

			if turnsRemaining > 0 then
				frame.Duration:SetText(turnsRemaining)
			end

			if isBuff then
				frame.bg:SetVertexColor(0, 1, 0)
			else
				frame.bg:SetVertexColor(1, 0, 0)
			end

			nextFrame = nextFrame + 1
		end
	end
end

function PB:PetBattlePetSelectionFrame_Show(self)
	bf.PetSelectionFrame:ClearAllPoints()
	bf.PetSelectionFrame:SetPoint("BOTTOM", bf.xpBar, "TOP", 0, 8)
end

function PB:PetBattleFrame_UpdatePassButtonAndTimer()
	local pveBattle = C_PetBattles.IsPlayerNPC(LE_BATTLE_PET_ENEMY)
	if bf.TurnTimer.bg then
		bf.TurnTimer.bg:SetShown(not pveBattle)
	end
	bf.xpBar:ClearAllPoints()

	if pveBattle then
		bf.xpBar:SetPoint("BOTTOM", bf.TurnTimer.SkipButton, "TOP", 0, 2)
	else
		bf.xpBar:SetPoint("BOTTOM", bf.TurnTimer, "TOP", 0, 4)
	end
end

function PB:PetBattleAbilityButton_UpdateHotKey(self)
	self.HotKey:SetShown(self.HotKey:IsShown())
end

function PB:PetBattleFrame_UpdateActionBarLayout(self)
	for i = 1, NUM_BATTLE_PET_ABILITIES do
		local bu = bf.abilityButtons[i]
		stylePetBattleButton(bu)
		bu:SetParent(bar)
		bu:SetSize(btnsize, btnsize)
		bu:ClearAllPoints()
		if i == 1 then
			bu:SetPoint("BOTTOMLEFT", bar)
		else
			local previous = bf.abilityButtons[i-1]
			bu:SetPoint("LEFT", previous, "RIGHT", 1, 0)
		end
	end

	stylePetBattleButton(bf.SwitchPetButton)
	stylePetBattleButton(bf.CatchButton)
	stylePetBattleButton(bf.ForfeitButton)

	if first then
		first = false
		bf.SwitchPetButton:SetScript("OnClick", function()
			if bf.PetSelectionFrame:IsShown() then
				PetBattlePetSelectionFrame_Hide(bf.PetSelectionFrame)
			else
				PetBattlePetSelectionFrame_Show(bf.PetSelectionFrame)
			end
		end)
	end

	bf.SwitchPetButton:SetParent(bar)
	bf.SwitchPetButton:SetSize(btnsize, btnsize)
	bf.SwitchPetButton:ClearAllPoints()
	bf.SwitchPetButton:SetPoint("LEFT", bf.abilityButtons[NUM_BATTLE_PET_ABILITIES], "RIGHT", 1, 0)
	bf.SwitchPetButton:SetCheckedTexture(media.checked)
	bf.CatchButton:SetParent(bar)
	bf.CatchButton:SetSize(btnsize, btnsize)
	bf.CatchButton:ClearAllPoints()
	bf.CatchButton:SetPoint("LEFT", bf.SwitchPetButton, "RIGHT", 1, 0)
	bf.ForfeitButton:SetParent(bar)
	bf.ForfeitButton:SetSize(btnsize, btnsize)
	bf.ForfeitButton:ClearAllPoints()
	bf.ForfeitButton:SetPoint("LEFT", bf.CatchButton, "RIGHT", 1, 0)
end

function PB:PET_BATTLE_OPENING_START()
	for _, v in pairs(frames) do
		if _G[v] then
			S.FadeOutFrameDamage(_G[v], 1, false)
		end
	end
end

function PB:PET_BATTLE_CLOSE()
	for _, v in pairs(frames) do
		if _G[v] then
			_G[v]:Show()
			UIFrameFadeIn(_G[v], 1, _G[v]:GetAlpha(), 1)
		 end
	end
end

function PB:PetBattleUnitTooltip_UpdateForUnit(self, petOwner, petIndex)
	local level = C_PetBattles.GetLevel(petOwner, petIndex);
	if ( petOwner == LE_BATTLE_PET_ALLY and level < MAX_PET_LEVEL ) then
		self.xpbd:Show();
	else
		self.xpbd:Hide();
	end
end


function PB:OnInitialize()
	self:SecureHook("PetBattleAbilityButton_UpdateHotKey", "PetBattleAbilityButton_UpdateHotKey")
	self:SecureHook("PetBattleFrame_UpdatePassButtonAndTimer", "PetBattleFrame_UpdatePassButtonAndTimer")
	self:SecureHook("PetBattlePetSelectionFrame_Show", "PetBattlePetSelectionFrame_Show")
	self:SecureHook("PetBattleAuraHolder_Update", "PetBattleAuraHolder_Update")
	self:SecureHook("PetBattleUnitFrame_UpdatePetType", "PetBattleUnitFrame_UpdatePetType")
	self:SecureHook("PetBattleUnitFrame_UpdateDisplay", "PetBattleUnitFrame_UpdateDisplay")
	self:SecureHook("PetBattleUnitFrame_UpdateHealthInstant", "PetBattleUnitFrame_UpdateHealthInstant")
	self:SecureHook("PetBattleFrame_UpdateActionBarLayout", "PetBattleFrame_UpdateActionBarLayout")
	self:SecureHook("PetBattleUnitTooltip_UpdateForUnit", "PetBattleUnitTooltip_UpdateForUnit")
	self:RegisterEvent("PET_BATTLE_OPENING_START", PET_BATTLE_OPENING_START)
	self:RegisterEvent("PET_BATTLE_CLOSE", PET_BATTLE_CLOSE)
	SkinPetBattleFrame()
	ActionBar()
	SkinPetTooltip(PetBattlePrimaryAbilityTooltip)
	SkinPetTooltip(PetBattlePrimaryUnitTooltip)
	SkinPetTooltip(BattlePetTooltip)
	SkinPetTooltip(FloatingBattlePetTooltip)
	SkinPetTooltip(FloatingPetBattleAbilityTooltip)
	table.insert(UISpecialFrames, "FloatingBattlePetTooltip")
	
end