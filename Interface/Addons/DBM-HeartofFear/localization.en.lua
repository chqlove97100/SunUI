local L

------------
-- Imperial Vizier Zor'lok --
------------
L= DBM:GetModLocalization(745)

L:SetOptionLocalization({
	specwarnPlatform	= "Show special warning when boss changes platforms",
	ArrowOnAttenuation	= "Show DBM Arrow during $spell:127834 to indicate which direction to move",
	specwarnAttenuationL	= "Show special warning when left Attenuation",
	specwarnAttenuationR	= "Show special warning when right Attenuation",
	specwarnExhale		= "Show special warning for $spell:122761",
	specwarnExhaleB		= "Show special warning for pre $spell:122761",
	specwarnDR			= "Show special warning for Damage reduction skills",
	MindControlIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122740),
	SoundWOP			= "Voice warning: important skills",
	HudMAP				= "HudMAP: $spell:122761 targeting",
	HudMAP2				= "HudMAP: $spell:122740",
	optarrowRTI			= "showing arrow pointing to the following tag game player when Set zone appears",
	none				= "none",
	arrow1				= "Star",
	arrow2				= "Circle",
	arrow3				= "Diamond",
	arrow4				= "Triangle",
	arrow5				= "moon",
	arrow6				= "Square",
	arrow7				= "Fork",
	optDR				= "P1 Damage reduction skills",
	noDR				= "none",
	DR1					= "P1 first",
	DR2					= "P1 second",
	DR3					= "P1 third",
	DR4					= "P1 fourth",
	DR5					= "P1 fifth",
	optDRT				= "P2 Damage reduction skills",
	noDRT				= "none",
	DRT1				= "P2 first",
	DRT2				= "P2 second",
	DRT3				= "P2 third",
	DRT4				= "P2 fourth",
	DRT5				= "P2 fifth"
})

L:SetMiscLocalization({
	Platform	= "%s flies to one of his platforms!",
	Defeat		= "We will not give in to the despair of the dark void. If Her will for us is to perish, then it shall be so."
})

L:SetWarningLocalization({
	specwarnPlatform	= "Combat zone changed",
	specwarnAttenuationL	= "LEFT!",
	specwarnAttenuationR	= "RIGHR!",
	specwarnExhale		= "Exhale[%d] : %s",
	specwarnDR			= ">>Damage reduction skill!<<",
	specwarnExhaleB		= "Next: >>%d<< Exhale"
})

------------
-- Blade Lord Ta'yak --
------------
L= DBM:GetModLocalization(744)

L:SetOptionLocalization({
	UnseenStrikeArrow	= "Show DBM Arrow when someone is affected by $spell:122949",
	RangeFrame			= "Show range frame (8) for $spell:123175",
	InfoFrame			= "InfoFrame:$spell:123474",
	SpecWarnOverwhelmingAssaultOther = "Special warning: $spell:123474",
	HudMAP				= "HUDMAP:$spell:122949",
	SoundWOP			= "Voice warning: important skills"
})

L:SetWarningLocalization({
	SpecWarnOverwhelmingAssaultOther 		= "%s - (%d)",
	SpecWarnJSA								= ">>Damage reduction skill!<<"
})

-------------------------------
-- Garalon --
-------------------------------
L= DBM:GetModLocalization(713)

L:SetWarningLocalization({
	specwarnUnder	= "Move out of purple ring!",
	specWarnPungencyOtherFix 		= "%s - (%d)"
})

L:SetOptionLocalization({
	specwarnUnder	= "Show special warning when you are under boss",
	PheromonesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122835),
	InfoFrame			= "InfoFrame:$spell:123081",
	optTankMode			= "Special warning:how to change tank",
	two					= "2 tanks (30 stacks)",
	three				= "3 tanks (20 stacks)",
	SoundWOP			= "Voice warning: important skills",
	specWarnPungencyOtherFix = "Special warning: $spell:123081",
	HudMAP				= "HUDMAP: $spell:122835",
	SoundFS				= "Countdown: $spell:122735"
})

