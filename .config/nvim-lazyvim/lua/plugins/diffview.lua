return {
  "sindrets/diffview.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewRefresh",
  },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "[G]it [D]iffview open" },
    { "<leader>gx", "<cmd>DiffviewClose<cr>", desc = "[G]it [D]iffview close" },
  },
}
