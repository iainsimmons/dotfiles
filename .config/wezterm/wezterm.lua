local wezterm = require("wezterm")
local wez_dir = os.getenv("HOME") .. "/.config/wezterm"
local act = wezterm.action

local function get_random_entry(tbl)
	local keys = {}
	for key, _ in ipairs(tbl) do
		table.insert(keys, key)
	end
	local randomKey = keys[math.random(1, #keys)]
	return tbl[randomKey]
end

local function get_wallpaper()
	local wallpapers = {}
	local wallpapers_glob = os.getenv("HOME") .. "/Pictures/Wallpapers/**"

	for _, v in ipairs(wezterm.glob(wallpapers_glob)) do
		table.insert(wallpapers, v)
	end
	return {
		source = { File = { path = get_random_entry(wallpapers) } },
		height = "100%",
		horizontal_align = "Center",
		opacity = 1,
	}
end

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
	-- debug_key_events = true,
	color_scheme = "Tokyo Night",
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
		left = 16,
		right = 16,
		top = 16,
		bottom = 16,
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
}

return config

-- local wezterm = require("wezterm")
-- local act = wezterm.action
--
-- return {
-- 	color_scheme = "synthwave-everything",
-- 	default_cwd = "~/dev/",
-- 	enable_scroll_bar = true,
-- 	font = wezterm.font("Hack Nerd Font Mono", { style = "Normal" }),
-- 	font_size = 20.0,
-- 	use_dead_keys = false,
-- 	window_background_opacity = 0.85,
-- 	keys = {
-- 		{ key = "e", mods = "CMD", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
-- 		{ key = "e", mods = "CMD|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
-- 		{ key = "UpArrow", mods = "CMD", action = act.ActivatePaneDirection("Up") },
-- 		{ key = "DownArrow", mods = "CMD", action = act.ActivatePaneDirection("Down") },
-- 		{ key = "RightArrow", mods = "CMD", action = act.ActivatePaneDirection("Right") },
-- 		{ key = "LeftArrow", mods = "CMD", action = act.ActivatePaneDirection("Left") },
-- 		{ key = "w", mods = "CMD", action = act.CloseCurrentPane },
-- 		{ key = "W", mods = "CMD|SHIFT", action = act.CloseCurrentTab({ confirm = true }) },
-- 		{ key = "z", mods = "CMD", action = act.TogglePaneZoomState },
-- 		-- Move left by word
-- 		{
-- 			key = "LeftArrow",
-- 			mods = "OPT",
-- 			action = act.SendKey({
-- 				key = "b",
-- 				mods = "ALT",
-- 			}),
-- 		},
-- 		-- Move right by word
-- 		{
-- 			key = "RightArrow",
-- 			mods = "OPT",
-- 			action = act.SendKey({ key = "f", mods = "ALT" }),
-- 		},
-- 		-- -- Type <escape>:w<enter> to save current buffer in Neovim
-- 		-- {
-- 		-- 	key = "s",
-- 		-- 	mods = "CMD",
-- 		-- 	action = act.SendString("\x1b:w\n"),
-- 		-- 	-- action = act.Multiple({
-- 		-- 	-- 	act.SendKey({ key = "Escape" }),
-- 		-- 	-- 	act.SendKey({ key = ":", mods = "SHIFT" }),
-- 		-- 	-- 	act.SendKey({ key = "w" }),
-- 		-- 	-- 	act.SendKey({ key = "Enter" }),
-- 		-- 	-- }),
-- 		-- },
-- 		-- Find files with Telescope, with grep, including hidden, ignoring .git
-- 		-- {
-- 		-- 	key = "p",
-- 		-- 	mods = "CMD",
-- 		-- 	action = act.SendString(
-- 		-- 		':lua require\'telescope.builtin\'.find_files{find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },}\n'
-- 		-- 	),
-- 		-- },
-- 		-- -- Close current buffer in Neovim
-- 		-- { key = "b", mods = "CMD", action = act.SendString(":bd\n") },
-- 		-- Rename the current tmux window
-- 		--  {  key = "Comma", mods = "CMD", action = "\x02," }
-- 		--     -- Open lazygit
-- 		--  {  key = "G", mods = "CMD", action = "\x02g" }
-- 		--     -- Select a new tmux session for the attached client interactively
-- 		--  {  key = "Apostrophe", mods = "CMD", action = "\x02s" }
-- 		--     -- Select window 1-9
-- 		--  {  key = "Key1", mods = "CMD", action = "\x021" }
-- 		--  {  key = "Key2", mods = "CMD", action = "\x022" }
-- 		--  {  key = "Key3", mods = "CMD", action = "\x023" }
-- 		--  {  key = "Key4", mods = "CMD", action = "\x024" }
-- 		--  {  key = "Key5", mods = "CMD", action = "\x025" }
-- 		--  {  key = "Key6", mods = "CMD", action = "\x026" }
-- 		--  {  key = "Key7", mods = "CMD", action = "\x027" }
-- 		--  {  key = "Key8", mods = "CMD", action = "\x028" }
-- 		--  {  key = "Key9", mods = "CMD", action = "\x029" }
-- 		--     -- Change pane layout
-- 		--  {  key = "L", mods = "CMD", action = "\x02\x20" }
-- 		--     -- Detach session
-- 		--  {  key = "D", mods = "CMD"|Shift, action = "\x02d" }
-- 		--  {  key = "Q", mods = "CMD", action = "\x02d" }
-- 		--     -- Open tmux command input
-- 		--  {  key = "Semicolon", mods = "CMD", action = "\x02:" }
-- 		--     -- Create a new tmux window/tab
-- 		--  {  key = "T", mods = "CMD", action = "\x02c" }
-- 		--     -- Break the current tmux pane out of the tmux window
-- 		--  {  key = "T", mods = "CMD"|Shift, action = "\x02!" }
-- 		--     -- tmux copy mode
-- 		--  {  key = "C", mods = "CMD", action = "\x02[" }
-- 		--     -- tmux paste buffer
-- 		--  {  key = "V", mods = "CMD", action = "\x02P" }
-- 		--     -- Change to the previous tmux window
-- 		--  {  key = "LBracket", mods = "CMD"|Shift, action = "\x02p" }
-- 		--     -- Change to the next tmux window
-- 		--  {  key = "RBracket", mods = "CMD"|Shift, action = "\x02n" }
-- 		--     -- These all just cycle through all panes
-- 		--     -- I couldn't figure out how to get it to cycle backwards/in reverse
-- 		--  {  key = "LBracket", mods = "CMD", action = "\x02o" }
-- 		--  {  key = "RBracket", mods = "CMD", action = "\x02o" }
-- 		--  {  key = "PageDown", mods = "CMD", action = "\x02o" }
-- 		--  {  key = "PageUp", mods = "CMD", action = "\x02o" }
-- 		--     -- Move between words
-- 		--  {  key = "Left", mods = "Alt", action = "\eb" }   -- one word left
-- 		--  {  key = "Right", mods = "Alt", action = "\ef" }   -- one word right
-- 		--  {  key = "Back", mods = "Super", action = "\x15" }   -- delete word/line
-- 		--     -- Send Tab and modifier keys for cycling Neovim buffers
-- 		--  {  key = "Tab", mods = "Control", action = "\x1b[9;5u" }
-- 		--  {  key = "Tab", mods = "Control"|Shift, action = "\x1b[9;6u" }
-- 	},
-- }
