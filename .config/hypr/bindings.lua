-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Unbind Omarchy defaults.
-- Note: hl.unbind is case-sensitive and must exactly match the default bind.
hl.unbind("SUPER + SHIFT + A")
hl.unbind("SUPER + CTRL + C")
hl.unbind("SUPER + G")
hl.unbind("SUPER + SHIFT + G")
hl.unbind("SUPER + ALT + G")
hl.unbind("SUPER + S")
hl.unbind("SUPER + ALT + S")
hl.unbind("SUPER + X")
hl.unbind("SUPER + SHIFT + X")
hl.unbind("PRINT")
hl.unbind("SUPER + PRINT")
hl.unbind("SUPER + BACKSPACE")
hl.unbind("SUPER + RETURN")

-- Remove the Omarchy "move window to workspace" defaults; they are replaced by
-- SUPER+SHIFT+CTRL+code below.
for workspace = 10, 19 do
  hl.unbind("SUPER + SHIFT + code:" .. tostring(workspace))
end

hl.unbind("SUPER + LEFT")
hl.unbind("SUPER + SHIFT + LEFT")
hl.unbind("SUPER + RIGHT")
hl.unbind("SUPER + SHIFT + RIGHT")
hl.unbind("SUPER + UP")
hl.unbind("SUPER + DOWN")
hl.unbind("SUPER + ALT + SPACE")

-- Unbind keys that kitty.conf uses inside kitty (tmux/nvim control scheme),
-- so Hyprland doesn't swallow them.
hl.unbind("SUPER + SHIFT + B")
hl.unbind("SUPER + SHIFT + C")
hl.unbind("SUPER + SHIFT + D")
hl.unbind("SUPER + SHIFT + E")

-- My custom bindings
hl.bind("SUPER + BACKSPACE", hl.dsp.send_shortcut({ mods = "", key = "DELETE" }), { description = "Send DELETE" })
hl.bind("SUPER + LEFT", hl.dsp.send_shortcut({ mods = "", key = "HOME" }), { description = "Send HOME" })
hl.bind("SUPER + RIGHT", hl.dsp.send_shortcut({ mods = "", key = "END" }), { description = "Send END" })
hl.bind(
  "SUPER + SHIFT + LEFT",
  hl.dsp.send_shortcut({ mods = "SHIFT", key = "HOME" }),
  { description = "Send SHIFT+HOME" }
)
hl.bind(
  "SUPER + SHIFT + RIGHT",
  hl.dsp.send_shortcut({ mods = "SHIFT", key = "END" }),
  { description = "Send SHIFT+END" }
)
hl.bind("SUPER + UP", hl.dsp.send_shortcut({ mods = "", key = "PRIOR" }), { description = "Send PAGE UP" })
hl.bind("SUPER + DOWN", hl.dsp.send_shortcut({ mods = "", key = "NEXT" }), { description = "Send PAGE DOWN" })
hl.bind(
  "SUPER + SHIFT + UP",
  hl.dsp.send_shortcut({ mods = "SHIFT", key = "PRIOR" }),
  { description = "Send SHIFT+PAGE UP" }
)
hl.bind(
  "SUPER + SHIFT + DOWN",
  hl.dsp.send_shortcut({ mods = "SHIFT", key = "NEXT" }),
  { description = "Send SHIFT+PAGE DOWN" }
)

o.bind("SUPER + CTRL + SHIFT + ALT + RETURN", "Terminal", "omarchy-launch-or-focus kitty")
o.bind("SUPER + CTRL + SHIFT + ALT + E", "Files", "uwsm app -- nautilus --new-window")
o.bind(
  "SUPER + CTRL + SHIFT + ALT + B",
  "Browser",
  'omarchy-launch-or-focus helium "uwsm app -- helium-browser --enable-features=UseOzonePlatform --ozone-platform=wayland"'
)
o.bind("SUPER + CTRL + SHIFT + ALT + M", "Music", "uwsm app -- spotify")
o.bind("SUPER + CTRL + SHIFT + ALT + N", "Neovim", "omarchy-launch-tui nvim")
o.bind("SUPER + CTRL + SHIFT + ALT + D", "Discord", "omarchy-launch-or-focus vesktop")
o.bind("SUPER + CTRL + SHIFT + ALT + T", "Steam", "omarchy-launch-or-focus steam")
o.bind("SUPER + CTRL + SHIFT + ALT + O", "Obsidian", 'omarchy-launch-or-focus obsidian "uwsm-app -- obsidian"')
o.bind("SUPER + CTRL + SHIFT + ALT + BACKSLASH", "1Password", "uwsm app -- 1password")
-- Clipboard history (commented out): cliphist + walker
-- o.bind("SUPER + CTRL + C", "Clipboard", "cliphist list | walker -m clipboard | cliphist decode | wl-copy")

o.bind(
  "SUPER + CTRL + SHIFT + ALT + Y",
  "YouTube Kids",
  'omarchy-launch-or-focus-webapp "YouTube Kids" "https://youtubekids.com/"'
)

-- Color picker
o.bind("SUPER + SHIFT + code:11", "Color picker", "pkill hyprpicker || hyprpicker -a") -- CMD SHIFT 2

-- Screenshots (map to same as macOS)
o.bind("SUPER + SHIFT + code:12", "Screenshot", "omarchy capture screenshot smart") -- CMD SHIFT 3
o.bind("SUPER + SHIFT + code:13", "Capture menu", "omarchy menu summon capture") -- CMD SHIFT 4
-- Screen recording
o.bind("SUPER + SHIFT + code:14", "Screenrecording", "omarchy capture screenrecording") -- CMD SHIFT 5

-- Will switch to a submap called social.
hl.bind("SUPER + CTRL + SHIFT + ALT + S", hl.dsp.submap("social"), { description = "Social submap" })
hl.define_submap("social", function()
  o.bind("W", "WhatsApp", 'omarchy-launch-webapp "https://web.whatsapp.com/"')
  o.bind("G", "Google Messages", 'omarchy-launch-webapp "https://messages.google.com/web/conversations"')
  o.bind("F", "Facebook Messenger", 'omarchy-launch-webapp "https://www.messenger.com"')
  -- Use reset to go back to the global submap.
  hl.bind("ESCAPE", hl.dsp.submap("reset"), { description = "Reset submap" })
  hl.bind("catchall", hl.dsp.submap("reset"))
end)
