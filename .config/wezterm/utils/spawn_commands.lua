local wt_action = require("wezterm").action
local M = {}

M.lazygit = wt_action.SpawnCommandInNewTab({
  args = { "lazygit" },
})

M.yazi = wt_action.SpawnCommandInNewTab({
  args = { "yazi" },
})

return M
