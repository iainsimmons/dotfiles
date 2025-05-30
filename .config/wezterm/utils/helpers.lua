-- https://github.com/joshmedeski/dotfiles/blob/main/.config/wezterm/utils/helpers.lua
local wezterm = require("wezterm") --[[@as Wezterm]]
local M = {}

local appearance = wezterm.gui.get_appearance()

M.is_dark = function()
  return appearance:find("Dark")
end

M.get_random_entry = function(tbl)
  local keys = {}
  for key, _ in ipairs(tbl) do
    table.insert(keys, key)
  end
  local randomKey = keys[math.random(1, #keys)]
  return tbl[randomKey]
end

return M
