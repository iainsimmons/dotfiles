local wt_font_with_fallback = require("wezterm").font_with_fallback
local M = {}

M.fonts = {
  "CommitMono",
  "Geist Mono",
  "JetBrainsMonoNL Nerd Font Mono",
}

M.get_font = function(weight)
  local _weight = weight or "Regular"
  local font_table = {}
  for _, font in ipairs(M.fonts) do
    table.insert(font_table, { family = font, weight = _weight })
  end
  return wt_font_with_fallback(font_table)
end

return M
