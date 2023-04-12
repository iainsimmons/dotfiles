return {
  {
    "mechatroner/rainbow_csv", -- modify and query CSV files
    ft = {
      "csv",
      "tsv",
      "psv",
    },
  },
  {
    "ruifm/gitlinker.nvim",
    requires = "nvim-lua/plenary.nvim",
  },
  {
    "davidgranstrom/nvim-markdown-preview",
    ft = { "md", "markdown" },
    keys = {
      {
        "<leader>m",
        '<plug>(nvim-markdown-preview)',
        "n",
        desc = "Markdown Preview: Open preview in browser",
        silent = true,
      },
    },
  },
}
