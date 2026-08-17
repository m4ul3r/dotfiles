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
local bar_active = tc.lighter_background or bar_bg
local bar_fg = tc.foreground or "ffffff"

hl.config({
  group = {
    groupbar = {
      -- 0xe6 ~ 0.90 alpha, same as ghostty's background-opacity.
      text_color = "rgb(" .. bar_fg .. ")",
      text_color_inactive = "rgba(" .. bar_fg .. "90)",
      col = {
        active = "rgba(" .. bar_active .. "e6)",
        inactive = "rgba(" .. bar_bg .. "e6)",
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
-- hl.config({
--   scrolling = {
--     -- See only one column per screen instead of two.
--     column_width = 0.97,
--   },
-- })
