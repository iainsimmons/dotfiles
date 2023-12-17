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
  color_scheme = "Tinacious Design (Dark)",
  -- color_scheme = "Monokai Remastered",
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
  default_cwd = "~/dev/",
  enable_scroll_bar = true,
  use_dead_keys = false,
  window_padding = {
    left = 12,
    right = 12,
    top = 12,
    bottom = 12,
  },
  background = {
    w.get_wallpaper(),
    -- {
    --   source = {
    --     Gradient = {
    --       colors = { "#241b2f", "#1C072D" },
    --       blend = "Oklab",
    --       interpolation = "CatmullRom",
    --       noise = 64,
    --       segment_size = 20,
    --       segment_smoothness = 1.0,
    --       orientation = { Linear = { angle = 90.0 } },
    --     },
    --   },
    --   width = "100%",
    --   height = "100%",
    --   opacity = 0.8,
    -- },
    {
      source = {
        Color = "#000",
      },
      width = "100%",
      height = "100%",
      opacity = 0.1,
    },
  },
  disable_default_key_bindings = true,
  keys = {
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
    -- Jump to new/existing window via 't'
    -- Based on https://github.com/joshmedeski/t-smart-tmux-session-manage
    k.cmd_to_tmux_prefix("j", "t"),
    -- Open lf in a new tmux window
    k.cmd_to_tmux_prefix("l", "A"),
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
    -- Rename the current tmux window
    k.cmd_to_tmux_prefix(",", ","),
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
