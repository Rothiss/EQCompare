# EQCompare-Vanilla
EquipCompare Ace2 replica.

![Imgur](http://i.imgur.com/eXwXxIa.jpg)

When you shop for items at a vendor or the Auction House and you hover over an item, you get a comparison tooltip showing the "currently equipped" item too. This AddOn adds such a feature everywhere in the game where you can hover over items, such as in your bags, in the loot window or on the reward page of a quest. You also receive comparison tooltips when clicking an item link in the chat box.

v1.5
+ reworked localization support
+ added ruRU locale
+ added compatibility w/ AUX
+ added Skinner support

## Features
+ Equipped-item comparison wherever item tooltips appear (bags, bank, loot, quest rewards, merchant, auction house).
+ Comparison on chat-frame item links (hoverlink), with an optional safe mode.
+ Optional held key (ctrl / alt / shift) before comparison tooltips show.
+ Persistent comparison for clicked chat links.
+ Localization: enUS, deDE, frFR, koKR, ruRU, zhCN, zhTW.
+ Compatible with AUX, Skinner, oSkin, Auctioneer/EnhTooltip.

## Use [Niagara](https://github.com/laytya/Niagara) for GUI settings

![Imgur](http://i.imgur.com/dFYE0Nd.jpg)

## Settings
Settings are also available via `/eqc` or `/eqcompare`:
+ `key` — none / ctrl / alt / shift; only compare while the key is held.
+ `hoverlink` — show tooltips while hovering chat hyperlinks.
+ `hoverlink safe mode` — safer item-link handling (avoids disconnects).
+ `Merchant/Auction holding key` / `Hoverlink holding key` — require the key for those comparisons.
+ oSkin/Skinner tooltip skinning (needs `/reload`).
+ `reset` — restore defaults.

## Install
+ Extract the archive
+ Copy "EQCompare" folder into your "/Interface/Addons/" directory
