-- Extra autostart processes.
-- o.launch_on_start("my-service")

hl.on("hyprland.start", function()
  -- Load hyprpm-managed plugins (scrolloverview overview) — nothing else loads
  -- them at boot. hyprpm runs `hyprctl reload` after loading, so the
  -- pcall-guarded plugin config in hyprland.lua applies on the second pass.
  hl.exec_cmd("hyprpm reload -n")
end)
