--[[ EQCompare in-game options GUI.
     Writes the same profile fields and runs the same side effects as the
     /eqc AceConsole group, so the two stay interchangeable. ]]--

local L = AceLibrary("AceLocale-2.2"):new("EQCompare")

-- When true, programmatic state changes apply silently; the checkbox sound
-- only plays for real user clicks.
EQCompare_OptionsSuppressSound = false

-- Key choices match the AceConsole "key" validate list, keep in sync.
local EQCompare_OptionsKeyOrder = { "none", "ctrl", "alt", "shift" }
local EQCompare_OptionsKeyLabel = {
	none = "none",
	ctrl = "ctrl",
	alt = "alt",
	shift = "shift",
}

local function PlayCheckSound(checked)
	if EQCompare_OptionsSuppressSound then return end
	if checked then
		PlaySound("igMainMenuOptionCheckBoxOff")
	else
		PlaySound("igMainMenuOptionCheckBoxOn")
	end
end

local function SetChecked(name, value)
	local cb = getglobal(name)
	if cb then
		cb:SetChecked(value and true or false)
	end
end

--[[ Localize the static labels and per-control tooltips. Runs on every show
     so the strings follow a mid-session locale change. ]]--
function EQCompare_Options_Localize()
	EQCompareOptionsTitleString:SetText(L["EQCompare_OPTIONS_TITLE"])
	EQCompareOptionsKeyLabel:SetText(L["key"])

	local controls = {
		{ "EQCompareOptionsHoverLink", "hoverlink", "EQCompare_HOVERLINK_DESC" },
		{ "EQCompareOptionsHoverLinkSafe", "hoverlink safe mode", "EQCompare_HOVERLINK_SAFE_DESC" },
		{ "EQCompareOptionsHoverLinkKey", "Hoverlink holding key", "EQCompare_HOVERLINKKEY_DESC" },
		{ "EQCompareOptionsMerchantKey", "Merchant/Auction holding key", "EQCompare_MERCHANTAUCTIONKEY_DESC" },
		{ "EQCompareOptionsOSkin", "EQCompare_OPT_OSKIN", "EQCompare_OPT_OSKIN_DESC" },
	}
	for _, c in ipairs(controls) do
		local cb = getglobal(c[1])
		if cb then
			local text = getglobal(c[1] .. "Text")
			if text then text:SetText(L[c[2]]) end
			cb.tooltip = L[c[3]]
		end
	end

	EQCompareOptionsKeyDropdown.tooltip = L["EQCompare_KEY_DESC"]
	EQCompareOptionsReset:SetText(L["reset"])
	EQCompareOptionsReset.tooltip = L["EQCompare_RESET_DESC"]
end

--[[ Pull the current profile into every control. ]]--
function EQCompare_Options_Refresh()
	EQCompare_OptionsSuppressSound = true
	local p = EQCompare.db.profile
	SetChecked("EQCompareOptionsHoverLink", p.hoverLink)
	SetChecked("EQCompareOptionsHoverLinkSafe", p.hoverLinkSafe)
	SetChecked("EQCompareOptionsHoverLinkKey", p.hoverLinkKey)
	SetChecked("EQCompareOptionsMerchantKey", p.merchantAuctionKey)
	SetChecked("EQCompareOptionsOSkin", p.oSkin)
	EQCompare_OptionsSuppressSound = false

	if EQCompareOptionsKeyDropdown then
		UIDropDownMenu_SetSelectedValue(EQCompareOptionsKeyDropdown, p.key)
	end
end

--[[ Key dropdown ]]--
function EQCompare_OptionsKey_OnShow()
	UIDropDownMenu_Initialize(this, EQCompare_OptionsKey_Initialize)
	UIDropDownMenu_SetSelectedValue(this, EQCompare.db.profile.key)
	UIDropDownMenu_SetWidth(90, this)
end

function EQCompare_OptionsKey_Initialize()
	local selected = EQCompare.db.profile.key
	for _, value in ipairs(EQCompare_OptionsKeyOrder) do
		local info = {}
		info.text = EQCompare_OptionsKeyLabel[value]
		info.value = value
		info.checked = (value == selected)
		info.func = EQCompare_OptionsKey_Click
		UIDropDownMenu_AddButton(info)
	end
end

function EQCompare_OptionsKey_Click()
	local value = this.value
	EQCompare.db.profile.key = value
	UIDropDownMenu_SetSelectedValue(EQCompareOptionsKeyDropdown, value)
	EQCompare:SetupOriginHook()
end

--[[ CheckButton handlers ]]--
function EQCompare_Options_HoverLinkClicked()
	local cb = EQCompareOptionsHoverLink
	PlayCheckSound(cb:GetChecked())
	EQCompare.db.profile.hoverLink = cb:GetChecked() and true or false
	EQCompare:HoverHyperlink_Toggle()
end

function EQCompare_Options_HoverLinkSafeClicked()
	local cb = EQCompareOptionsHoverLinkSafe
	PlayCheckSound(cb:GetChecked())
	EQCompare.db.profile.hoverLinkSafe = cb:GetChecked() and true or false
end

function EQCompare_Options_HoverLinkKeyClicked()
	local cb = EQCompareOptionsHoverLinkKey
	PlayCheckSound(cb:GetChecked())
	EQCompare.db.profile.hoverLinkKey = cb:GetChecked() and true or false
end

function EQCompare_Options_MerchantKeyClicked()
	local cb = EQCompareOptionsMerchantKey
	PlayCheckSound(cb:GetChecked())
	EQCompare.db.profile.merchantAuctionKey = cb:GetChecked() and true or false
end

function EQCompare_Options_OSkinClicked()
	local cb = EQCompareOptionsOSkin
	PlayCheckSound(cb:GetChecked())
	EQCompare.db.profile.oSkin = cb:GetChecked() and true or false
end

--[[ Reset ]]--
function EQCompare_Options_ResetClicked()
	EQCompare:ResetDB("profile")
	EQCompare:HoverHyperlink_Toggle()
	EQCompare:SetupOriginHook()
	EQCompare_Options_Refresh()
	EQCompare:Print(L["EQCompare_RESET"])
end

--[[ Frame scripts ]]--
function EQCompare_Options_OnShow()
	EQCompare_Options_Localize()
	EQCompare_Options_Refresh()
end

function EQCompare_Options_OnEnter()
	if this and this.tooltip then
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
		GameTooltip:SetText(this.tooltip, nil, nil, nil, nil, 1)
		GameTooltip:Show()
	end
end

function EQCompare_Options_OnLeave()
	GameTooltip:Hide()
end

--[[ Opened from /eqc config and the slash group. ]]--
function EQCompare:ShowOptions()
	if EQCompareOptions then
		EQCompareOptions:Show()
	end
end

function EQCompare:HideOptions()
	if EQCompareOptions then
		EQCompareOptions:Hide()
	end
end
