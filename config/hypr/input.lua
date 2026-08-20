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

-- 4-finger swipes: up/down = previous/next workspace, left/right = move
-- window focus. Workspace swipes also work inside the open overview: its
-- window-active hook syncs the viewport to the focused window's workspace,
-- so the overview scrolls along (except onto empty workspaces, which focus
-- no window).
hl.gesture({ fingers = 4, direction = "up", action = function() hl.dispatch(hl.dsp.focus({ workspace = "-1" })) end })
hl.gesture({ fingers = 4, direction = "down", action = function() hl.dispatch(hl.dsp.focus({ workspace = "+1" })) end })
hl.gesture({ fingers = 4, direction = "left", action = function() hl.dispatch(hl.dsp.focus({ direction = "l" })) end })
hl.gesture({ fingers = 4, direction = "right", action = function() hl.dispatch(hl.dsp.focus({ direction = "r" })) end })

-- 3-finger down: close the overview (no-op when it isn't open). Heads-up:
-- this touchpad often counts a resting thumb, so a physical 3-finger swipe
-- can arrive as 4fg and browse instead of close — SUPER+W/Escape/click are
-- the reliable exits. 3-finger up (open) is registered in hyprland.lua.
hl.gesture({ fingers = 3, direction = "down", action = close_overview })

-- Slow down ghostty touchpad scrolling (ported from input.conf.bak.1785906759).
o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })

-- Focus follows mouse: hovering a window focuses it (matches Omarchy's
-- default of follow_mouse = 1, stated explicitly here). Cursor warping on
-- keybind focus stays at Hyprland's default (no_warps = false) — with
-- hover-focus, a non-warping cursor would steal focus back on the first
-- mouse twitch after a keybind focus change.
hl.config({
  input = {
    follow_mouse = 1,
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
