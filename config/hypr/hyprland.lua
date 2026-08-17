-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- All Omarchy default setups
require("default.hypr.omarchy")

-- Change your own setup in these files and override defaults.
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")

-- Toggle config flags dynamically.
require("default.hypr.toggles")

-- Add any other personal Hyprland configuration below.
-- o.window("qemu", { workspace = "5" })

-- Niri-style workspace overview (hyprpm plugin: scrolloverview; toggled on
-- SUPER + W in bindings.lua). Wrapped in pcall so the config still loads when
-- the plugin is disabled or fails ABI checks after a Hyprland update.
-- 3-finger vertical swipe opens it; 4-finger up/down stays workspace switching
-- (input.lua). Revert: delete this block, the SUPER + W bind, and run
-- `hyprpm remove hyprland-scroll-overview`.
pcall(function()
  hl.config({
    plugin = {
      scrolloverview = {
        gesture_distance = 300,
        scale = 0.5,
        workspace_gap = 50,
        layout = "vertical",
        wallpaper = 2, -- 0: global, 1: per-workspace, 2: both
        blur = true,
        shadow = { enabled = true, range = 50 },
      },
    },
  })
  -- Defining this submap makes the plugin auto-activate it while the overview
  -- is open; it doubles as the "overview open?" probe for the finger-count-
  -- proof close gesture in input.lua (hl.get_current_submap()). Defining it
  -- REPLACES the built-in overview keybinds and mutes regular binds inside
  -- the overview, so the defaults are replicated here.
  -- The dispatcher API is curried: so.overview("off") RETURNS a dispatcher
  -- thunk — bind thunks directly; multi-step actions hl.dispatch() each one.
  local so = hl.plugin.scrolloverview
  hl.define_submap("scrolloverview", function()
    hl.bind("LEFT", so.navigate("left"))
    hl.bind("RIGHT", so.navigate("right"))
    hl.bind("UP", so.navigate("up"))
    hl.bind("DOWN", so.navigate("down"))
    hl.bind("ESCAPE", so.overview("off"))
    hl.bind("RETURN", function()
      hl.dispatch(so.overview("select"))
      hl.dispatch(so.overview("off"))
    end)
    -- Default click behavior: select clicked workspace/window, then close.
    hl.bind("mouse:272", function()
      hl.dispatch(so.overview("select"))
      hl.dispatch(so.window("select"))
      hl.dispatch(so.overview("off"))
    end, { mouse = true })
    hl.bind("mouse:274", so.window("close"), { mouse = true })
    -- The toggle key must keep exiting (outside binds are inert in a submap).
    hl.bind("SUPER + W", so.overview("off"))
  end)

  -- 3-finger up opens the overview (the plugin's gesture() API acts
  -- immediately, unlike its curried dispatchers). The close lives on
  -- 3/4-finger down in input.lua. Reload clears all trackpad gestures,
  -- so this re-registers fresh each time.
  so.gesture({ fingers = 3, direction = "up" })
end)

-- [key-visualizer] capture hook (managed by the plugin; safe to remove)
-- Deviation from the plugin-written line: pcall so an error inside the
-- plugin file can't abort the whole config load (a plugin update may
-- rewrite this back to a bare dofile).
local kc_path = os.getenv("HOME") .. "/.config/omarchy/plugins/felixzsh.key-visualizer/key-visualizer.lua"
local kc_file = io.open(kc_path, "r")
if kc_file then kc_file:close(); pcall(dofile, kc_path) end
