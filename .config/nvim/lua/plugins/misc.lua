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
    dependencies = "nvim-lua/plenary.nvim",
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
  {
    "TobinPalmer/rayso.nvim",
    cmd = "Rayso",
    opts = {
      open_cmd = "Arc",
      options = {
        background = true, -- If the screenshot should have a background.
        dark_mode = true, -- If the screenshot should be in dark mode.
        logging_path = "", -- Path to create a log file in.
        logging_file = "rayso", -- Name of log file, will be a markdown file, ex rayso.md.
        logging_enabled = false, -- If you enable the logging file.
        padding = 32, -- The default padding that the screenshot will have.
        theme = "raindrop", -- Theme
      },
    },
    keys = {
      {
        "<leader>rs",
        ":Rayso<cr>",
        desc = "Share with Ray.so",
        silent = true,
        mode = { "n", "v" },
      },
    },
  },
}
