-- visualise and branch undo history
return {
  "mbbill/undotree",
  cmd = {
    "UndotreeToggle",
  },
  keys = {
    { "<F5>", ":UndotreeToggle<CR>", desc = "Undotree Toggle" },
  },
}
