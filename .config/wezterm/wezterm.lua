---@diagnostic disable: param-type-mismatch, assign-type-mismatch
local k = require("utils/keys")
local f = require("utils/font")
local wezterm = require("wezterm") --[[@as Wezterm]]
local act = wezterm.action

------------
-- Config --
------------
local config = {}
config = wezterm.config_builder()

config.set_environment_variables = {
  PATH = "/usr/bin:" .. os.getenv("PATH"),
}

config.default_workspace = "dotfiles"
config.default_cwd = wezterm.home_dir .. "/dotfiles"
config.debug_key_events = true
config.font = f.get_font()
config.font_size = 14
config.freetype_load_flags = "NO_HINTING"
-- disable ligatures
config.line_height = 1.2
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
-- Spawn a fish shell in login mode
config.default_prog = { "/usr/bin/fish", "-l" }
config.enable_scroll_bar = false
config.use_dead_keys = false
config.window_padding = {
  left = 10,
  right = 10,
  top = 0,
  bottom = 0,
}
-- config.send_composed_key_when_left_alt_is_pressed = false
-- config.send_composed_key_when_right_alt_is_pressed = false
config.adjust_window_size_when_changing_font_size = false
config.enable_tab_bar = false
config.use_fancy_tab_bar = false
config.tab_max_width = 32
-- config.window_decorations = "RESIZE"
config.scrollback_lines = 5000
-- config.max_fps = 120
-- config.front_end = "WebGpu"
-- config.webgpu_power_preference = "HighPerformance"
config.background = {
  {
    source = {
      Color = "#000",
    },
    width = "100%",
    height = "100%",
    opacity = 0.8,
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
  -- tmux
  -- Change to the next tmux window
  {
    mods = "CMD|SHIFT",
    key = "}",
    action = act.Multiple({
      act.SendKey({ mods = "CTRL", key = "b" }),
      act.SendKey({ key = "n" }),
    }),
  },
  -- Change to the previous tmux window
  {
    mods = "CMD|SHIFT",
    key = "{",
    action = act.Multiple({
      act.SendKey({ mods = "CTRL", key = "b" }),
      act.SendKey({ key = "p" }),
    }),
  },
  -- Change pane layout
  {
    mods = "CMD|SHIFT",
    key = ")",
    action = act.Multiple({
      act.SendKey({ mods = "CTRL", key = "b" }),
      act.SendKey({ key = "Space" }),
    }),
  },
  -- Rotate tmux panes
  {
    mods = "CMD",
    key = "[",
    action = act.Multiple({
      act.SendKey({ mods = "CTRL", key = "b" }),
      act.SendKey({ mods = "ALT", key = "o" }),
    }),
  },
  -- Switch to last active pane
  {
    mods = "CTRL",
    key = "\\",
    action = act.Multiple({
      act.SendKey({ mods = "CTRL", key = "b" }),
      act.SendKey({ key = ";" }),
    }),
  },
  -- switch to previous session
  {
    mods = "CMD|SHIFT",
    key = "j",
    action = act.Multiple({
      act.SendKey({ mods = "CTRL", key = "b" }),
      act.SendKey({ mods = "SHIFT", key = "l" }),
    }),
  },
  -- switch to previous sesh session (works after closing)
  {
    mods = "CMD",
    key = "l",
    action = act.Multiple({
      act.SendKey({ mods = "CTRL", key = "b" }),
      act.SendKey({ mods = "CTRL", key = "l" }),
    }),
  },
  -- rename tmux window
  {
    mods = "CMD|ALT",
    key = ",",
    action = act.Multiple({
      act.SendKey({ mods = "CTRL", key = "b" }),
      act.SendKey({ key = "," }),
    }),
  },

  -- Select window 1-9
  k.cmd_to_tmux_prefix("1", "1"),
  k.cmd_to_tmux_prefix("2", "2"),
  k.cmd_to_tmux_prefix("3", "3"),
  k.cmd_to_tmux_prefix("4", "4"),
  k.cmd_to_tmux_prefix("5", "5"),
  k.cmd_to_tmux_prefix("6", "6"),
  k.cmd_to_tmux_prefix("7", "7"),
  k.cmd_to_tmux_prefix("8", "8"),
  k.cmd_to_tmux_prefix("9", "9"),
  -- Close current buffer in Neovim via tmux a keybind
  k.cmd_to_tmux_prefix("b", "a"),
  -- Close current buffer in Neovim (without saving) via tmux B keybind
  k.cmd_to_tmux_prefix("B", "B"),
  -- Change to tmux copy mode
  k.cmd_to_tmux_prefix("c", "["),
  -- Detach session
  k.cmd_to_tmux_prefix("D", "d"),
  -- Split the current pane into two, top and bottom
  k.cmd_to_tmux_prefix("e", '"'),
  -- Split the current pane into two, left and right
  k.cmd_to_tmux_prefix("E", "%"),
  -- Toggle mini.files via tmux y keybind
  k.cmd_to_tmux_prefix("f", "y"),
  -- Open lazygit in a new tmux window
  k.cmd_to_tmux_prefix("g", "g"),
  -- Jump to new/existing window via sesh
  -- https://github.com/joshmedeski/sesh
  k.cmd_to_tmux_prefix("j", "t"),
  -- switch to previous session
  -- k.cmd_to_tmux_prefix("J", "L"),
  -- Open yazi in a new tmux window
  k.cmd_to_tmux_prefix("y", "A"),
  -- Open URLs 'joshmedeski/tmux-fzf-url'
  k.cmd_to_tmux_prefix("o", "u"),
  -- Find files with Telescope, with grep, including hidden, ignoring .git via tmux Y keybind
  k.cmd_to_tmux_prefix("p", "Y"),
  -- Create a new tmux window/tab
  k.cmd_to_tmux_prefix("t", "c"),
  --Break the current tmux pane out of the tmux window
  k.cmd_to_tmux_prefix("T", "!"),
  -- Kill/close the current tmux pane (and window if last pane)
  k.cmd_to_tmux_prefix("w", "x"),
  -- Toggle the zoom state of the current tmux pane
  k.cmd_to_tmux_prefix("z", "z"),
  -- Cycle through tmux panes
  k.cmd_to_tmux_prefix("]", "o"),
  -- tmux-fuzzback (search scrollback with fuzzy finder)
  k.cmd_to_tmux_prefix("/", "b"),
  -- Open tmux command input
  k.cmd_to_tmux_prefix(";", ":"),
  -- Rename the current tmux session
  k.cmd_to_tmux_prefix(",", "$"),
  -- Type <escape>:w<enter> to save current buffer in Neovim/Vim
  k.cmd_to_tmux_prefix("'", "s"),
  -- Use arrow keys to jump to a pane in the relevant direction
  k.cmd_to_tmux_prefix("UpArrow", "UpArrow"),
  k.cmd_to_tmux_prefix("DownArrow", "DownArrow"),
  k.cmd_to_tmux_prefix("LeftArrow", "LeftArrow"),
  k.cmd_to_tmux_prefix("RightArrow", "RightArrow"),
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
