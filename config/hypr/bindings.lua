-- Unbind before binding, for every key this file claims. Keybinds registered
-- by an earlier generation of this file (or by the defaults we override)
-- survive `hyprctl reload` and would fire alongside ours; clearing the key
-- first guarantees exactly one binding no matter how often the config reloads.
for _, k in ipairs({
  "SUPER + RETURN", "SUPER + ALT + RETURN", "SUPER + SHIFT + RETURN",
  "SUPER + SHIFT + F", "SUPER + ALT + SHIFT + F", "SUPER + B", "SUPER + SHIFT + B",
  "SUPER + SHIFT + ALT + B", "SUPER + ALT + M", "SUPER + SHIFT + N", "SUPER + SHIFT + D",
  "SUPER + SHIFT + G", "SUPER + SHIFT + O", "SUPER + SHIFT + W", "SUPER + SHIFT + SLASH",
  "SUPER + SHIFT + A", "SUPER + SHIFT + ALT + A", "SUPER + SHIFT + C", "SUPER + SHIFT + E",
  "SUPER + SHIFT + Y", "SUPER + SHIFT + ALT + G", "SUPER + SHIFT + CTRL + G",
  "SUPER + SHIFT + P", "SUPER + SHIFT + S", "SUPER + SHIFT + X", "SUPER + SHIFT + ALT + X",
  "SUPER + SHIFT + ALT + M", -- stale template binds: Browser/Google Maps/Music TUI
  "SUPER + J", "SUPER + K", "SUPER + L", "SUPER + H",
  "SUPER + BACKSLASH", "SUPER + CTRL + K", "SUPER + PERIOD",
  "SUPER + SHIFT + H", "SUPER + SHIFT + J", "SUPER + SHIFT + K", "SUPER + SHIFT + L",
  "SUPER + ALT + H", "SUPER + ALT + J", "SUPER + ALT + K", "SUPER + ALT + L",
  "SUPER + F", "SUPER + Q", "SUPER + M", "SUPER + SHIFT + M", "SUPER + R",
  "SUPER + W",
  "SUPER + ALT + SPACE", "SUPER + CTRL + P",
  "CTRL + ESCAPE", -- stale: XP start-menu plugin uninstalled

  "XF86AudioRaiseVolume", "XF86AudioLowerVolume",
  "ALT + XF86AudioRaiseVolume", "ALT + XF86AudioLowerVolume",
  "XF86MonBrightnessUp", "XF86MonBrightnessDown",
  "SHIFT + XF86MonBrightnessUp", "SHIFT + XF86MonBrightnessDown",
  "ALT + XF86MonBrightnessUp", "ALT + XF86MonBrightnessDown",
}) do
  pcall(hl.unbind, k)
end

-- Application bindings (ported from bindings.conf.bak.1785906759).
o.bind("SUPER + RETURN", "Terminal", { omarchy = "terminal" })
o.bind("SUPER + ALT + RETURN", "Tmux", 'uwsm-app -- xdg-terminal-exec --dir="$(omarchy-cmd-terminal-cwd)" bash -c "tmux attach || tmux new -s Work"')
o.bind("SUPER + SHIFT + RETURN", "Browser", { omarchy = "browser" })
o.bind("SUPER + SHIFT + F", "File manager", { omarchy = "nautilus" })
o.bind("SUPER + ALT + SHIFT + F", "File manager (cwd)", { omarchy = "nautilus-cwd" })
o.bind("SUPER + B", "Browser", { omarchy = "browser" })
o.bind("SUPER + SHIFT + ALT + B", "Browser (private)", { omarchy = "browser --private" })
o.bind("SUPER + ALT + M", "Music", { omarchy = "or-focus spotify" })
o.bind("SUPER + SHIFT + N", "Editor", { omarchy = "editor" })
o.bind("SUPER + SHIFT + D", "Docker", { tui = "lazydocker" })
o.bind("SUPER + SHIFT + G", "Signal", { launch = "signal-desktop", focus = "^signal$" })
o.bind("SUPER + SHIFT + O", "Obsidian", { launch = "obsidian", focus = "^obsidian$" })
o.bind("SUPER + SHIFT + W", "Typora", { launch = "typora --enable-wayland-ime" })
o.bind("SUPER + SHIFT + SLASH", "Passwords", { launch = "1password" })

