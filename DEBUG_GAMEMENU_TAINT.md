# GameMenu ADDON_ACTION_FORBIDDEN Debug Log

## Error
```
[ADDON_ACTION_FORBIDDEN] AddOn 'Tukui' tried to call the protected function 'callback()'.
[Blizzard_GameMenu/Shared/GameMenuFrame.lua]:67
```
- Occurs when clicking "Logout and Exit Game"
- Happens ~20-30 times per click
- Taint log is empty
- **WoW Version: 2.5.5.65534 (Burning Crusade Classic - BCC)**
- Logout is completely blocked - user must disable Tukui to logout
- Disabling Tukui fixes the issue

## Root Cause (IDENTIFIED)
The issue is in **MicroMenu.lua** which runs on BCC:

1. **SecureActionButtonTemplate with SetScript** (Line 302-303):
```lua
self.Captor = CreateFrame("Button", "TukuiMicroMenuCaptor", UIParent, "SecureActionButtonTemplate")
self.Captor:SetScript("OnClick", MicroMenu.Toggle)
```
Using `SetScript("OnClick")` on a `SecureActionButtonTemplate` causes taint in Classic versions.

2. **MicroMenu.Toggle calls HideUIPanel(GameMenuFrame)** (Line 257-259):
```lua
if GameMenuFrame:IsShown() then
    HideUIPanel(GameMenuFrame)
end
```
This spreads taint when called from a tainted execution path.

## Fixes Applied

### Fix 1: Remove SecureActionButtonTemplate from MicroMenu captor
```lua
-- Changed from:
self.Captor = CreateFrame("Button", "TukuiMicroMenuCaptor", UIParent, "SecureActionButtonTemplate")
-- To:
self.Captor = CreateFrame("Button", "TukuiMicroMenuCaptor", UIParent)
```

### Fix 2: Remove HideUIPanel(GameMenuFrame) from MicroMenu.Toggle
```lua
-- Removed:
if GameMenuFrame:IsShown() then
    HideUIPanel(GameMenuFrame)
end
```

## Previously Tried Fixes (Before BCC was identified)

These were attempted when we incorrectly assumed it was Retail/TWW:

1. Excluded GameMenuButtonLogout/Quit from SkinButton loop - **No effect**
2. Removed GameMenu module from Core.lua - **No effect**
3. Removed GameMenuFrame:HookScript("OnShow") from Gui.lua - **No effect**
4. Disabled Menu system hooks in DropDown.lua - **No effect**
5. Made GameMenu:Enable() return early on Retail - **No effect**
6. Moved GameMenuFrame access inside functions - **No effect**
7. Removed GameMenuButtonTemplate from button creation - **No effect**
8. Disabled MicroMenu on Retail - **No effect**
9. Removed EditModeManagerFrame modifications - **No effect**

## Key Learnings
- Always confirm WoW version early in debugging
- BCC (2.5.x) has different protected function rules than Retail
- SecureActionButtonTemplate should never have SetScript("OnClick") called on it
- Taint log being empty doesn't mean there's no taint issue
- Error count increasing across reloads is just BugGrabber accumulating counts

## Files Modified
- `Tukui/Modules/Miscellaneous/MicroMenu.lua`
  - Removed SecureActionButtonTemplate
  - Removed HideUIPanel(GameMenuFrame) call

- `Tukui/Modules/Miscellaneous/GameMenu.lua`
  - Moved GameMenuFrame access from file-level to inside functions
  - File-level `local Menu = GameMenuFrame` and `local Header = Menu.Header` were executing on BCC even though Enable() returns early

---

## Session 2 Research (Error Still Persists - 34x count)

### Additional Investigation

#### Files Confirmed Safe for BCC
- **Gui.lua:1978-1986**: `GameMenuFrame:HookScript("OnShow")` is wrapped in `if not T.BCC then` - does NOT run on BCC
- **GameMenu.lua:31-33**: Has `if T.BCC then return end` - does NOT run on BCC
- **DropDown.lua**: Menu system hooks only run if global `Menu` exists (Retail only)
- **ObjectiveTracker.lua:504-505**: SecureActionButtonTemplate with SetScript is in `if T.Retail then` block

