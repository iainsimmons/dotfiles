local wezterm = require("wezterm") --[[@as Wezterm]]
local M = {}

M.fonts = {
  "CommitMono",
  -- "Iosevka Term",
  "JetBrains Mono", -- default font for WezTerm
}

M.get_font = function(weight)
  local _weight = weight or "Regular"
  local font_table = {}
  for _, font in ipairs(M.fonts) do
    table.insert(font_table, { family = font, weight = _weight })
  end
  return wezterm.font_with_fallback(font_table)
end

return M
