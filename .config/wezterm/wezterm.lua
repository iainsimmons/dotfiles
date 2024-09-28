local f = require("utils/font")
local w = require("utils/wallpaper")
local keymaps = require("keymaps")
local wezterm = require("wezterm")
local mux = wezterm.mux
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

wezterm.on("gui-attached", function()
  -- maximize all displayed windows on startup
  local workspace = mux.get_active_workspace()
  for _, window in ipairs(mux.all_windows()) do
    if window:get_workspace() == workspace then
      window:gui_window():maximize()
    end
  end
end)

local config = {
  -- debug_key_events = true,
  -- Appearance
  color_scheme = "Vice Dark (base16)",
  background = {
    w.get_wallpaper(),
    {
      source = {
        Color = "#000",
      },
      width = "100%",
      height = "100%",
      opacity = 0.2,
    },
  },
  font = f.get_font(),
  font_rules = {
    {
      intensity = "Bold",
      italic = true,
      font = f.get_font("Bold"),
    },
    {
      intensity = "Normal",
      italic = true,
      font = f.get_font(),
    },
  },
  font_size = 20,
  adjust_window_size_when_changing_font_size = false,
  command_palette_font_size = 20.0,
  enable_scroll_bar = false,
  enable_tab_bar = true,
  native_macos_fullscreen_mode = false,
  use_dead_keys = false,
  window_decorations = "RESIZE",
  window_padding = {
    left = "6px",
    right = "2px",
    top = "8px",
    bottom = "2px",
  },
  scrollback_lines = 5000,
  -- Spawn a fish shell in login mode
  default_prog = { "/opt/homebrew/bin/fish", "-i" },
  default_workspace = "dotfiles",

  -- keymaps
  send_composed_key_when_left_alt_is_pressed = false,
  send_composed_key_when_right_alt_is_pressed = false,
  -- Use tmux prefix as leader
  leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 },
  keys = keymaps,
}

config.set_environment_variables = {
  -- prepend the path to your utility and include the rest of the PATH
  PATH = "/opt/homebrew/bin:" .. os.getenv("PATH"),
}

tabline.setup({
  extensions = { "smart_workspace_switcher" },
  options = {
    icons_enabled = true,
    theme = "Vice Dark (base16)",
    color_overrides = {
      -- base00: "#181818"
      -- base01: "#222222"
      -- base02: "#323232"
      -- base03: "#3f3f3f"
      -- base04: "#666666"
      -- base05: "#818181"
      -- base06: "#c6c6c6"
      -- base07: "#e9e9e9"
      -- base08: "#ff29a8"
      -- base09: "#85ffe0"
      -- base0A: "#f0ffaa"
      -- base0B: "#0badff"
      -- base0C: "#8265ff"
      -- base0D: "#00eaff"
      -- base0E: "#00f6d9"
      -- base0F: "#ff3d81"
      tab = {
        active = { fg = "#181818", bg = "#8265ff" },
        inactive = { fg = "#c6c6c6", bg = "#181818" },
        inactive_hover = { fg = "#c6c6c6", bg = "#323232" },
      },
    },
    section_separators = "",
    component_separators = "",
    tab_separators = "",
  },
  sections = {
    tabline_a = { "workspace" },
    tabline_b = {},
    tabline_c = {},
    tab_active = {
      "index",
      { "process", icon = { color = false }, padding = { left = 0, right = 1 } },
      { "zoomed", padding = 0 },
    },
    tab_inactive = {
      "index",
      { "process", icon = { color = false }, padding = { left = 0, right = 1 } },
    },
    tabline_x = {},
    tabline_y = {},
    tabline_z = { "mode" },
  },
})

tabline.apply_to_config(config)
workspace_switcher.zoxide_path = "/opt/homebrew/bin/zoxide"
workspace_switcher.apply_to_config(config)

wezterm.on("smart_workspace_switcher.workspace_switcher.chosen", function(window, workspace)
  local gui_win = window:gui_window()
  local base_path = string.gsub(workspace, "(.*[/\\])(.*)", "%2")
  gui_win:set_right_status(wezterm.format({
    { Foreground = { Color = "green" } },
    { Text = base_path .. "  " },
  }))
end)

wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, workspace)
  local gui_win = window:gui_window()
  local base_path = string.gsub(workspace, "(.*[/\\])(.*)", "%2")
  gui_win:set_right_status(wezterm.format({
    { Foreground = { Color = "green" } },
    { Text = base_path .. "  " },
  }))
end)

return config
