-- Workspace and window rules.

-- Assign workspaces to monitors.
-- 1-7 on the Dell (HDMI-A-2), 8-10 on the Daewoo mini-monitor (HDMI-A-1).
hl.workspace_rule({ workspace = "1", monitor = "HDMI-A-2", default = true })
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-2" })
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-2" })
hl.workspace_rule({ workspace = "4", monitor = "HDMI-A-2" })
hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-2" })
hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-2" })
hl.workspace_rule({ workspace = "7", monitor = "HDMI-A-2" })
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "9", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "10", monitor = "HDMI-A-1", default = true })

-- workspace-1 = browsers
o.window("^(?i).*helium.*", { workspace = "1" })
o.window("^(?i).*vivaldi.*", { workspace = "1" })
o.window("^(?i).*chromium.*", { workspace = "1" })
o.window("^(?i).*youtube.*", { workspace = "1" })

-- workspace-2 = terminal
o.window("^(?i).*wezterm.*", { workspace = "2" })
o.window("^(?i).*kitty.*", { workspace = "2" })
o.window("^(?i).*neovim.*", { workspace = "2" })
o.window("^(?i).*ghostty.*", { workspace = "2" })

-- workspace-3 = notes
o.window("^(?i).*obsidian.*", { workspace = "3" })

-- workspace-4 = files
o.window("^(?i).*nautilus.*", { workspace = "4" })
o.window("^(?i).*yazi.*", { workspace = "4" })

-- workspace-5 = communication
o.window("^(?i).*discord.*", { workspace = "5" })
o.window("^(?i).*vesktop.*", { workspace = "5" })
o.window("^(?i).*whatsapp.*", { workspace = "5" })
o.window("^(?i).*messages.*", { workspace = "5" })
o.window("^(?i).*messenger.*", { workspace = "5" })
o.window("^(?i).*zoom.*", { workspace = "5" })

-- workspace-6 = games
o.window("^(?i).*steam.*", { workspace = "6" })
hl.window_rule({
  name = "tabletop-simulator",
  match = { class = "^(?i)(Tabletop Simulator\\.x86_64)$" },
  suppress_event = "fullscreen",
  workspace = "6",
})
o.window("^(?i).*retroarch.*", { workspace = "6" })
o.window("^(?i).*es-de.*", { workspace = "6" })
o.window("^(?i).*rpcs3.*", { workspace = "6" })

-- workspace-7 = media
o.window("^(?i).*spotify.*", { workspace = "7" })
o.window("^(?i).*cliamp.*", { workspace = "7" })
o.window("^(?i).*mpv.*", { workspace = "7" })
o.window("^(?i).*pinta.*", { workspace = "7" })

-- workspace-8 = office
o.window("^(?i).*office.*", { workspace = "8" })

-- workspace-10 = Tick Tick (tasks)
hl.window_rule({
  name = "tick-tick",
  match = { class = "^(?i).*ticktick.*" },
  workspace = "10",
  monitor = "HDMI-A-1",
  fullscreen = true,
  sync_fullscreen = true,
  idle_inhibit = "fullscreen",
})

-- Shows a black rectangle instead of the app when sharing screen.
o.window("1Password", { no_screen_share = true })
o.window("^(?i).*discord.*", { no_screen_share = true })
o.window("^(?i).*vesktop.*", { no_screen_share = true })
o.window("^(?i).*whatsapp.*", { no_screen_share = true })
o.window("^(?i).*messages.*", { no_screen_share = true })
o.window("^(?i).*messenger.*", { no_screen_share = true })
o.window("^(?i).*zoom.*", { no_screen_share = true })

o.window(".*", { opacity = "0.97 0.9" })
o.window("(Alacritty|kitty|com.mitchellh.ghostty|org.wezfurlong.wezterm)", { tag = "+terminal" })
hl.window_rule({ match = { tag = "terminal" }, tag = "-default-opacity" })
hl.window_rule({ match = { tag = "terminal" }, opacity = "0.9 override 0.9 override 1.0 override" })
hl.window_rule({ match = { class = "^(?i).*helium.*" }, opacity = "1.0 override 1.0 override 1.0 override" })