L:SetMiscLocalization({
	UnderHim	= "under him"
})

----------------------
-- Wind Lord Mel'jarak --
----------------------
L= DBM:GetModLocalization(741)

L:SetOptionLocalization({
	SoundWOP			= "voice warning: important skills",
	SoundDQ				= "voice warning: $spell:122149 disperse",
	SoundJR				= "voice warning: Help others",
	APArrow				= "DBM arrow: $spell:121881",
	NearAP				= "voice warning: only warn within 20 yards of $spell:121881",
	ReapetAP			= "special warning: if your $spell:121881 without breaking in 5 seconds then keeping yell",
	HudMAP				= "HUDMAP:$spell:121885",
	optHud				= "HUDMAP:Windbomb",
	auto				= "auto",
	always				= "always",
	none				= "none",
	RangeFrame			= "RangeFrame(3):$spell:121881",
	AmberPrisonIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(121885)
})

L:SetMiscLocalization({
	Helpme				= "Help me ~~~",
	Reinforcements		= "Wind Lord Mel'jarak calls for reinforcements!"
})

------------
-- Amber-Shaper Un'sok --
------------
L= DBM:GetModLocalization(737)

L:SetWarningLocalization({
	warnReshapeLifeTutor		= "1: Interrupt/debuff target, 2: Interrupt yourself, 3: Regen Health/Willpower, 4: Escape Vehicle",
	warnAmberExplosion			= ">%s< is casting %s",
	warnInterruptsAvailable		= "Interupts available for %s: %s",
	specwarnWillPower			= "Low Will Power!",
	specwarnAmberExplosionYou	= "Interrupt YOUR %s!",--Struggle for Control interrupt.
	specwarnAmberExplosionAM	= "%s: Interrupt %s!",--Amber Montrosity
	specwarnAmberExplosionOther	= "%s: Interrupt %s!"--Amber Montrosity
})

L:SetTimerLocalization{
	timerAmberExplosionAMCD		= "%s CD: %s"
}

L:SetOptionLocalization({
	SoundWOP			= "voice warning: important skills",
	warnReshapeLifeTutor		= "Display ability purpose rundown of Mutated Construct abilities",
	warnAmberExplosion			= "Show warning (with source) when $spell:122398 is cast",
	warnInterruptsAvailable		= "Announce who has Amber Strike interrupts available for $spell:122402",
	specwarnWillPower			= "Show special warning when will power is low in construct",
	specwarnAmberExplosionYou	= "Show special warning to interrupt your own $spell:122398",
	specwarnAmberExplosionAM	= "Show special warning to interrupt Amber Montrosity's $spell:122402",
	specwarnAmberExplosionOther	= "Show special warning to interrupt loose Mutated Construct's $spell:122398",
	timerAmberExplosionAMCD		= "Show timer for Amber Monstrosity's next $spell:122402",
	InfoFrame					= "Show info frame for players will power",
	FixNameplates				= "Automatically disable interfering nameplates on pull\n(restores settings upon leaving combat)"
})

L:SetMiscLocalization({
	WillPower					= "Will Power"
})

------------
-- Grand Empress Shek'zeer --
------------
L= DBM:GetModLocalization(743)

L:SetWarningLocalization({
	warnAmberTrap		= "Amber Trap progress: (%d/5)",
})

L:SetOptionLocalization({
	warnAmberTrap		= "Show warning (with progress) when $spell:125826 is making", -- maybe bad translation.
	InfoFrame		= "Show info frame for players affected by $spell:125390",
	RangeFrame		= "Show range frame (5) for $spell:123735",
	SoundWOP		= "voice warning: important skills",
	HudMAP			= "HUDMAP: $spell:124863",
	StickyResinIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(124097)
})

L:SetMiscLocalization({
	PlayerDebuffs		= "Fixated",
	YellPhase3			= "No more excuses, Empress! Eliminate these cretins or I will kill you myself!"
})
