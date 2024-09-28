local wezterm = require("wezterm")
local act = wezterm.action
local k = require("utils/keys")
local sc = require("utils/spawn_commands")
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

local function basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local function is_vim(pane)
  local exe = basename(pane:get_foreground_process_name())
  return exe == "vim" or exe == "nvim"
end

local function is_nvim(pane)
  local exe = basename(pane:get_foreground_process_name())
  return exe == "nvim"
end

local keys = {
  -- Send "CTRL-B" to the terminal when pressing CTRL-B, CTRL-B
  {
    key = "b",
    mods = "LEADER|CTRL",
    action = wezterm.action.SendKey({ key = "b", mods = "CTRL" }),
  },
  -- WezTerm app
  k.cmd_key("q", act.QuitApplication),
  k.cmd_key("h", act.HideApplication),
  k.cmd_key("v", act.PasteFrom("Clipboard")),
  k.cmd_key("-", act.DecreaseFontSize),
  k.cmd_key("=", act.IncreaseFontSize),
  k.cmd_key("0", act.ResetFontSize),
  -- Reload config
  {
    key = "r",
    mods = "CMD|SHIFT",
    action = act.ReloadConfiguration,
  },
  -- Panes
  {
    key = "|",
    mods = "LEADER|SHIFT",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "=",
    mods = "LEADER",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "w",
    mods = "LEADER",
    action = act.CloseCurrentPane({ confirm = false }),
  },

  -- Vim/Neovim
  -- Save Buffer
  k.cmd_key(
    "s",
    k.vim_action(
      act.Multiple({
        act.SendKey({ key = "\x1b" }), -- escape
        k.multiple_actions(":w"), -- write/save buffer
      }),
      act.SendKey({ key = "s" })
    )
  ),
  -- Close
  k.cmd_key(
    "b",
    k.vim_action(
      act.Multiple({
        act.SendKey({ key = "\x1b" }), -- escape
        k.multiple_actions(":bd"), -- close buffer
      }),
      act.SendKey({ key = "b" })
    )
  ),
  -- Close without saving
  {
    mods = "CMD|SHIFT",
    key = "b",
    k.vim_action(
      act.Multiple({
        act.SendKey({ key = "\x1b" }), -- escape
        k.multiple_actions(":bd!"), -- close buffer without saving
      }),
      act.SendKey({ key = "b", mods = "SHIFT" })
    ),
  },

  -- -- Change pane layout    -- -- Change to the next tmux window
  -- {
  --   mods = "CMD|SHIFT",
  --   key = "}",
  --   action = act.Multiple({
  --     act.SendKey({ mods = "CTRL", key = "b" }),
  --     act.SendKey({ key = "n" }),
  --   }),
  -- },
  -- -- Change to the previous tmux window
  -- {
  --   mods = "CMD|SHIFT",
  --   key = "{",
  --   action = act.Multiple({
  --     act.SendKey({ mods = "CTRL", key = "b" }),
  --     act.SendKey({ key = "p" }),
  --   }),
  -- },

  -- {
  --   mods = "CMD|SHIFT",
  --   key = ")",
  --   action = act.Multiple({
  --     act.SendKey({ mods = "CTRL", key = "b" }),
  --     act.SendKey({ key = "Space" }),
  --   }),
  -- },
  -- -- Rotate tmux panes
  -- {
  --   mods = "CMD",
  --   key = "[",
  --   action = act.Multiple({
  --     act.SendKey({ mods = "CTRL", key = "b" }),
  --     act.SendKey({ mods = "ALT", key = "o" }),
  --   }),
  -- },
  -- -- Switch to last active pane
  -- {
  --   mods = "CTRL",
  --   key = "\\",
  --   action = act.Multiple({
  --     act.SendKey({ mods = "CTRL", key = "b" }),
  --     act.SendKey({ key = ";" }),
  --   }),
  -- },
  -- -- switch to previous session
  -- {
  --   mods = "CMD|SHIFT",
  --   key = "j",
  --   action = act.Multiple({
  --     act.SendKey({ mods = "CTRL", key = "b" }),
  --     act.SendKey({ mods = "SHIFT", key = "l" }),
  --   }),
  -- },
  -- -- switch to previous sesh session (works after closing)
  -- {
  --   mods = "CMD",
  --   key = "l",
  --   action = act.Multiple({
  --     act.SendKey({ mods = "CTRL", key = "b" }),
  --     act.SendKey({ mods = "CTRL", key = "l" }),
  --   }),
  -- },
  -- -- rename tmux window
  -- {
  --   mods = "CMD|ALT",
  --   key = ",",
  --   action = act.Multiple({
  --     act.SendKey({ mods = "CTRL", key = "b" }),
  --     act.SendKey({ key = "," }),
  --   }),
  -- },
  --
  -- -- Detach session
  -- k.cmd_to_tmux_prefix("D", "d"),
  -- -- Split the current pane into two, top and bottom
  -- k.cmd_to_tmux_prefix("e", '"'),
  -- -- Split the current pane into two, left and right
  -- k.cmd_to_tmux_prefix("E", "%"),
  -- -- Toggle Neotree (file tree) via tmux y keybind
  -- k.cmd_to_tmux_prefix("f", "y"),
  -- -- Open lazygit in a new tmux window
  -- k.cmd_to_tmux_prefix("g", "g"),
  -- -- Jump to new/existing window via sesh
  -- -- https://github.com/joshmedeski/sesh
  -- k.cmd_to_tmux_prefix("j", "t"),
  -- -- switch to previous session
  -- -- k.cmd_to_tmux_prefix("J", "L"),
  -- -- Open yazi in a new tmux window
  -- k.cmd_to_tmux_prefix("y", "A"),
  -- -- Open URLs 'joshmedeski/tmux-fzf-url'
  -- k.cmd_to_tmux_prefix("o", "u"),
  -- -- Find files with Telescope, with grep, including hidden, ignoring .git via tmux Y keybind
  -- k.cmd_to_tmux_prefix("p", "Y"),
  -- -- Create a new tmux window/tab
  -- k.cmd_to_tmux_prefix("t", "c"),
  -- --Break the current tmux pane out of the tmux window
  -- k.cmd_to_tmux_prefix("T", "!"),
  -- -- Kill/close the current tmux pane (and window if last pane)
  -- k.cmd_to_tmux_prefix("w", "x"),
  -- -- Toggle the zoom state of the current tmux pane
  -- k.cmd_to_tmux_prefix("z", "z"),
  -- -- Cycle through tmux panes
  -- k.cmd_to_tmux_prefix("]", "o"),
  -- -- tmux-fuzzback (search scrollback with fuzzy finder)
  -- k.cmd_to_tmux_prefix("/", "b"),
  -- -- Open tmux command input
  -- k.cmd_to_tmux_prefix(";", ":"),
  -- -- Rename the current tmux session
  -- k.cmd_to_tmux_prefix(",", "$"),
  -- -- Type <escape>:w<enter> to save current buffer in Neovim/Vim
  -- k.cmd_to_tmux_prefix("'", "s"),
  -- -- Use arrow keys to jump to a pane in the relevant direction
  -- k.cmd_to_tmux_prefix("UpArrow", "UpArrow"),
  -- k.cmd_to_tmux_prefix("DownArrow", "DownArrow"),
  -- k.cmd_to_tmux_prefix("LeftArrow", "LeftArrow"),
  -- k.cmd_to_tmux_prefix("RightArrow", "RightArrow"),

  -- Delete word/line
  k.cmd_key("Backspace", act.SendKey({ key = "\x15" })),
  k.cmd_key("j", workspace_switcher.switch_workspace()),
  {
    key = "Tab",
    mods = "CTRL",
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = "Tab",
    mods = "CTRL|SHIFT",
    action = wezterm.action.DisableDefaultAssignment,
  },
  k.cmd_key("c", wezterm.action.ActivateCopyMode),
  k.cmd_key("g", sc.lazygit),
  k.cmd_key("y", sc.yazi),
}

return keys
