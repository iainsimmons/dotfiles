return {
  {
    "mechatroner/rainbow_csv", -- modify and query CSV files
    ft = {
      "csv",
      "tsv",
      "psv",
      "csv_pipe",
      "csv_semicolon",
    },
    config = function()
      vim.g.disable_rainbow_hover = 1
    end,
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
        "<plug>(nvim-markdown-preview)",
        "n",
        desc = "Markdown Preview: Open preview in browser",
        silent = true,
      },
    },
  },
  { "kevinhwang91/nvim-bqf", ft = { "qf" } },
  {
    "nat-418/boole.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      mappings = {
        increment = "<C-a>",
        decrement = "<C-x>",
      },
    },
  },
  {
    "tpope/vim-abolish",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("which-key").register({
        cr = {
          name = "+coercion",
          s = { desc = "Snake Case" },
          _ = { desc = "Snake Case" },
          m = { desc = "Mixed Case" },
          c = { desc = "Camel Case" },
          u = { desc = "Snake Upper Case" },
          U = { desc = "Snake Upper Case" },
          k = { desc = "Kebab Case" },
          t = { desc = "Title Case (not reversible)" },
          ["-"] = { desc = "Kebab Case (not reversible)" },
          ["."] = { desc = "Dot Case (not reversible)" },
          ["<space>"] = { desc = "Space Case (not reversible)" },
        },
      })
    end,
  },
  {
    "afreakk/unimpaired-which-key.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "tpope/vim-unimpaired" },
    config = function()
      local wk = require("which-key")
      local uwk = require("unimpaired-which-key")
      wk.register(uwk.normal_mode)
      wk.register(uwk.normal_and_visual_mode, { mode = { "n", "v" } })
    end,
  },
  {
    "tzachar/highlight-undo.nvim",
    event = { "VeryLazy" },
    opts = {
      duration = 300,
      undo = {
        hlgroup = "HighlightUndo",
        mode = "n",
        lhs = "u",
        map = "undo",
        opts = {},
      },
      redo = {
        hlgroup = "HighlightUndo",
        mode = "n",
        lhs = "<C-r>",
        map = "redo",
        opts = {},
      },
      highlight_for_count = true,
    },
  },
}
