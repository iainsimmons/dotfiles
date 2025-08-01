---@diagnostic disable: param-type-mismatch, assign-type-mismatch
local k = require("utils/keys")
local f = require("utils/font")
local w = require("utils/wallpaper")
local wezterm = require("wezterm") --[[@as Wezterm]]
local act = wezterm.action
local mux = wezterm.mux

-------------
-- Plugins --
-------------

local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
workspace_switcher.zoxide_path = "/opt/homebrew/bin/zoxide"

-------------
-- Tabline --
-------------
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
local process_to_icon = {
  ["fish"] = { wezterm.nerdfonts.md_fish, color = { fg = "#faba4a" } },
  ["git"] = { wezterm.nerdfonts.dev_git, color = { fg = "#f05133" } },
  ["lazygit"] = { wezterm.nerdfonts.dev_git, color = { fg = "#f05133" } },
  ["node"] = { wezterm.nerdfonts.md_nodejs, color = { fg = "#417e38" } },
}
tabline.setup({
  options = {
    icons_enabled = true,
    tabs_enabled = true,
    theme_overrides = {},
    section_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = wezterm.nerdfonts.pl_right_hard_divider,
    },
    component_separators = {
      left = wezterm.nerdfonts.pl_left_soft_divider,
      right = wezterm.nerdfonts.pl_right_soft_divider,
    },
    tab_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = wezterm.nerdfonts.pl_right_hard_divider,
    },
  },
  sections = {
    tabline_a = { "workspace" },
    tabline_b = { " " },
    tabline_c = { " " },
    -- tab_active = {
    --   "index",
    --   { "parent", padding = 0 },
    --   "/",
    --   { "cwd", padding = { left = 0, right = 1 } },
    --   { "zoomed", padding = 0 },
    -- },
    tab_active = { "index", { "process", process_to_icon = process_to_icon, padding = { left = 0, right = 1 } } },
    tab_inactive = { "index", { "process", process_to_icon = process_to_icon, padding = { left = 0, right = 1 } } },
    tabline_x = {},
    tabline_y = {},
    tabline_z = {
      "mode",
      fmt = function(str)
        return string.sub(str, 1, 2)
      end,
    },
  },
  extensions = {},
})

------------
-- Events --
------------

-- maximize all displayed windows on startup
wezterm.on("gui-attached", function()
  local workspace = mux.get_active_workspace()
  for _, window in ipairs(mux.all_windows()) do
    if window:get_workspace() == workspace then
      window:gui_window():maximize()
    end
  end
end)

-- configuration for commands to run upon creating new workspaces (see below)
-- this is a Lua table where the key is the path to match on (anywhere in the zoxide label_path)
-- (note that this means `~` should be used for the home directory that WezTerm uses)
-- and the value is a Lua table where each item represents a tab in the created workspace
-- and the command to run in it (by sending the text directly to the pane in that tab)
-- e.g.
-- ```lua
-- {
--   ["~/.config"] = {
--     "nvim",
--     "yazi",
--     "lazygit"
--   }
-- }
-- ```
-- the above would match any selected path from the workspace switcher containing `~/.config`
-- and open 3 tabs, running nvim, yazi and lazygit respectively
local workspace_config = {
  ["~/dev/Squiz/"] = {
    "fnm use default && nvim",
    "",
  },
  ["~/dotfiles"] = {
    "nvim",
  },
  ["~/.config/nvim"] = {
    "nvim",
  },
  ["~/Downloads"] = {
    "yazi",
  },
}

-- whenever I create a new workspace
wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, _, label_path)
  -- loop over the key/value pairs in the workspace_config above
  for path, tabs in pairs(workspace_config) do
    -- if the label_path from zoxide / workspace switcher matches a configured path
    if string.match(label_path, path) then
      -- get the initial pane created
      local initial_pane = window:active_pane()
      -- loop over the tabs to get each command to run
      for index, command in ipairs(tabs) do
        -- add a trailing newline if the command doesn't have one
        if #command > 0 and not string.match(command, "\n", -1) then
          command = command .. "\n"
        end

        -- if this is the first configured command, run in the initial pane
        if index == 1 then
          initial_pane:send_text(command)
        else
          -- else, spawn a new tab and run the command in the pane in that tab
          local _, pane = window:spawn_tab({})
          pane:send_text(command)
        end
      end
      -- then finally, focus on the first tab and pane
      -- and break out of the loop
      -- (i.e. use the first matching configured path)
      initial_pane:activate()
      break
    end
  end
end)

-- whenever I select an active workspace
-- wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function() end)

wezterm.on("user-var-changed", function(window, pane, name, value)
  if name == "switch-workspace" then
    local cmd_context = wezterm.json_parse(value)
    window:perform_action(
      act.SwitchToWorkspace({
        name = cmd_context.workspace,
        spawn = {
          cwd = cmd_context.cwd,
        },
      }),
      pane
    )
  end
end)

------------
-- Config --
------------
local config = {}
config = wezterm.config_builder()

