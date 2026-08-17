-- Tiling keybindings.

-- Unbind Omarchy defaults.
-- Note: hl.unbind is case-sensitive and must exactly match the default bind.
hl.unbind("SUPER + TAB")
hl.unbind("SUPER + SHIFT + TAB")
hl.unbind("SUPER + F")
for workspace = 10, 19 do
  hl.unbind("SUPER + code:" .. tostring(workspace))
end
hl.unbind("SUPER + J")
hl.unbind("SUPER + L")
hl.unbind("SUPER + O")
hl.unbind("SUPER + P")
hl.unbind("SUPER + T")
hl.unbind("SUPER + W")

-- Unbind defaults that are replaced by the binds below.
hl.unbind("SUPER + CTRL + LEFT")
hl.unbind("SUPER + CTRL + RIGHT")
hl.unbind("SUPER + CTRL + code:20")
hl.unbind("SUPER + CTRL + code:21")
hl.unbind("SUPER + CTRL + SHIFT + code:20")
hl.unbind("SUPER + CTRL + SHIFT + code:21")
hl.unbind("SUPER + SHIFT + F")
hl.unbind("SUPER + SHIFT + P")

-- Close window
hl.bind("SUPER + Q", hl.dsp.window.close(), { description = "Close window" })

-- Control tiling
hl.bind("SUPER + SHIFT + BACKSLASH", hl.dsp.layout("togglesplit"), { description = "Toggle window split" })
hl.bind("SUPER + SHIFT + P", hl.dsp.window.pseudo(), { description = "Pseudo window" })
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }), { description = "Toggle fullscreen" })
hl.bind("SUPER + SHIFT + F", function()
  hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
  hl.dispatch(hl.dsp.window.center())
end, { description = "Toggle floating/tiling and center" })
o.bind("SUPER + SHIFT + O", "Pop window out (float & pin)", "omarchy-hyprland-window-pop")
o.bind("SUPER + SHIFT + L", "Toggle workspace layout", "omarchy-hyprland-workspace-layout-toggle")

-- Move focus with mainMod + arrow keys / hjkl
hl.bind("SUPER + CTRL + LEFT", hl.dsp.focus({ direction = "l" }), { description = "Focus on left window" })
hl.bind("SUPER + CTRL + DOWN", hl.dsp.focus({ direction = "d" }), { description = "Focus on below window" })
hl.bind("SUPER + CTRL + UP", hl.dsp.focus({ direction = "u" }), { description = "Focus on above window" })
hl.bind("SUPER + CTRL + RIGHT", hl.dsp.focus({ direction = "r" }), { description = "Focus on right window" })
hl.bind("SUPER + CTRL + SHIFT + ALT + H", hl.dsp.focus({ direction = "l" }), { description = "Focus on left window" })
hl.bind("SUPER + CTRL + SHIFT + ALT + J", hl.dsp.focus({ direction = "d" }), { description = "Focus on below window" })
hl.bind("SUPER + CTRL + SHIFT + ALT + K", hl.dsp.focus({ direction = "u" }), { description = "Focus on above window" })
hl.bind("SUPER + CTRL + SHIFT + ALT + L", hl.dsp.focus({ direction = "r" }), { description = "Focus on right window" })

-- Cycle through workspaces
o.bind("SUPER + CTRL + TAB", "Workspace overview", "omarchy-shell shell summon mirador '{}'")
o.bind("SUPER + TAB", "Cycle workspace next", "~/bin/cycle-active-workspaces next")
o.bind("SUPER + SHIFT + TAB", "Cycle workspace prev", "~/bin/cycle-active-workspaces prev")
hl.bind("SUPER + CTRL + SHIFT + ALT + LEFT", hl.dsp.focus({ workspace = "-1" }), { description = "Previous workspace" })
hl.bind(
  "SUPER + CTRL + SHIFT + ALT + DOWN",
  hl.dsp.focus({ workspace = "emptynm" }),
  { description = "Empty next workspace" }
)
hl.bind("SUPER + CTRL + SHIFT + ALT + UP", hl.dsp.focus({ workspace = "1" }), { description = "First workspace" })
hl.bind("SUPER + CTRL + SHIFT + ALT + RIGHT", hl.dsp.focus({ workspace = "+1" }), { description = "Next workspace" })

-- Switch workspaces with hyper + [0-9]
for workspace = 1, 10 do
  hl.bind(
    "SUPER + CTRL + SHIFT + ALT + code:" .. tostring(workspace + 9),
    hl.dsp.focus({ workspace = tostring(workspace) }),
    { description = "Switch to workspace " .. workspace }
  )
end

-- Move active window to a workspace with CMD + SHIFT + CTRL + [0-9]
for workspace = 1, 10 do
  hl.bind(
    "SUPER + SHIFT + CTRL + code:" .. tostring(workspace + 9),
    hl.dsp.window.move({ workspace = tostring(workspace) }),
    { description = "Move window to workspace " .. workspace }
  )
end

-- Swap active window with CMD + SHIFT + CTRL + arrow keys
hl.bind(
  "SUPER + SHIFT + CTRL + LEFT",
  hl.dsp.window.swap({ direction = "l" }),
  { description = "Swap window to the left" }
)
hl.bind(
  "SUPER + SHIFT + CTRL + RIGHT",
  hl.dsp.window.swap({ direction = "r" }),
  { description = "Swap window to the right" }
)
hl.bind("SUPER + SHIFT + CTRL + UP", hl.dsp.window.swap({ direction = "u" }), { description = "Swap window up" })
hl.bind("SUPER + SHIFT + CTRL + DOWN", hl.dsp.window.swap({ direction = "d" }), { description = "Swap window down" })

-- Resize active window
hl.bind(
  "SUPER + CTRL + MINUS",
  hl.dsp.window.resize({ x = -100, y = 0, relative = true }),
  { description = "Resize active window -100 0" }
)
hl.bind(
  "SUPER + CTRL + EQUAL",
  hl.dsp.window.resize({ x = 100, y = 0, relative = true }),
  { description = "Resize active window 100 0" }
)
hl.bind(
  "SUPER + SHIFT + CTRL + MINUS",
  hl.dsp.window.resize({ x = 0, y = -100, relative = true }),
  { description = "Resize active window 0 -100" }
)
hl.bind(
  "SUPER + SHIFT + CTRL + EQUAL",
  hl.dsp.window.resize({ x = 0, y = 100, relative = true }),
  { description = "Resize active window 0 100" }
)

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window" })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })
