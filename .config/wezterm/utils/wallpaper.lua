-- based on https://github.com/joshmedeski/dotfiles/blob/main/.config/wezterm/utils/wallpaper.lua
local wezterm = require("wezterm") --[[@as Wezterm]]
local h = require("utils/helpers")
local M = {}

M.get_wallpaper = function()
  local wallpapers = {}
  local wallpapers_glob = os.getenv("HOME") .. "/Pictures/wallpapers/**"
  for _, v in ipairs(wezterm.glob(wallpapers_glob)) do
    if not string.match(v, "%.DS_Store$") then
      table.insert(wallpapers, v)
    end
  end
  local wallpaper = h.get_random_entry(wallpapers)
  return {
    source = { File = { path = wallpaper } },
    height = "Cover",
    width = "Cover",
    horizontal_align = "Left",
    repeat_x = "NoRepeat",
    repeat_y = "NoRepeat",
    opacity = 1,
    hsb = {
      brightness = 0.05,
    },
    -- speed = 200,
  }
end

return M
