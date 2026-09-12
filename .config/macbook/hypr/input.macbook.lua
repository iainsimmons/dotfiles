-- MacBook-only Hyprland input override, applied via the mise overlay
-- (config.macbook.toml -> ~/.config/hypr/input.macbook.lua). Loaded from
-- hyprland.lua only when present, so the desktop never sees it.
--
-- The shared input.lua keeps input:sensitivity = -0.75 to slow the desktop
-- mouse down. There's only a touchpad (bcm5974) on the MacBook, so restore
-- the faster tracking speed that this machine used before the desktop tuning
-- was shared (see the old archlinux-macbook branch: sensitivity = 0). Raise
-- this toward 1.0 for a faster cursor.
hl.config({
  input = {
    sensitivity = 0,
  },
})