local wezterm = require("wezterm")
local f = require("utils/font")
local w = require("utils/wallpaper")
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

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- config.debug_key_events = true
-- Appearance
config.color_scheme = "Vice Dark (base16)"
config.background = {
  w.get_wallpaper(),
  {
    source = {
      Color = "#000",
    },
    width = "100%",
    height = "100%",
    opacity = 0.2,
  },
}
config.font = f.get_font()
config.font_rules = {
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
}
config.font_size = 20
config.adjust_window_size_when_changing_font_size = false
config.command_palette_font_size = 20.0
config.enable_scroll_bar = false
config.enable_tab_bar = true
config.native_macos_fullscreen_mode = false
config.use_dead_keys = false
config.window_decorations = "RESIZE"
config.window_padding = {
  left = "6px",
  right = "2px",
  top = "8px",
  bottom = "2px",
}
config.scrollback_lines = 5000
-- Spawn a fish shell in login mode
config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
config.default_workspace = "dotfiles"

-- keymaps
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false
-- Use tmux prefix as leader
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = require("keymaps")

config.set_environment_variables = {
  -- prepend the path to your utility and include the rest of the PATH
  PATH = "/opt/homebrew/bin:" .. os.getenv("PATH"),
}

-- Tabline
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

-- Workspace Switcher
workspace_switcher.zoxide_path = "/opt/homebrew/bin/zoxide"
workspace_switcher.apply_to_config(config)

-- Hyperlinks
-- make username/project paths clickable. this implies paths like the following are for github.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
table.insert(config.hyperlink_rules, {
  regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
  format = "https://www.github.com/$1/$3",
})

return config
