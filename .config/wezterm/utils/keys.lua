local wezterm = require("wezterm")
local wt_action = wezterm.action
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

local M = {}

M.multiple_actions = function(keys)
  local actions = {}
  for key in keys:gmatch(".") do
    table.insert(actions, wt_action.SendKey({ key = key }))
  end
  table.insert(actions, wt_action.SendKey({ key = "\n" }))
  return wt_action.Multiple(actions)
end

M.key_table = function(mods, key, action)
  return {
    mods = mods,
    key = key,
    action = action,
  }
end

M.cmd_key = function(key, action)
  return M.key_table("CMD", key, action)
end

M.cmd_to_tmux_prefix = function(key, tmux_key)
  return M.cmd_key(
    key,
    wt_action.Multiple({
      wt_action.SendKey({ mods = "CTRL", key = "b" }),
      wt_action.SendKey({ key = tmux_key }),
    })
  )
end

M.vim_action = function(action, fallback)
  return wezterm.action_callback(function(win, pane)
    if is_vim(pane) then
      win:perform_action(action, pane)
    else
      win:perform_action(fallback, pane)
    end
  end)
end

M.nvim_action = function(action, fallback)
  return wezterm.action_callback(function(win, pane)
    if is_nvim(pane) then
      win:perform_action(action, pane)
    else
      win:perform_action(fallback, pane)
    end
  end)
end

return M