config.set_environment_variables = {
  PATH = "/opt/homebrew/bin:" .. os.getenv("PATH"),
}

config.default_workspace = "dotfiles"
config.default_cwd = wezterm.home_dir .. "/dotfiles"
-- config.debug_key_events = true,
config.font = f.get_font()
config.font_size = 20
config.line_height = 1.2
-- disable ligatures
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
-- Spawn a fish shell in login mode
config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
config.enable_scroll_bar = false
config.use_dead_keys = false
config.window_padding = {
  left = 10,
  right = 10,
  top = 0,
  bottom = 0,
}
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false
config.adjust_window_size_when_changing_font_size = false
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_max_width = 32
config.native_macos_fullscreen_mode = false
config.window_decorations = "RESIZE"
config.scrollback_lines = 5000
config.max_fps = 120
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.background = {
  w.get_wallpaper(),
  {
    source = {
      Color = "#000",
    },
    width = "100%",
    height = "100%",
    opacity = 0.4,
  },
}
config.color_scheme = "tokyonight_night"
config.status_update_interval = 100
config.disable_default_key_bindings = false

-------------
-- Keymaps --
-------------
config.keys = {
  {
    key = "L",
    mods = "CTRL|SHIFT",
    action = act.ShowDebugOverlay,
  },
  -- Activate copy mode (Ctrl + Shift + x)
  k.cmd_key("c", act.ActivateCopyMode),
  -- Delete word/line
  k.cmd_key("Backspace", act.SendKey({ key = "\x15" })),
  -- Go to start of line
  k.cmd_key("LeftArrow", act.SendString("\x1bOH")),
  -- Go to end of line
  k.cmd_key("RightArrow", act.SendString("\x1bOF")),
  -- Workspace Switcher: Select and switch workspace
  k.cmd_key(
    "j",
    workspace_switcher.switch_workspace({
      extra_args = " | /opt/homebrew/bin/rg --invert-match '/.ssh|/.local|/Volumes|/Library'",
    })
  ),
  -- Workspace Switcher: Switch to previous workspace
  k.cmd_key("l", workspace_switcher.switch_to_prev_workspace()),
  -- Neovim: Save current buffer
  k.cmd_key(
    "s",
    act.Multiple({
      act.SendKey({ key = "Escape" }), -- escape
      k.multiple_actions(":w"),
    })
  ),
  -- Neovim: Close current buffer
  k.cmd_key(
    "b",
    act.Multiple({
      act.SendKey({ key = "Escape" }),
      k.multiple_actions(":bd"),
    })
  ),
  -- Neovim: Close current buffer, without saving
  k.cmd_key(
    "B",
    act.Multiple({
      act.SendKey({ key = "Escape" }),
      k.multiple_actions(":bd!"),
    })
  ),
  -- Neovim: Open file explorer
  k.cmd_key(
    "f",
    act.Multiple({
      act.SendKey({ key = "Escape" }),
      act.SendKey({ key = "Space" }),
      act.SendKey({ key = "f" }),
      act.SendKey({ key = "m" }),
    })
  ),
  -- Neovim: Open smart picker
  k.cmd_key(
    "p",
    act.Multiple({
      act.SendKey({ key = "Escape" }),
      act.SendKey({ key = "Space" }),
      act.SendKey({ key = "," }),
    })
  ),
  -- Open Lazygit in new tab
  k.cmd_key(
    "g",
    act.SpawnCommandInNewTab({
      args = {
        "/opt/homebrew/bin/lazygit",
        "-ucd",
        "/Users/isimmons/.config/lazygit",
      },
    })
  ),
  -- Open Yazi in new tab
  k.cmd_key(
    "y",
    act.SpawnCommandInNewTab({
      args = {
        "/opt/homebrew/bin/yazi",
      },
    })
  ),
  k.cmd_key(
    "o",
    act.QuickSelectArgs({
      label = "open url",
      patterns = {
        "https?://[^\\s\"'`)>|]+",
        [[["'`]?((?:[\w\d]{1}[-\w\d]+)/{1}[-\w\d\.]+)["'`]?]],
      },
      ---@diagnostic disable-next-line: missing-parameter
      action = wezterm.action_callback(function(window, pane)
        local url = window:get_selection_text_for_pane(pane)
        if not string.match(url, "^http") then
          url = "https://www.github.com/" .. url
        end
        wezterm.log_info("opening: " .. url)
        wezterm.open_with(url)
      end),
    })
  ),
}

config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = act.OpenLinkAtMouseCursor,
  },
  -- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
  {
    event = { Down = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = act.Nop,
  },
}

---------------------
-- Hyperlink Rules --
---------------------

-- From https://wezterm.org/hyperlinks.html
-- Use the defaults as a base
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- make username/project paths clickable. this implies paths like the following are for github.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wezterm/wezterm | "wezterm/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
table.insert(config.hyperlink_rules, {
  regex = [[["'`]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["'`]?]],
  format = "https://www.github.com/$1/$3",
})

return config
