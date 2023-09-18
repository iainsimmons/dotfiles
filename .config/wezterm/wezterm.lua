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

local function multiple_actions(keys)
	local actions = {}
	for key in keys:gmatch(".") do
		table.insert(actions, act.SendKey({ key = key }))
	end
	table.insert(actions, act.SendKey({ key = "\n" }))
	return act.Multiple(actions)
end

local function key_table(mods, key, action)
	return {
		mods = mods,
		key = key,
		action = action,
	}
end

local function cmd_key(key, action)
	return key_table("CMD", key, action)
end

local function cmd_tmux_key(key, tmux_key)
	return cmd_key(
		key,
		act.Multiple({
			act.SendKey({ mods = "CTRL", key = "b" }),
			act.SendKey({ key = tmux_key }),
		})
	)
end

local config = {
	term = "wezterm",
	-- debug_key_events = true,
	color_scheme = "Tinacious Design (Dark)",
	-- color_scheme = "Monokai Remastered",
	font = wezterm.font_with_fallback({
		{
			family = "JetBrainsMonoNL Nerd Font Mono",
			weight = "Light",
		},
	}),
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
	window_background_gradient = {
		colors = { "#241b2f", "#1C072D" },
		blend = "Oklab",
		interpolation = "CatmullRom",
		noise = 72,
		segment_size = 20,
		segment_smoothness = 1.0,
		orientation = {
			Radial = {
				radius = 0.75,
			},
		},
	},
	disable_default_key_bindings = true,
	keys = {
		cmd_key(
			"s",
			act.Multiple({
				act.SendKey({ key = "\x1b" }), -- escape
				multiple_actions(":w"),
			})
		),

		cmd_key("v", act.PasteFrom("Clipboard")),
		cmd_key("-", act.DecreaseFontSize),
		cmd_key("=", act.IncreaseFontSize),
		cmd_key("0", act.ResetFontSize),

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
		cmd_tmux_key("1", "1"),
		cmd_tmux_key("2", "2"),
		cmd_tmux_key("3", "3"),
		cmd_tmux_key("4", "4"),
		cmd_tmux_key("5", "5"),
		cmd_tmux_key("6", "6"),
		cmd_tmux_key("7", "7"),
		cmd_tmux_key("8", "8"),
		cmd_tmux_key("9", "9"),
		-- Close current buffer in Neovim via tmux a keybind
		cmd_tmux_key("b", "a"),
		-- Change to tmux copy mode
		cmd_tmux_key("c", "["),
		-- Detach session
		cmd_tmux_key("D", "d"),
		-- Split the current pane into two, top and bottom
		cmd_tmux_key("e", '"'),
		-- Split the current pane into two, left and right
		cmd_tmux_key("E", "%"),
		-- Toggle Neotree (file tree) via tmux y keybind
		cmd_tmux_key("f", "y"),
		-- Open lazygit in a new tmux window
		cmd_tmux_key("g", "g"),
		-- Jump to new/existing window via 't'
		-- Based on https://github.com/joshmedeski/t-smart-tmux-session-manage
		cmd_tmux_key("j", "t"),
		-- Open lf in a new tmux window
		cmd_tmux_key("l", "A"),
		-- Open URLs 'joshmedeski/tmux-fzf-url'
		cmd_tmux_key("o", "u"),
		-- Find files with Telescope, with grep, including hidden, ignoring .git via tmux Y keybind
		cmd_tmux_key("p", "Y"),
		-- Create a new tmux window/tab
		cmd_tmux_key("t", "c"),
		--Break the current tmux pane out of the tmux window
		cmd_tmux_key("T", "!"),
		-- Kill/close the current tmux pane (and window if last pane)
		cmd_tmux_key("w", "x"),
		-- Toggle the zoom state of the current tmux pane
		cmd_tmux_key("z", "z"),
		-- Cycle through tmux panes
		cmd_tmux_key("]", "o"),
		-- tmux-fuzzback (search scrollback with fuzzy finder)
		cmd_tmux_key("/", "b"),
		-- Open tmux command input
		cmd_tmux_key(";", ":"),
		-- Rename the current tmux window
		cmd_tmux_key(",", ","),
		-- Type <escape>:w<enter> to save current buffer in Neovim/Vim
		cmd_tmux_key("'", "s"),
		-- Use arrow keys to jump to a pane in the relevant direction
		cmd_tmux_key("UpArrow", "UpArrow"),
		cmd_tmux_key("DownArrow", "DownArrow"),
		cmd_tmux_key("LeftArrow", "LeftArrow"),
		cmd_tmux_key("RightArrow", "RightArrow"),

		-- Delete word/line
		cmd_key("Backspace", act.SendKey({ key = "\x15" })),
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
