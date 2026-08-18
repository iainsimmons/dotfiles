-- Keep only your personal input overrides here. Uncommented settings below
-- replace Omarchy's defaults.

-- Keyboard layout and options.
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
  input = {
    -- Use a specific compose key instead of Omarchy's CapsLock default.
    kb_options = "compose:rctrl",

    -- Increase sensitivity for mouse/trackpad (default: 0).
    sensitivity = -0.75,

    -- 2 - Cursor focus will be detached from keyboard focus. Clicking on a
    -- window will move keyboard focus to that window.
    follow_mouse = 2,

    -- Scroll with middle mouse button down.
    scroll_method = "on_button_down",
    scroll_button = 274,

    touchdevice = {
      output = "HDMI-A-1",
      enabled = true,
    },
  },
})

-- Enable touchpad gestures for changing workspaces.
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
-- hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Enable touchpad gestures for moving focus (helpful on scrolling layout).
-- hl.gesture({ fingers = 3, direction = "left", action = function() hl.dispatch(hl.dsp.focus({ direction = "l" })) end })
-- hl.gesture({ fingers = 3, direction = "right", action = function() hl.dispatch(hl.dsp.focus({ direction = "r" })) end })
hl.gesture({
  fingers = 3,
  direction = "up",
  action = function()
    hl.dispatch(hl.dsp.exec_cmd("omarchy-shell shell summon mirador '{}'"))
  end,
})

hl.gesture({
  fingers = 3,
  direction = "down",
  action = function()
    hl.dispatch(hl.dsp.exec_cmd("omarchy-shell shell hide mirador"))
  end,
})