#### MicroMenu.lua - Still Modifying Secure Buttons
The MicroMenu module is STILL modifying secure micro buttons on BCC:

```lua
-- Minimalist() function (lines 109-148):
for i = 1, NumButtons do
    local Button = _G[Buttons[i]]  -- These are secure micro buttons!
    Button:StripTextures()         -- Modifies textures
    Button:SetAlpha(0)             -- Changes alpha
    Button:SetWidth(...)           -- Changes size
    Button:SetHeight(...)
    Button:SetHitRectInsets(...)
    Button:CreateBackdrop()
    Button:ClearAllPoints()        -- Clears positioning
    Button:SetPoint(...)           -- Sets new position
end

-- Also calls:
UpdateMicroButtonsParent(MicroMenu)  -- Reparents ALL secure micro buttons to TukuiMicroMenu
```

This modifies ALL micro buttons including **MainMenuMicroButton**, which opens the GameMenuFrame. When MainMenuMicroButton is clicked, the taint from Tukui's modifications may propagate to GameMenuFrame's callback system.

#### Missing Library Files (Separate Issue)
The BCC .toc references libraries that don't exist in the Libs folder:
- `Libs/TaintLess/TaintLess.xml` - MISSING
- `Libs/LibStub/LibStub.lua` - MISSING
- `Libs/CallbackHandler-1.0/CallbackHandler-1.0.lua` - MISSING
- `Libs/SortBags_Vanilla/SortBags.lua` - MISSING

These cause loading errors but are likely separate from the taint issue.

### Fix Applied: Disable MicroMenu on BCC (Session 2)
Added early return for BCC/Classic in `MicroMenu:Enable()`:

```lua
function MicroMenu:Enable()
    -- Disable MicroMenu entirely on Classic/BCC to prevent taint from modifying secure micro buttons
    if T.BCC or T.Classic then
        return
    end

    if C.Misc.MicroStyle.Value == "None" then
        return
    end
    -- ... rest of function
end
```

**Status:** APPLIED - CONFIRMED WORKING

This prevents ALL modifications to secure micro buttons on BCC:
- No `UpdateMicroButtonsParent()` calls
- No `StripTextures()`, `SetAlpha()`, `ClearAllPoints()`, `SetPoint()` on secure buttons
- No `AddHooks()` which hooks `MainMenuMicroButton_ShowAlert`
- No captor button creation

### Fix Applied: Missing Library Files (Session 2)
Removed references to non-existent libraries from `Tukui-BCC.toc`:
- Removed `Libs\TaintLess\TaintLess.xml`
- Removed `Libs\LibStub\LibStub.lua`
- Removed `Libs\CallbackHandler-1.0\CallbackHandler-1.0.lua`
- Removed `Libs\SortBags_Vanilla\SortBags.lua`

### Fix Applied: Bags.lua Sort Button Crash (Session 2)
Added nil check for `Sort` function in `Modules/Inventory/Bags.lua:518-525`:
```lua
local Sort = C_Container and C_Container.SortBags or SortBags

if Sort then
    Sort()
else
    T.Print("Bag sorting is not available")
end
```
This prevents the Lua error when SortBags library is not available on BCC.

### Fix Applied: Disable UpdateMicroButtonsParent Entirely (Session 2)
Commented out `UpdateMicroButtonsParent(MicroMenu)` in both `Minimalist()` and `Blizzard()` functions:
- **BCC/Classic**: Causes taint with GameMenuFrame callbacks
- **Retail**: Breaks EditMode's MicroMenuContainer positioning (nil left/bottom values)

Also added:
- Skip modifying `MainMenuMicroButton` on BCC/Classic (prevents taint propagation)
- Hide bag bar buttons and keyring on BCC/Classic in `Enable()`
