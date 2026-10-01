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

-- Keep workspaces 1-5 alive when empty (Niri-style fixed strip): Hyprland
-- destroys empty unfocused workspaces, and the overview only shows
-- workspaces that exist — so an empty one otherwise appears only while
-- scrolled onto.
for i = 1, 5 do
  hl.workspace_rule({ workspace = tostring(i), persistent = true })
end

-- Niri-style workspace overview (hyprpm plugin: scrolloverview; toggled on
-- SUPER + W in bindings.lua). Wrapped in pcall so the config still loads when
-- the plugin is disabled or fails ABI checks after a Hyprland update.
-- 3-finger vertical swipe opens it; 4-finger up/down stays workspace switching
-- (input.lua). Revert: delete this block, the SUPER + W bind, and run
-- `hyprpm remove hyprland-scroll-overview`.
if hl.plugin and hl.plugin.scrolloverview then
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
    -- No "scrolloverview" submap is defined on purpose: defining one replaces
    -- the plugin's built-in overview keys (arrows/enter/escape/click) and mutes
    -- every regular bind while the overview is open. Without it the built-ins
    -- stay, and SUPER+W / 4-finger workspace swipes keep working inside.

    -- 3-finger up opens the overview (the plugin's gesture() API acts
    -- immediately, unlike its curried dispatchers, which RETURN thunks).
    -- The close lives on 3-finger down in input.lua. Reload clears all
    -- trackpad gestures, so this re-registers fresh each time.
    hl.plugin.scrolloverview.gesture({ fingers = 3, direction = "up" })
  end)
end

-- [key-visualizer] capture hook (managed by the plugin; safe to remove)
-- Deviation from the plugin-written line: pcall so an error inside the
-- plugin file can't abort the whole config load (a plugin update may
-- rewrite this back to a bare dofile).
local kc_path = os.getenv("HOME") .. "/.config/omarchy/plugins/felixzsh.key-visualizer/key-visualizer.lua"
local kc_file = io.open(kc_path, "r")
if kc_file then kc_file:close(); pcall(dofile, kc_path) end
