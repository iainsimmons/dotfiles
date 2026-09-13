-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
-- omarchy_default_bindings = false
--
-- Or disable only bindings for Omarchy's preinstalled apps/web apps while
-- keeping core window-manager bindings:
-- omarchy_preinstalled_bindings = false

-- Load Omarchy defaults.
require("default.hypr.omarchy")

-- Put your personal overrides in these files. They're loaded after Omarchy's
-- defaults so package updates can improve the defaults without rewriting your
-- ~/.config/hypr files.
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.envs")
require("hypr.looknfeel")
require("hypr.autostart")
require("hypr.tiling")
require("hypr.workspaces")

-- Toggle config flags dynamically.
require("default.hypr.toggles")

-- Load the MacBook-only input override (installed via the config.macbook.toml
-- mise overlay). Only present on the MacBook, so this no-ops on the desktop.
do
  local path = os.getenv("HOME") .. "/.config/hypr/input.macbook.lua"
  local file = io.open(path, "r")
  if file then
    file:close()
    dofile(path)
  end
end

-- Add any other personal Hyprland configuration below.
-- o.window("qemu", { workspace = "5" })

-- Added by hyprmoncfg: its generated monitor rules load last, so nothing before this can override the applied layout.
do local path = os.getenv("HOME") .. "/.config/hypr/hyprmoncfg-monitors.lua"; local file = io.open(path, "r"); if file then file:close(); dofile(path) end end