-- Web app bindings.
o.bind("SUPER + SHIFT + A", "ChatGPT", { webapp = "https://chatgpt.com" })
o.bind("SUPER + SHIFT + ALT + A", "Grok", { webapp = "https://grok.com" })
o.bind("SUPER + SHIFT + C", "Calendar", { webapp = "https://app.hey.com/calendar/weeks/" })
o.bind("SUPER + SHIFT + E", "Email", { webapp = "https://app.hey.com" })
o.bind("SUPER + SHIFT + Y", "YouTube", { webapp = "https://youtube.com/" })
o.bind("SUPER + SHIFT + ALT + G", "WhatsApp", { webapp = "https://web.whatsapp.com/", focus = true })
o.bind("SUPER + SHIFT + CTRL + G", "Google Messages", { webapp = "https://messages.google.com/web/conversations", focus = true })
o.bind("SUPER + SHIFT + P", "Google Photos", { webapp = "https://photos.google.com/", focus = true })
o.bind("SUPER + SHIFT + X", "X", { webapp = "https://x.com/" })
o.bind("SUPER + SHIFT + ALT + X", "X Post", { webapp = "https://x.com/compose/post" })

-- Vim-like window focus (SUPER + H/J/K/L).
-- SUPER + J was: Toggle window split (rebound to SUPER + \)
-- togglesplit is dwindle-only. Scrolling has no position-preserving
-- equivalent (any consume/expel column change forces the viewport to
-- reflow/recenter), so this is left as a silent no-op under scrolling
-- rather than fake a "toggle" that visibly jumps windows around.
o.bind("SUPER + BACKSLASH", "Toggle window split", hl.dsp.layout("togglesplit"))
-- SUPER + K was: Show key bindings (rebound to SUPER + CTRL + K)
o.bind("SUPER + CTRL + K", "Show key bindings", "omarchy-menu-keybindings")
-- SUPER + L was: Toggle workspace layout (rebound to SUPER + .)
o.bind("SUPER + PERIOD", "Toggle workspace layout", "omarchy-hyprland-workspace-layout-toggle")
-- Cycle a group's tabs first on plain movefocus (SUPER + H/L below), only
-- escaping to the next tile once you're on the group's first/last tab.
-- (Native Hyprland behavior, off by default: PR hyprwm/Hyprland#8714.)
hl.config({ binds = { movefocus_cycles_groupfirst = true } })

o.bind("SUPER + H", "Move window focus left", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + J", "Move window focus down", hl.dsp.focus({ direction = "d" }))
o.bind("SUPER + K", "Move window focus up", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + L", "Move window focus right", hl.dsp.focus({ direction = "r" }))

-- SUPER + SHIFT + H/L: manage group membership.
--   grouped, not at edge tab -> shift the window one tab position that way
--   grouped, at the edge tab -> eject out of the group toward that side
--   not grouped, group there -> join it
--   otherwise                -> fall back to a plain window swap
-- (J/K keep the plain vim-like window swap, unaffected by grouping.)
local function group_structure(direction)
  local win = hl.get_active_window()
  if not win then return end

  local g = win.group
  if g then
    -- current_index is 1-based; move_window wraps at the edges, so gate on
    -- the index ourselves and eject there instead of wrapping around.
    local at_edge = (direction == "l" and g.current_index <= 1)
      or (direction == "r" and g.current_index >= g.size)
    if not at_edge then
      hl.dispatch(hl.dsp.group.move_window({ forward = (direction == "r") }))
      return
    end
    -- Remember a fellow member before ejecting: the scrolling layout ignores
    -- out_of_group's direction and always drops the window on the group's
    -- right, so if we land on the wrong side of our old group, swap over it.
    local anchor
    if g.size > 1 and type(g.members) == "table" then
      for _, m in pairs(g.members) do
        if m.address ~= win.address then anchor = m.address break end
      end
    end
    hl.dispatch(hl.dsp.window.move({ out_of_group = direction }))
    if anchor then
      local me = hl.get_active_window()
      local other = hl.get_window("address:" .. anchor)
      if me and other and not me.group then
        local wrong_side = (direction == "l" and me.at.x > other.at.x)
          or (direction == "r" and me.at.x < other.at.x)
        if wrong_side then
          hl.dispatch(hl.dsp.window.swap({ direction = direction }))
        end
      end
    end
    return
  end

  -- moveintogroup is a documented no-op when there's no group in that
  -- direction, so trying it first and checking afterward is safe.
  hl.dispatch(hl.dsp.window.move({ into_group = direction }))
  local after = hl.get_active_window()
  if after and after.group then
    return
  end

  hl.dispatch(hl.dsp.window.swap({ direction = direction }))
end

o.bind("SUPER + SHIFT + H", "Tab left / eject / join / swap left", function() group_structure("l") end)
o.bind("SUPER + SHIFT + J", "Swap window down", hl.dsp.window.swap({ direction = "d" }))
o.bind("SUPER + SHIFT + K", "Swap window up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + SHIFT + L", "Tab right / eject / join / swap right", function() group_structure("r") end)

-- Vim-like move window to group (SUPER + ALT + H/J/K/L).
-- SUPER + ALT + K was: Show Tmux key bindings
o.bind("SUPER + ALT + H", "Move window to group on left", hl.dsp.window.move({ into_group = "l" }))
o.bind("SUPER + ALT + J", "Move window to group on bottom", hl.dsp.window.move({ into_group = "d" }))
o.bind("SUPER + ALT + K", "Move window to group on top", hl.dsp.window.move({ into_group = "u" }))
o.bind("SUPER + ALT + L", "Move window to group on right", hl.dsp.window.move({ into_group = "r" }))

-- Custom bindings.
-- v4 moved the Omarchy menu to SUPER + SPACE; keep the old v3 key as an alias.
o.bind("SUPER + ALT + SPACE", "Omarchy menu", "omarchy-menu toggle")
-- The battery bar widget is our user.power clone (percentage right of icon),
-- so the default Power-panel bind must target it instead of omarchy.power.
o.bind("SUPER + CTRL + P", "Power", "omarchy-shell shell toggle user.power")
-- SUPER + F was: Full screen (rebound to SUPER + SHIFT + M)
o.bind("SUPER + Q", "Close window", hl.dsp.window.close())
o.bind("SUPER + F", "File manager", { omarchy = "nautilus" })
o.bind("SUPER + M", "Maximize window", "/home/m4ul3r/.local/bin/hypr-maximize-toggle")
o.bind("SUPER + SHIFT + M", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
-- SUPER + W was: Close window (we close with SUPER + Q).
-- The scrolloverview dispatcher API is curried: overview("toggle all") only
-- RETURNS a dispatcher thunk — bind that thunk itself; wrapping the call in a
-- function discards it and the key does nothing. Guarded so the bind is
-- skipped when the plugin isn't loaded (it lands on the post-hyprpm reload).
local so = hl.plugin and hl.plugin.scrolloverview
if so then
  o.bind("SUPER + W", "Workspace overview", so.overview("toggle all"))
end

-- Resize mode (SUPER + R to enter, Escape to exit).
-- hyprctl keyword is unavailable under the Lua config, so swap the border
-- color in-process and restore whatever the current theme had set.
local resize_saved_border

o.bind("SUPER + R", "Resize mode", function()
  resize_saved_border = hl.get_config("general.col.active_border")
  hl.config({ general = { col = { active_border = "rgb(ff5555)" } } })
  hl.dispatch(hl.dsp.submap("resize"))
end)

hl.define_submap("resize", function()
  hl.bind("H", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
  hl.bind("L", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
  hl.bind("K", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
  hl.bind("J", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
  hl.bind("LEFT", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
  hl.bind("RIGHT", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
  hl.bind("UP", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
  hl.bind("DOWN", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
  hl.bind("ESCAPE", function()
    if resize_saved_border then
      hl.config({ general = { col = { active_border = resize_saved_border } } })
    end
    hl.dispatch(hl.dsp.submap("reset"))
  end)
end)

-- Volume with feedback sound (omarchy-audio-output-volume shows the OSD itself).
local volsound = "pw-play /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga"
o.bind("XF86AudioRaiseVolume", "Volume up", "omarchy-audio-output-volume raise && " .. volsound, { locked = true, repeating = true })
o.bind("XF86AudioLowerVolume", "Volume down", "omarchy-audio-output-volume lower && " .. volsound, { locked = true, repeating = true })
o.bind("ALT + XF86AudioRaiseVolume", "Volume up precise", "omarchy-audio-output-volume +1 && " .. volsound, { locked = true, repeating = true })
o.bind("ALT + XF86AudioLowerVolume", "Volume down precise", "omarchy-audio-output-volume -1 && " .. volsound, { locked = true, repeating = true })

-- Brightness: shadow upstream binds with absolute path so the local override in ~/.local/bin wins.
local brightness = "/home/m4ul3r/.local/bin/omarchy-brightness-display"
o.bind("XF86MonBrightnessUp", "Brightness up", brightness .. " +5%", { locked = true, repeating = true })
o.bind("XF86MonBrightnessDown", "Brightness down", brightness .. " 5%-", { locked = true, repeating = true })
o.bind("SHIFT + XF86MonBrightnessUp", "Brightness maximum", brightness .. " 100%", { locked = true, repeating = true })
o.bind("SHIFT + XF86MonBrightnessDown", "Brightness minimum", brightness .. " 0%", { locked = true, repeating = true })
o.bind("ALT + XF86MonBrightnessUp", "Brightness up precise", brightness .. " +1%", { locked = true, repeating = true })
o.bind("ALT + XF86MonBrightnessDown", "Brightness down precise", brightness .. " 1%-", { locked = true, repeating = true })
