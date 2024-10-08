local k = require("utils/keys")
local f = require("utils/font")
local w = require("utils/wallpaper")
local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

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
  -- Spawn a fish shell in login mode
  default_prog = { "/opt/homebrew/bin/fish", "-l" },
  enable_scroll_bar = false,
  use_dead_keys = false,
  window_padding = {
    left = "6px",
    right = "2px",
    top = "8px",
    bottom = "2px",
  },
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
  disable_default_key_bindings = true,
  keys = {
    {
      key = "L",
      mods = "CTRL|SHIFT",
      action = act.ShowDebugOverlay,
    },
    k.cmd_key(
      "s",
      act.Multiple({
        act.SendKey({ key = "\x1b" }), -- escape
        k.multiple_actions(":w"),
      })
    ),

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
      action = wezterm.action.ReloadConfiguration,
    },
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
    -- Toggle Neotree (file tree) via tmux y keybind
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

    -- Delete word/line
    k.cmd_key("Backspace", act.SendKey({ key = "\x15" })),
  },

  send_composed_key_when_left_alt_is_pressed = false,
  send_composed_key_when_right_alt_is_pressed = false,
  adjust_window_size_when_changing_font_size = false,
  enable_tab_bar = false,
  native_macos_fullscreen_mode = false,
  window_decorations = "RESIZE",
  scrollback_lines = 5000,
}

return config
