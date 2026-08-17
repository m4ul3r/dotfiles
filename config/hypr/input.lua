-- Keep only your personal input overrides here. Uncommented settings below
-- replace Omarchy's defaults.

-- Touchpad gestures. Every Lua config reload clears ALL trackpad gestures
-- (Hyprland wipes the gesture manager before re-parsing), so these simply
-- re-register fresh each time — no unbind dance needed, unlike keybinds.

-- The scrolloverview dispatcher API is curried: overview("close all") RETURNS
-- a dispatcher thunk that must be hl.dispatch()ed — a bare call is a no-op.
local function close_overview()
  local so = hl.plugin and hl.plugin.scrolloverview
  if so then hl.dispatch(so.overview("close all")) end
end

-- 4-finger swipes: up = previous workspace, left/right = move window focus.
hl.gesture({ fingers = 4, direction = "up", action = function() hl.dispatch(hl.dsp.focus({ workspace = "-1" })) end })
hl.gesture({ fingers = 4, direction = "left", action = function() hl.dispatch(hl.dsp.focus({ direction = "l" })) end })
hl.gesture({ fingers = 4, direction = "right", action = function() hl.dispatch(hl.dsp.focus({ direction = "r" })) end })

-- 4-finger down: close the overview when it's open, else next workspace. The
-- close must live on 4 fingers too: this touchpad often counts a resting
-- thumb, so a physical 3-finger swipe frequently arrives as 4fg (the Hyprland
-- log shows [3fg] RESET -> [4fg] SWIPE pairs). "Overview open" is detected
-- via its auto-activated submap, defined in hyprland.lua.
hl.gesture({ fingers = 4, direction = "down", action = function()
  if hl.get_current_submap() == "scrolloverview" then
    close_overview()
  else
    hl.dispatch(hl.dsp.focus({ workspace = "+1" }))
  end
end })

-- 3-finger down: same close, for swipes the pad does count as 3 (no-op when
-- the overview isn't open). 3-finger up (open) is registered in hyprland.lua.
hl.gesture({ fingers = 3, direction = "down", action = close_overview })

-- Slow down ghostty touchpad scrolling (ported from input.conf.bak.1785906759).
o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })

-- Disable focus-follows-mouse: window focus changes only on click, not on
-- cursor movement (Omarchy's default is follow_mouse = 1).
hl.config({
  input = {
    follow_mouse = 0,
  },
  -- Stop the cursor from warping to the center of a window when focus
  -- changes via keybind (e.g. SUPER + L / movefocus) or other non-hover
  -- focus changes (Hyprland's default is no_warps = false).
  cursor = {
    no_warps = true,
  },
})

-- Keyboard layout and options.
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
-- hl.config({
--   input = {
--     -- Use multiple keyboard layouts and switch between them with Left Alt + Right Alt.
--     kb_layout = "us,dk,eu",
--     kb_options = "compose:caps,shift:both_capslock_cancel,grp:alts_toggle",
--
--     -- Use a specific keyboard variant if needed (e.g. intl for international keyboards).
--     kb_variant = "intl",
--
--     -- Change speed of keyboard repeat.
--     repeat_rate = 40,
--     repeat_delay = 250,
--
--     -- Start with numlock on by default.
--     numlock_by_default = true,
--
--     -- Increase sensitivity for mouse/trackpad (default: 0).
--     sensitivity = 0.35,
--
--     -- Turn off mouse acceleration (default: adaptive).
--     accel_profile = "flat",
--
--     touchpad = {
--       -- Use natural (inverse) scrolling.
--       natural_scroll = true,
--
--       -- Use two-finger clicks for right-click instead of lower-right corner.
--       clickfinger_behavior = true,
--
--       -- Control the speed of your scrolling.
--       scroll_factor = 0.4,
--
--       -- Enable the touchpad while typing.
--       disable_while_typing = false,
--
--       -- Left-click-and-drag with three fingers.
--       drag_3fg = 1,
--     },
--   },
-- })

-- App-specific touchpad scroll speeds.
-- o.window("(Alacritty|kitty|foot)", { scroll_touchpad = 1.5 })
-- o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })

-- Enable touchpad gestures for changing workspaces.
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
-- hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Enable touchpad gestures for moving focus (helpful on scrolling layout).
-- hl.gesture({ fingers = 3, direction = "left", action = function() hl.dispatch(hl.dsp.focus({ direction = "l" })) end })
-- hl.gesture({ fingers = 3, direction = "right", action = function() hl.dispatch(hl.dsp.focus({ direction = "r" })) end })
