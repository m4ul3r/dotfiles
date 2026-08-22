-- Change the default Omarchy look'n'feel.

-- Frosted glass: translucent windows + background blur (ported from the
-- pre-v4 looknfeel.conf; v4 defaults ship with blur disabled).
hl.config({
  decoration = {
    rounding = 8,
    active_opacity = 0.92,
    inactive_opacity = 0.85,
    -- Match active_opacity so fullscreen keeps the same frosted-glass blend
    -- instead of going darker (fullscreen swaps active_opacity for this).
    fullscreen_opacity = 0.92,
    -- Scratchpad (SUPER + S) overlay: dim the workspace underneath hard enough
    -- that btop/the scratchpad window reads as the foreground. Hyprland's
    -- default 0.2 barely touched a bright browser window. Note the value is
    -- latched when the special workspace opens, so a live `hyprctl reload`
    -- only shows up after the next SUPER + S close/open.
    dim_special = 0.65,
    blur = {
      enabled = true,
      size = 6,
      passes = 3,
      popups = true,
    },
  },
})

-- Vertical slide + crossfade when switching workspaces (Omarchy's default
-- disables the "workspaces" leaf entirely; this re-enables it).
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "easeOutQuint", style = "slidefadevert" })

-- Group tab bar: near-opaque and themed like the terminal, replacing the
-- default washed-out rgba(00000040)/rgba(00000020) overlays. Colors come from
-- the live theme palette so theme switches keep matching (omarchy theme set
-- reloads Hyprland, which re-runs this file).
local function omarchy_theme_colors()
  local t = {}
  local f = io.open(os.getenv("HOME") .. "/.local/state/omarchy/current/theme/colors.toml", "r")
  if not f then return t end
  for line in f:lines() do
    local k, v = line:match('^([%w_]+)%s*=%s*"#(%x%x%x%x%x%x)"')
    if k and v then t[k] = v end
  end
  f:close()
  return t
end

local tc = omarchy_theme_colors()
local bar_bg = tc.background or "282828"
local bar_active = tc.background or bar_bg
local bar_fg = tc.foreground or "ffffff"
local bar_accent = tc.accent or bar_fg

hl.config({
  group = {
    groupbar = {
      -- 0xd4 ~ 0.83 alpha = terminal's effective opacity (0.92 window x 0.90
      -- ghostty); with blur the tabs frost identically to the terminal. Uses
      -- `background` (every theme defines it), not lighter_background, so it
      -- tracks the terminal bg on light and dark themes alike.
      blur = true,
      -- Round each tab like the windows (decoration.rounding = 8);
      -- round_only_edges would round just the bar's outer corners.
      gradient_rounding = 8,
      gradient_round_only_edges = false,
      -- Active tab title in the theme accent, echoing the active border.
      text_color = "rgb(" .. bar_accent .. ")",
      text_color_inactive = "rgba(" .. bar_fg .. "90)",
      col = {
        active = "rgba(" .. bar_active .. "d4)",
        inactive = "rgba(" .. bar_bg .. "d4)",
      },
    },
  },
})
-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
-- hl.config({
--   general = {
--     -- No gaps between windows or borders.
--     gaps_in = 0,
--     gaps_out = 0,
--     border_size = 0,
--
--     -- Change to niri-like side-scrolling layout.
--     layout = "scrolling",
--   },
-- })

-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
-- hl.config({
--   decoration = {
--     -- Use round window corners.
--     rounding = 8,
--
--     -- Dim unfocused windows (0.0 = no dim, 1.0 = fully dimmed).
--     dim_inactive = true,
--     dim_strength = 0.15,
--   },
-- })

-- https://wiki.hypr.land/Configuring/Basics/Variables/#animations
-- hl.config({
--   animations = {
--     -- Disable all animations.
--     enabled = false,
--   },
-- })

-- https://wiki.hypr.land/Configuring/Basics/Variables/#layout
-- hl.config({
--   layout = {
--     -- Avoid overly wide single-window layouts on wide screens.
--     single_window_aspect_ratio = { 1, 1 },
--   },
-- })

-- https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/
-- Stock scrolling behavior kept on purpose: a lone column fills the monitor
-- (fullscreen_on_one_column, default true) and new columns open at Omarchy's
-- 0.49 default, so a second window yields two per screen and SUPER + M
-- (hypr-maximize-toggle) restores to a usable half width. Known trade-off:
-- SUPER + \ expel that leaves a lone column balloons it to full width.
-- fullscreen_on_one_column = false was tried and reverted — it left a single
-- terminal as a centered half-width strip and broke SUPER + M's restore.
