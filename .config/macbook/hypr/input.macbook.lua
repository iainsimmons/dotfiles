-- MacBook-only Hyprland input override, applied via the mise overlay
-- (config.macbook.toml -> ~/.config/hypr/input.macbook.lua). Loaded from
-- hyprland.lua only when present, so the desktop never sees it.
--
-- Restored from the old archlinux-macbook branch's input.lua. The shared
-- input.lua keeps input:sensitivity = -0.75 to slow the desktop mouse down;
-- there's only a touchpad (bcm5974) on the MacBook, so restore the faster
-- tracking speed this machine used before the desktop tuning was shared.
-- Raise sensitivity toward 1.0 for a faster cursor. kb_options and
-- follow_mouse duplicate the shared file (kept here to mirror the old branch
-- self-containedly).
hl.config({
  input = {
    -- Use a specific compose key instead of Omarchy's CapsLock default.
    kb_options = "compose:rctrl",
    -- Increase sensitivity for mouse/trackpad (default: 0).
    sensitivity = 0,

    -- 2 - Cursor focus will be detached from keyboard focus. Clicking on a
    -- window will move keyboard focus to that window.
    follow_mouse = 2,

    touchpad = {
      disable_while_typing = true,
      tap_to_click = false,
    },
  },
})