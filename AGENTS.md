# AGENTS.md

## What this is
World of Warcraft **Vanilla 1.12** addon (`Interface: 11200`). Pure Lua, no build/
test/lint tooling, no package manager. Verification is loading it in-game only.

## Critical rules
- The WoW client loads files listed in `EQCompare.toc`, in that exact order.
  Any new Lua/XML file **must** be added to the `.toc` or it will never run.
- `libs/` is vendored Ace2 libraries. Do not edit or reorder them; load order matters.
- Code targets WoW's Lua 5.0-ish environment: use `getglobal`, `getn`, `tinsert`,
  `strfind`, `getfenv(0)` etc. — NOT standard Lua 5.1+/idiomatic APIs.
- The addon's global namespace is polluted by design (`EQCompare`, `EQCompareDB`,
  locale globals). Match the existing style; don't introduce a module system.

## Layout
- `EQCompare.lua` — all logic: init, saved vars, slash commands, tooltip hooks.
- `EQCompare.xml` — two `GameTooltip` frames (`EQCompareTooltip1/2`) inheriting
  `ShoppingTooltipTemplate`.
- `EQCompareOptions.xml`/`.lua` — standalone options dialog (`EQCompareOptions`),
  opened by `/eqc config`. Mirrors the AceConsole group's fields and side effects;
  keep the two in sync when adding settings.
- `locale/localization.lua` — enUS strings **plus** fallback globals
  (`INVTYPE_GUN`, etc.). Other `localization.<lang>.lua` use AceLocale-2.2.
- `EQCompareDB` is the SavedVariables profile (`RegisterDefaults("profile", ...)`).

## Conventions
- Add any user-facing string to `localization.lua` (enUS) at minimum; keys are the
  English literal or an `EQCompare_*` token. Mirror additions into the other locales.
- Settings are exposed via `/eqc`/`/eqcompare` (AceConsole group) and, per README,
  via the external **Niagara** GUI. `RegisterDefaults` is the source of truth.
- Folder must be named `EQCompare` under `Interface/Addons/` to load.

## Notes
- Repo/folder is named `EquipCompare`; the addon is `EQCompare` (remote:
  `Rothiss/EquipCompare`). Don't rename the `.toc`/folder mismatch casually.
- Optional integrations referenced in README/code: AUX, Skinner, oSkin,
  Auctioneer/EnhTooltip. Guard with `IsAddOnLoaded(...)` as the code already does.
- README is upstream project prose; trust `.toc`/`.lua` over it on conflicts.
